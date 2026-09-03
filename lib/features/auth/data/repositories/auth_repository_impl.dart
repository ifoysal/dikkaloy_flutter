import 'package:dio/dio.dart';
import 'package:livemcq3/core/constants/api_constants.dart';
import 'package:livemcq3/core/errors/exceptions.dart';
import 'package:livemcq3/core/storage/secure_storage.dart';
import 'package:livemcq3/features/auth/data/models/login_request.dart';
import 'package:livemcq3/features/auth/data/models/register_request.dart';
import 'package:livemcq3/features/auth/data/models/user_model.dart';
import 'package:livemcq3/features/auth/domain/entities/user.dart';
import 'package:livemcq3/features/auth/domain/entities/auth_result.dart';
import 'package:livemcq3/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio dio;
  final SecureStorage secureStorage;

  AuthRepositoryImpl(this.dio, {required this.secureStorage});

  @override
  Future<AuthResult> login(LoginRequest request) async {
    final response = await dio.post(ApiConstants.authLogin, data: request.toJson());
    final data = response.data['data'] as Map<String, dynamic>;
    final token = data['token'] as String;
    await secureStorage.writeToken(token);
    return AuthResult(user: User.fromModel(UserModel.fromJson(data['user'])), token: token);
  }

  @override
  Future<AuthResult> register(RegisterRequest request) async {
    final response = await dio.post(ApiConstants.authRegister, data: request.toJson());
    final data = response.data['data'] as Map<String, dynamic>;
    final token = data['token'] as String;
    await secureStorage.writeToken(token);
    return AuthResult(user: User.fromModel(UserModel.fromJson(data['user'])), token: token);
  }

  @override
  Future<void> logout() async {
    try {
      await dio.post(ApiConstants.authLogout);
    } finally {
      await secureStorage.deleteToken();
    }
  }

  @override
  Future<User> me() async {
    final response = await dio.get(ApiConstants.authMe);
    final data = response.data['data'] as Map<String, dynamic>;
    return UserModel.fromJson(data) as User;
  }

  @override
  Future<void> sendOtp(String phone) async {
    await dio.post(ApiConstants.smsSendOtp(), data: {'phone': phone});
  }

  @override
  Future<void> verifyOtp(String phone, String otp) async {
    await dio.post(ApiConstants.smsVerifyOtp(), data: {'phone': phone, 'otp': otp});
  }
}
