import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'notification_preferences_model.g.dart';

@JsonSerializable()
class NotificationPreferencesModel extends Equatable {
  final bool push;
  final bool email;
  final bool sms;

  const NotificationPreferencesModel({required this.push, required this.email, required this.sms});

  @override
  List<Object?> get props => [push, email, sms];

  factory NotificationPreferencesModel.fromJson(Map<String, dynamic> json) => _$NotificationPreferencesModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationPreferencesModelToJson(this);
}
