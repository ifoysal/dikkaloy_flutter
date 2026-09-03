import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? avatar;
  final String? bio;

  const Profile({required this.id, required this.name, required this.email, this.phone, this.avatar, this.bio});

  @override
  List<Object?> get props => [id, name, email, phone, avatar, bio];
}

class NotificationPreferences extends Equatable {
  final bool pushEnabled;
  final bool emailEnabled;
  final bool smsEnabled;

  const NotificationPreferences({required this.pushEnabled, required this.emailEnabled, required this.smsEnabled});

  @override
  List<Object?> get props => [pushEnabled, emailEnabled, smsEnabled];
}
