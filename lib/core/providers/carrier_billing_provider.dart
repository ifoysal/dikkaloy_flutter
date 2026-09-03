import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/data/repositories/carrier_billing_repository.dart';
import 'package:livemcq3/core/providers/app_providers.dart';

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

  CarrierBillingNotifier(this._repo) : super(const CarrierBillingState.idle());

  Future<void> requestOtp(String phone) async {
    state = const CarrierBillingState.loading();
    try {
      await _repo.requestOtp(phone);
      state = CarrierBillingState.success('OTP sent successfully');
    } catch (e) {
      state = CarrierBillingState.error(e.toString());
    }
  }

  Future<void> verifyOtp(String phone, String otp) async {
    state = const CarrierBillingState.loading();
    try {
      final success = await _repo.verifyOtp(phone, otp);
      if (success) {
        state = CarrierBillingState.success('Subscription activated');
      } else {
        state = CarrierBillingState.error('OTP verification failed');
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
        state = CarrierBillingState.success('Unsubscribed successfully');
        return true;
      } else {
        state = CarrierBillingState.error('Unsubscribe failed');
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
  return CarrierBillingNotifier(repo);
});
