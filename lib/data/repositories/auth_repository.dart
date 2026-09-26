import 'package:livemcq3/core/constants/endpoints.dart';
import 'package:livemcq3/core/network/dio_client.dart';
import 'package:livemcq3/data/models/auth_models.dart';
import 'package:livemcq3/data/models/user_model.dart';

class AuthRepository {
  final DioClient dioClient;

  AuthRepository(this.dioClient);

  Future<AuthResponseModel> login(String email, String password) async {
    final response = await dioClient.dio.post(
      ApiEndpoints.login,
      data: {'email': email, 'password': password},
    );
    final data = response.data['data'] as Map<String, dynamic>;
    return AuthResponseModel.fromJson(data);
  }

  Future<AuthResponseModel> register(String name, String email, String password, {String? phone}) async {
    final response = await dioClient.dio.post(
      ApiEndpoints.register,
      data: {
        'name': name,
        'email': email,
        'password': password,
        if (phone != null) 'phone': phone,
      },
    );
    final data = response.data['data'] as Map<String, dynamic>;
    return AuthResponseModel.fromJson(data);
  }

  Future<void> sendOtp(String phone) async {
    await dioClient.dio.post(ApiEndpoints.smsSendOtp, data: {'phone': phone});
  }

  Future<bool> verifyOtp(String phone, String otp) async {
    final response = await dioClient.dio.post(
      ApiEndpoints.smsVerifyOtp,
      data: {'phone': phone, 'otp': otp},
    );
    return response.data['success'] == true;
  }

  /// Checks whether [phone] belongs to an operator eligible for BDApps DCB
  /// (Robi / Airtel only). Throws with the backend's Bengali message when not.
  Future<Map<String, dynamic>> checkOperator(String phone) async {
    final response = await dioClient.dio.post(ApiEndpoints.dcbOperatorCheck, data: {'phone': phone});
    return response.data as Map<String, dynamic>;
  }

  /// Requests a BDApps OTP for [phone]. If the number is already an active
  /// BDApps subscriber, the backend logs the user in directly without an OTP.
  Future<Map<String, dynamic>> requestDcbOtp(String phone) async {
    final response = await dioClient.dio.post(ApiEndpoints.carrierBillingOtpRequest, data: {'phone': phone});
    return response.data as Map<String, dynamic>;
  }

  /// Verifies the BDApps OTP for [phone] and returns the auth token + user.
  Future<Map<String, dynamic>> verifyDcbOtp(String phone, String otp) async {
    final response = await dioClient.dio.post(
      ApiEndpoints.carrierBillingOtpVerify,
      data: {'phone': phone, 'otp': otp},
    );
    return response.data as Map<String, dynamic>;
  }

  /// Fetches the caller's latest BDApps carrier-billing subscription record,
  /// or null if none exists.
  Future<Map<String, dynamic>?> getCarrierBillingStatus() async {
    final response = await dioClient.dio.get(ApiEndpoints.carrierBillingStatus);
    return response.data['data'] as Map<String, dynamic>?;
  }

  /// Unsubscribes the given BDApps carrier-billing subscription. On success
  /// the backend also invalidates the session (logs the user out).
  Future<Map<String, dynamic>> unsubscribeCarrierBilling(int subscriptionId) async {
    final response = await dioClient.dio.post(
      ApiEndpoints.carrierBillingUnsubscribe,
      data: {'subscription_id': subscriptionId},
    );
    return response.data as Map<String, dynamic>;
  }

  Future<UserModel> me() async {
    final response = await dioClient.dio.get(ApiEndpoints.me);
    final data = response.data['data'] as Map<String, dynamic>;
    final userJson = data['user'] ?? data;
    return UserModel.fromJson(userJson as Map<String, dynamic>);
  }

  Future<UserModel> updateProfile(Map<String, dynamic> updates) async {
    final response = await dioClient.dio.put(ApiEndpoints.profile, data: updates);
    final data = response.data['data'] as Map<String, dynamic>;
    final userJson = data['user'] ?? data;
    return UserModel.fromJson(userJson as Map<String, dynamic>);
  }

  Future<void> logout() async {
    await dioClient.dio.post(ApiEndpoints.logout);
  }

  Future<void> registerFcmToken(String token, String platform) async {
    await dioClient.dio.post(ApiEndpoints.notificationsRegister, data: {
      'device_token': token,
      'platform': platform,
    });
  }

  Future<Map<String, dynamic>> getNotificationPreferences() async {
    final response = await dioClient.dio.get(ApiEndpoints.notificationsPreferences);
    final data = response.data['data'] as Map<String, dynamic>;
    return data;
  }

  Future<Map<String, dynamic>> updateNotificationPreferences(Map<String, dynamic> preferences) async {
    final response = await dioClient.dio.put(ApiEndpoints.notificationsPreferences, data: preferences);
    final data = response.data['data'] as Map<String, dynamic>;
    return data;
  }

  Future<void> deleteAccount() async {
    await dioClient.dio.delete(ApiEndpoints.profile);
  }
}
