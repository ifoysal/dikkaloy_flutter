import 'package:equatable/equatable.dart';
import 'package:livemcq3/features/mcq/domain/entities/question.dart';

class ExamSession extends Equatable {
  final String id;
  final int categoryId;
  final List<Question> questions;
  final DateTime startedAt;
  final DateTime? endedAt;
  final int? score;
  final bool isCompleted;

  const ExamSession({
    required this.id,
    required this.categoryId,
    required this.questions,
    required this.startedAt,
    this.endedAt,
    this.score,
    this.isCompleted = false,
  });

  ExamSession copyWith({
    String? id,
    int? categoryId,
    List<Question>? questions,
    DateTime? startedAt,
    DateTime? endedAt,
    int? score,
    bool? isCompleted,
  }) {
    return ExamSession(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      questions: questions ?? this.questions,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      score: score ?? this.score,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, categoryId, questions, startedAt, endedAt, score, isCompleted];

  factory ExamSession.fromJson(Map<String, dynamic> json) => ExamSession(
        id: json['id'].toString(),
        categoryId: json['exam_category_id'] as int,
        questions: json['questions'] != null ? (json['questions'] as List<dynamic>).map((q) => Question.fromJson(q as Map<String, dynamic>)).toList() : const [],
        startedAt: DateTime.parse(json['started_at'] as String),
        endedAt: json['ended_at'] != null ? DateTime.parse(json['ended_at'] as String) : null,
        score: json['score'] as int?,
        isCompleted: json['is_completed'] as bool? ?? true,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'exam_category_id': categoryId,
        'questions': questions.map((q) => q.toJson()).toList(),
        'started_at': startedAt.toIso8601String(),
        'ended_at': endedAt?.toIso8601String(),
        'score': score,
        'is_completed': isCompleted,
      };
}
