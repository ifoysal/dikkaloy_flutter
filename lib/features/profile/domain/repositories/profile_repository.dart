import 'package:equatable/equatable.dart';
import 'package:livemcq3/features/profile/domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<Profile> getProfile();
  Future<Profile> updateProfile(Map<String, dynamic> data);
  Future<void> deleteAccount();
}

class NotificationPreferences extends Equatable {
  final bool pushEnabled;
  final bool emailEnabled;
  final bool smsEnabled;

  const NotificationPreferences({required this.pushEnabled, required this.emailEnabled, required this.smsEnabled});

  @override
  List<Object?> get props => [pushEnabled, emailEnabled, smsEnabled];
}
