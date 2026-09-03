// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cv_template_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CvTemplateModel _$CvTemplateModelFromJson(Map<String, dynamic> json) =>
    CvTemplateModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      preview: json['preview'] as String,
    );

Map<String, dynamic> _$CvTemplateModelToJson(CvTemplateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'preview': instance.preview,
    };
