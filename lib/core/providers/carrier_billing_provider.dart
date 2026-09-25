import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/data/repositories/carrier_billing_repository.dart';
import 'package:livemcq3/core/providers/app_providers.dart';
import 'package:livemcq3/core/providers/auth_providers.dart';

final carrierBillingRepositoryProvider = Provider<CarrierBillingRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return CarrierBillingRepository(dioClient);
});

enum CarrierBillingStatus { idle, loading, success, error }

class CarrierBillingState {
  final CarrierBillingStatus status;
  final String? message;
  final Map<String, dynamic>? subscriptionData;

  const CarrierBillingState._(this.status, this.message, this.subscriptionData);

  const CarrierBillingState.idle() : this._(CarrierBillingStatus.idle, null, null);
  const CarrierBillingState.loading() : this._(CarrierBillingStatus.loading, null, null);
  factory CarrierBillingState.success(String message) => CarrierBillingState._(CarrierBillingStatus.success, message, null);
  factory CarrierBillingState.error(String message) => CarrierBillingState._(CarrierBillingStatus.error, message, null);
  factory CarrierBillingState.data(Map<String, dynamic> subscriptionData) => CarrierBillingState._(CarrierBillingStatus.success, null, subscriptionData);

  bool get isLoading => status == CarrierBillingStatus.loading;
  bool get isError => status == CarrierBillingStatus.error;
  bool get isSuccess => status == CarrierBillingStatus.success;
}

class CarrierBillingNotifier extends StateNotifier<CarrierBillingState> {
  final CarrierBillingRepository _repo;
  final Ref _ref;

  CarrierBillingNotifier(this._repo, this._ref) : super(const CarrierBillingState.idle());

  Future<void> requestOtp(String phone) async {
    state = const CarrierBillingState.loading();
    try {
      await _repo.requestOtp(phone);
      state = CarrierBillingState.success('OTP ' + '\u09AA\u09BE\u09A0\u09BE\u09A8\u09CB' + ' \u09B9\u09AF\u09BC\u09C7\u099B\u09C7');
    } catch (e) {
      state = CarrierBillingState.error(e.toString());
    }
  }

  Future<void> verifyOtp(String phone, String otp) async {
    state = const CarrierBillingState.loading();
    try {
      final data = await _repo.verifyOtp(phone, otp);
      if (data['success'] == true) {
        final token = data['token'] as String?;
        if (token != null && token.isNotEmpty) {
          await _ref.read(secureStorageProvider).writeToken(token);
          await _ref.read(authNotifierProvider.notifier).checkAuth();
        }
        state = CarrierBillingState.success('\u09B8\u09BE\u09AC\u09B8\u09CD\u0995\u09CD\u09B0\u09BF\u09AA\u09B6\u09A8' + ' \u09B8\u0995\u09CD\u09B0\u09BF\u09AF\u09BC' + ' \u09B9\u09AF\u09BC\u09C7\u099B\u09C7');
      } else {
        state = CarrierBillingState.error('OTP \u09AF\u09BE\u099A\u09BE\u0987 \u09AC\u09CD\u09AF\u09B0\u09CD\u09A5 \u09B9\u09AF\u09BC\u09C7\u099B\u09C7');
      }
    } catch (e) {
      state = CarrierBillingState.error(e.toString());
    }
  }

  Future<void> loadStatus() async {
    try {
      final data = await _repo.getSubscriptionStatus();
      if (data != null) {
        state = CarrierBillingState.data(data);
      } else {
        state = const CarrierBillingState.idle();
      }
    } catch (e) {
      state = CarrierBillingState.error(e.toString());
    }
  }

  Future<bool> unsubscribe(int subscriptionId) async {
    state = const CarrierBillingState.loading();
    try {
      final success = await _repo.unsubscribe(subscriptionId);
      if (success) {
        state = CarrierBillingState.success('\u09B8\u09BE\u09AC\u09B8\u09CD\u0995\u09CD\u09B0\u09BF\u09AA\u09B6\u09A8' + ' \u09AC\u09BE\u09A4\u09BF\u09B2' + ' \u09B9\u09AF\u09BC\u09C7\u099B\u09C7');
        return true;
      } else {
        state = CarrierBillingState.error('\u09B8\u09BE\u09AC\u09B8\u09CD\u0995\u09CD\u09B0\u09BF\u09AA\u09B6\u09A8' + ' \u09AC\u09BE\u09A4\u09BF\u09B2' + ' \u09AC\u09CD\u09AF\u09B0\u09CD\u09A5' + ' \u09B9\u09AF\u09BC\u09C7\u099B\u09C7');
        return false;
      }
    } catch (e) {
      state = CarrierBillingState.error(e.toString());
      return false;
    }
  }
}

final carrierBillingProvider = StateNotifierProvider<CarrierBillingNotifier, CarrierBillingState>((ref) {
  final repo = ref.watch(carrierBillingRepositoryProvider);
  return CarrierBillingNotifier(repo, ref);
});