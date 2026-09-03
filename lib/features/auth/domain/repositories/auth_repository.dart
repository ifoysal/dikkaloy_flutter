import 'package:equatable/equatable.dart';
import 'package:livemcq3/features/auth/domain/entities/user.dart';
import 'package:livemcq3/features/auth/domain/entities/auth_result.dart';
import 'package:livemcq3/features/auth/data/models/login_request.dart';
import 'package:livemcq3/features/auth/data/models/register_request.dart';

abstract class AuthRepository {
  Future<AuthResult> login(LoginRequest request);
  Future<AuthResult> register(RegisterRequest request);
  Future<void> logout();
  Future<User> me();
  Future<void> sendOtp(String phone);
  Future<void> verifyOtp(String phone, String otp);
}
