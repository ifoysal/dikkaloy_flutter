import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:livemcq3/features/mcq/data/models/question_model.dart';

part 'exam_session_model.g.dart';

@JsonSerializable()
class ExamSessionModel extends Equatable {
  final String id;
  @JsonKey(name: 'category_id')
  final int categoryId;
  final List<QuestionModel> questions;
  @JsonKey(name: 'started_at')
  final String startedAt;
  @JsonKey(name: 'ended_at')
  final String? endedAt;
  final int? score;
  @JsonKey(name: 'is_completed')
  final bool isCompleted;

  const ExamSessionModel({
    required this.id,
    required this.categoryId,
    required this.questions,
    required this.startedAt,
    this.endedAt,
    this.score,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [id, categoryId, questions, startedAt, endedAt, score, isCompleted];

  factory ExamSessionModel.fromJson(Map<String, dynamic> json) => _$ExamSessionModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExamSessionModelToJson(this);
}
