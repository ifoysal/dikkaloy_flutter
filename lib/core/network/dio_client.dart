import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:livemcq3/core/constants/app_constants.dart';
import 'package:livemcq3/core/constants/api_constants.dart';
import 'package:livemcq3/core/storage/secure_storage.dart';

class DioClient {
  late final Dio dio;
  final SecureStorage secureStorage;

  DioClient({required this.secureStorage}) {
    dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(milliseconds: AppConstants.connectTimeoutMs),
      receiveTimeout: const Duration(milliseconds: AppConstants.receiveTimeoutMs),
      sendTimeout: const Duration(milliseconds: AppConstants.sendTimeoutMs),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ));

    dio.interceptors.add(ApiInterceptor(secureStorage: secureStorage));

    final adapter = IOHttpClientAdapter();
    adapter.onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (cert, host, port) => false;
      return client;
    };
    dio.httpClientAdapter = adapter;
  }
}

class ApiInterceptor extends Interceptor {
  final SecureStorage secureStorage;

  ApiInterceptor({required this.secureStorage});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await secureStorage.readToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await secureStorage.deleteToken();
    }

    // Forward the original error so callers can read the real backend
    // response (e.g. BDApps diagnostic messages) instead of a generic one.
    handler.next(err);
  }
}
