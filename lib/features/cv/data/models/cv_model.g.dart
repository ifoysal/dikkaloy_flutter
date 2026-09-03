// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cv_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CvModel _$CvModelFromJson(Map<String, dynamic> json) => CvModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      template: json['template'] as String,
      sections: json['sections'] as Map<String, dynamic>,
      pdfUrl: json['pdfUrl'] as String?,
    );

Map<String, dynamic> _$CvModelToJson(CvModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'template': instance.template,
      'sections': instance.sections,
      'pdfUrl': instance.pdfUrl,
    };
