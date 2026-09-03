import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:livemcq3/features/auth/domain/entities/auth_result.dart';
import 'package:livemcq3/features/auth/domain/entities/user.dart';
import 'package:livemcq3/features/auth/domain/usecases/login.dart';
import 'package:livemcq3/features/auth/domain/usecases/logout.dart';
import 'package:livemcq3/features/auth/domain/usecases/register.dart';
import 'package:livemcq3/features/auth/domain/usecases/send_otp.dart';
import 'package:livemcq3/features/auth/domain/usecases/verify_otp.dart';
import 'package:livemcq3/features/auth/data/models/login_request.dart';
import 'package:livemcq3/features/auth/data/models/register_request.dart';
import 'package:livemcq3/core/providers/app_providers.dart';
part 'auth_provider.g.dart';

final loginProvider = Provider<Login>((ref) => Login(ref.read(authRepositoryProvider)));
final registerProvider = Provider<Register>((ref) => Register(ref.read(authRepositoryProvider)));
final logoutProvider = Provider<Logout>((ref) => Logout(ref.read(authRepositoryProvider)));
final sendOtpProvider = Provider<SendOtp>((ref) => SendOtp(ref.read(authRepositoryProvider)));
final verifyOtpProvider = Provider<VerifyOtp>((ref) => VerifyOtp(ref.read(authRepositoryProvider)));

@riverpod
class Auth extends _$Auth {
  @override
  FutureOr<AuthState> build() {
    return const AuthState.unauthenticated();
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await ref.read(loginProvider)(LoginRequest(email: email, password: password));
      return AuthState.authenticated(result.user);
    });
  }

  Future<void> register(String name, String email, String password, String confirmPassword) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (password != confirmPassword) throw Exception('Passwords do not match');
      final result = await ref.read(registerProvider)(RegisterRequest(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: confirmPassword,
      ));
      return AuthState.authenticated(result.user);
    });
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    await AsyncValue.guard(() async {
      await ref.read(logoutProvider)();
      return const AuthState.unauthenticated();
    });
  }

  Future<void> sendOtp(String phone) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(sendOtpProvider)(phone);
      return state.value ?? const AuthState.unauthenticated();
    });
  }

  Future<void> verifyOtp(String phone, String otp) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(verifyOtpProvider)(phone, otp);
      return state.value ?? const AuthState.unauthenticated();
    });
  }
}

class AuthState {
  final User? user;
  final bool isLoading;
  final String? errorMessage;

  const AuthState._({this.user, this.isLoading = false, this.errorMessage});

  const AuthState.authenticated(this.user) : isLoading = false, errorMessage = null;
  const AuthState.unauthenticated() : user = null, isLoading = false, errorMessage = null;
  const AuthState.loading([this.errorMessage]) : user = null, isLoading = true;
  const AuthState.error(this.errorMessage) : user = null, isLoading = false;
}
