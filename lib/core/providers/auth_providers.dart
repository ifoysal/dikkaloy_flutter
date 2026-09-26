import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/providers/app_providers.dart';
import 'package:livemcq3/core/storage/secure_storage.dart';
import 'package:livemcq3/data/models/user_model.dart';
import 'package:livemcq3/data/repositories/auth_repository.dart';
import 'dart:async';

/// Result of requesting a BDApps DCB OTP for phone-based login.
class DcbOtpRequestResult {
  final bool alreadyLoggedIn;

  const DcbOtpRequestResult({required this.alreadyLoggedIn});
}

String _dcbErrorMessage(Object e, String fallback) {
  if (e is DioException) {
    final data = e.response?.data;
    if (data is Map && data['message'] is String) return data['message'] as String;
  }
  return fallback;
}

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

  /// Validates that [phone] belongs to Robi/Airtel. Returns the backend's
  /// Bengali message on both success and failure.
  Future<Map<String, dynamic>> checkOperator(String phone) async {
    try {
      return await _repo.checkOperator(phone);
    } on DioException catch (e) {
      final data = e.response?.data;
      if (data is Map<String, dynamic>) return data;
      rethrow;
    }
  }

  /// Requests a BDApps OTP for [phone]. When the number already has an
  /// active BDApps subscription, the backend logs the user in immediately
  /// and this returns [DcbOtpRequestResult.alreadyLoggedIn] = true.
  Future<DcbOtpRequestResult> requestDcbOtp(String phone) async {
    state = const AsyncValue.loading();
    try {
      final res = await _repo.requestDcbOtp(phone);
      final loggedInNow = res['already_subscribed'] == true || res['direct_login'] == true;
      if (loggedInNow) {
        final data = res['data'] as Map<String, dynamic>;
        await _storage.writeToken(data['token'] as String);
        state = AsyncValue.data(UserModel.fromJson(data['user'] as Map<String, dynamic>));
        return const DcbOtpRequestResult(alreadyLoggedIn: true);
      }
      if (res['success'] != true) {
        throw Exception(res['message'] ?? 'কোড পাঠাতে ব্যর্থ হয়েছে');
      }
      state = const AsyncValue.data(null);
      return const DcbOtpRequestResult(alreadyLoggedIn: false);
    } catch (e) {
      state = const AsyncValue.data(null);
      throw Exception(_dcbErrorMessage(e, e is Exception ? e.toString().replaceFirst('Exception: ', '') : 'কোড পাঠাতে ব্যর্থ হয়েছে'));
    }
  }

  /// Verifies the BDApps OTP for [phone] and logs the user in.
  Future<void> verifyDcbOtp(String phone, String otp) async {
    state = const AsyncValue.loading();
    try {
      final res = await _repo.verifyDcbOtp(phone, otp);
      if (res['success'] != true) {
        throw Exception(res['message'] ?? 'ভুল ওটিপি কোড');
      }
      final data = res['data'] as Map<String, dynamic>;
      await _storage.writeToken(data['token'] as String);
      state = AsyncValue.data(UserModel.fromJson(data['user'] as Map<String, dynamic>));
    } catch (e) {
      state = const AsyncValue.data(null);
      throw Exception(_dcbErrorMessage(e, e is Exception ? e.toString().replaceFirst('Exception: ', '') : 'যাচাই ব্যর্থ হয়েছে'));
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

  /// Cancels the caller's active BDApps carrier-billing subscription, same
  /// as the "সাবস্ক্রিপশন বাতিল করুন" flow on the website. On success the
  /// backend also invalidates the session, so this logs the user out too.
  Future<String> unsubscribeCarrierBilling() async {
    try {
      final status = await _repo.getCarrierBillingStatus();
      final subscriptionId = status?['id'] as int?;
      if (subscriptionId == null) {
        throw Exception('কোনো সক্রিয় সাবস্ক্রিপশন পাওয়া যায়নি।');
      }

      final res = await _repo.unsubscribeCarrierBilling(subscriptionId);
      if (res['success'] != true) {
        throw Exception(res['message'] ?? 'বাতিল করতে সমস্যা হয়েছে। আবার চেষ্টা করুন।');
      }

      await _storage.clear();
      state = const AsyncValue.data(null);
      return res['message'] as String? ?? 'আপনার সাবস্ক্রিপশন সফলভাবে বাতিল করা হয়েছে।';
    } catch (e) {
      throw Exception(_dcbErrorMessage(e, e is Exception ? e.toString().replaceFirst('Exception: ', '') : 'বাতিল করতে সমস্যা হয়েছে। আবার চেষ্টা করুন।'));
    }
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
