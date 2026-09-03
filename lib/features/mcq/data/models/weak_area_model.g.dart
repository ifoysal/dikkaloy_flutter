// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weak_area_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeakAreaModel _$WeakAreaModelFromJson(Map<String, dynamic> json) =>
    WeakAreaModel(
      topic: json['topic'] as String,
      score: (json['score'] as num).toDouble(),
      attempts: (json['attempts'] as num).toInt(),
    );

Map<String, dynamic> _$WeakAreaModelToJson(WeakAreaModel instance) =>
    <String, dynamic>{
      'topic': instance.topic,
      'score': instance.score,
      'attempts': instance.attempts,
    };
