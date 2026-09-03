import 'dart:io';
import 'package:dio/dio.dart';
import 'package:livemcq3/core/constants/app_constants.dart';
import 'package:livemcq3/core/constants/api_constants.dart';
import 'package:livemcq3/core/errors/exceptions.dart';
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

    (dio.httpClientAdapter as dynamic).onHttpClientCreate = (client) {
      client.badCertificateCallback = (cert, host, port) => false;
      return client;
    };
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
      throw AuthException('Unauthorized');
    }

    final url = err.requestOptions.uri.toString();
    throw NetworkException('Network error: unable to reach $url. '
        'Ensure API_BASE_URL is correct and the backend is running.');
  }
}
