// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      id: (json['id'] as num).toInt(),
      text: json['text'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      correctIndex: (json['correct_index'] as num).toInt(),
      type: json['type'] as String,
      explanation: json['explanation'] as String?,
      chapterId: (json['chapter_id'] as num?)?.toInt(),
      chapterName: json['chapter_name'] as String?,
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'options': instance.options,
      'correct_index': instance.correctIndex,
      'type': instance.type,
      'explanation': instance.explanation,
      'chapter_id': instance.chapterId,
      'chapter_name': instance.chapterName,
    };
