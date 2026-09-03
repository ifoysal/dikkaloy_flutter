import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:livemcq3/core/constants/app_constants.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  Future<String?> readToken() async {
    return await _storage.read(key: AppConstants.tokenKey);
  }

  Future<void> writeToken(String token) async {
    await _storage.write(key: AppConstants.tokenKey, value: token);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: AppConstants.tokenKey);
  }

  Future<void> clear() async {
    await _storage.deleteAll();
  }
}
