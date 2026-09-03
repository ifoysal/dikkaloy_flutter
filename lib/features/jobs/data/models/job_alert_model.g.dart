// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_alert_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobAlertModel _$JobAlertModelFromJson(Map<String, dynamic> json) =>
    JobAlertModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String,
      location: json['location'] as String,
      employmentType: json['employment_type'] as String,
    );

Map<String, dynamic> _$JobAlertModelToJson(JobAlertModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'location': instance.location,
      'employment_type': instance.employmentType,
    };
