// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_preferences_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationPreferencesModel _$NotificationPreferencesModelFromJson(
        Map<String, dynamic> json) =>
    NotificationPreferencesModel(
      push: json['push'] as bool,
      email: json['email'] as bool,
      sms: json['sms'] as bool,
    );

Map<String, dynamic> _$NotificationPreferencesModelToJson(
        NotificationPreferencesModel instance) =>
    <String, dynamic>{
      'push': instance.push,
      'email': instance.email,
      'sms': instance.sms,
    };
