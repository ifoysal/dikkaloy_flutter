// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamSessionModel _$ExamSessionModelFromJson(Map<String, dynamic> json) =>
    ExamSessionModel(
      id: json['id'] as String,
      categoryId: (json['category_id'] as num).toInt(),
      questions: (json['questions'] as List<dynamic>)
          .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      startedAt: json['started_at'] as String,
      endedAt: json['ended_at'] as String?,
      score: (json['score'] as num?)?.toInt(),
      isCompleted: json['is_completed'] as bool,
    );

Map<String, dynamic> _$ExamSessionModelToJson(ExamSessionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category_id': instance.categoryId,
      'questions': instance.questions,
      'started_at': instance.startedAt,
      'ended_at': instance.endedAt,
      'score': instance.score,
      'is_completed': instance.isCompleted,
    };
