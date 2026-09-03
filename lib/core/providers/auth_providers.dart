import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/providers/app_providers.dart';
import 'package:livemcq3/core/storage/secure_storage.dart';
import 'package:livemcq3/data/models/user_model.dart';
import 'package:livemcq3/data/repositories/auth_repository.dart';
import 'dart:async';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(dioClientProvider));
});

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AsyncValue<UserModel?>>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider), ref.watch(secureStorageProvider));
});

final otpStateProvider = StateProvider<OtpState>((ref) => const OtpState.idle());

enum OtpStatus { idle, loading, verified, error }

class OtpState {
  final OtpStatus status;
  final String? message;

  const OtpState.idle()
      : status = OtpStatus.idle,
        message = null;

  const OtpState.loading()
      : status = OtpStatus.loading,
        message = null;

  const OtpState.verified()
      : status = OtpStatus.verified,
        message = null;

  const OtpState.error(this.message)
      : status = OtpStatus.error;

  bool get isLoading => status == OtpStatus.loading;
  bool get isVerified => status == OtpStatus.verified;
  bool get isError => status == OtpStatus.error;
}

class AuthNotifier extends StateNotifier<AsyncValue<UserModel?>> {
  final AuthRepository _repo;
  final SecureStorage _storage;

  AuthNotifier(this._repo, this._storage) : super(const AsyncValue.data(null)) {
    checkAuth();
  }

  Future<void> checkAuth() async {
    final token = await _storage.readToken();
    if (token == null) {
      state = const AsyncValue.data(null);
      return;
    }
    state = const AsyncValue.loading();
    try {
      final user = await _repo.me().timeout(const Duration(seconds: 10));
      state = AsyncValue.data(user);
    } on TimeoutException catch (_) {
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final auth = await _repo.login(email, password);
      await _storage.writeToken(auth.token);
      return auth.user;
    });
  }

  Future<void> register(String name, String email, String password, {String? phone}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final auth = await _repo.register(name, email, password, phone: phone);
      await _storage.writeToken(auth.token);
      return auth.user;
    });
  }

  Future<void> sendOtp(String phone) async {
    state = const AsyncValue.loading();
    try {
      await _repo.sendOtp(phone);
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  Future<void> verifyOtp(String phone, String otp) async {
    state = const AsyncValue.loading();
    try {
      final verified = await _repo.verifyOtp(phone, otp);
      if (verified) {
        state = const AsyncValue.data(null);
      } else {
        state = AsyncValue.error('OTP verification failed', StackTrace.current);
      }
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      await _repo.logout();
    } catch (_) {}
    await _storage.clear();
    state = const AsyncValue.data(null);
  }

  Future<void> registerFcmToken(String token, String platform) async {
    await _repo.registerFcmToken(token, platform);
  }

  Future<Map<String, dynamic>> getNotificationPreferences() async {
    return _repo.getNotificationPreferences();
  }

  Future<Map<String, dynamic>> updateNotificationPreferences(Map<String, dynamic> preferences) async {
    return _repo.updateNotificationPreferences(preferences);
  }

  Future<void> updateProfile(Map<String, dynamic> updates) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = await _repo.updateProfile(updates);
      return user;
    });
  }

  Future<void> deleteAccount() async {
    state = const AsyncValue.loading();
    try {
      await _repo.deleteAccount();
    } catch (_) {}
    await _storage.clear();
    state = const AsyncValue.data(null);
  }
}
