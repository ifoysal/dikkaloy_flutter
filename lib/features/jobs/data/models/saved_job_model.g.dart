// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_job_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavedJobModel _$SavedJobModelFromJson(Map<String, dynamic> json) =>
    SavedJobModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      company: json['company'] as String,
    );

Map<String, dynamic> _$SavedJobModelToJson(SavedJobModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'company': instance.company,
    };
