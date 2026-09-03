import 'package:dio/dio.dart';
import 'package:livemcq3/core/constants/api_constants.dart';
import 'package:livemcq3/features/profile/domain/entities/profile.dart';
import 'package:livemcq3/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final Dio dio;
  ProfileRepositoryImpl(this.dio);

  @override
  Future<Profile> getProfile() async {
    final response = await dio.get(ApiConstants.profile());
    final data = response.data['data'] as Map<String, dynamic>;
    return Profile(
      id: data['id'] as int,
      name: data['name'] as String,
      email: data['email'] as String,
      phone: data['phone'] as String?,
      avatar: data['avatar'] as String?,
      bio: data['bio'] as String?,
    );
  }

  @override
  Future<Profile> updateProfile(Map<String, dynamic> data) async {
    final response = await dio.put(ApiConstants.profile(), data: data);
    final d = response.data['data'] as Map<String, dynamic>;
    return Profile(
      id: d['id'] as int,
      name: d['name'] as String,
      email: d['email'] as String,
      phone: d['phone'] as String?,
      avatar: d['avatar'] as String?,
      bio: d['bio'] as String?,
    );
  }

  @override
  Future<void> deleteAccount() async {
    await dio.delete(ApiConstants.profile());
  }
}
