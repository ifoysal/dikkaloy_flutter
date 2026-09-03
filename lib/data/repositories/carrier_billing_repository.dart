import 'package:livemcq3/core/constants/endpoints.dart';
import 'package:livemcq3/core/network/dio_client.dart';

class CarrierBillingRepository {
  final DioClient dioClient;

  CarrierBillingRepository(this.dioClient);

  Future<void> requestOtp(String phone) async {
    await dioClient.dio.post(
      ApiEndpoints.carrierBillingOtpRequest,
      data: {'phone': phone},
    );
  }

  Future<bool> verifyOtp(String phone, String otp) async {
    final response = await dioClient.dio.post(
      ApiEndpoints.carrierBillingOtpVerify,
      data: {'phone': phone, 'otp': otp},
    );
    return response.data['success'] == true;
  }

  Future<Map<String, dynamic>?> getSubscriptionStatus() async {
    final response = await dioClient.dio.get(ApiEndpoints.carrierBillingStatus);
    final data = response.data['data'];
    return data != null ? Map<String, dynamic>.from(data) : null;
  }

  Future<bool> unsubscribe(int subscriptionId) async {
    final response = await dioClient.dio.post(
      ApiEndpoints.carrierBillingUnsubscribe,
      data: {'subscription_id': subscriptionId},
    );
    return response.data['success'] == true;
  }

  Future<Map<String, dynamic>> directDebit(int subscriptionId, int amount, {String description = 'LiveMCQ Premium'}) async {
    final response = await dioClient.dio.post(
      ApiEndpoints.carrierBillingCharge,
      data: {
        'subscription_id': subscriptionId,
        'amount': amount,
        'description': description,
      },
    );
    return response.data['data'] as Map<String, dynamic>;
  }
}
