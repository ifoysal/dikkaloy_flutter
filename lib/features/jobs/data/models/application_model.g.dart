// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationModel _$ApplicationModelFromJson(Map<String, dynamic> json) =>
    ApplicationModel(
      id: (json['id'] as num).toInt(),
      jobTitle: json['job_title'] as String,
      company: json['company'] as String,
      status: json['status'] as String,
      appliedAt: json['applied_at'] as String,
    );

Map<String, dynamic> _$ApplicationModelToJson(ApplicationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'job_title': instance.jobTitle,
      'company': instance.company,
      'status': instance.status,
      'applied_at': instance.appliedAt,
    };
