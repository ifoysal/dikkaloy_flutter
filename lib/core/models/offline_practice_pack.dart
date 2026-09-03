import 'package:livemcq3/data/models/exam_models.dart';

class OfflinePracticePack {
  final int packId;
  final int examCategoryId;
  final int? subjectId;
  final List<QuestionModel> questions;
  final String downloadedAt;
  final String expiresAt;

  OfflinePracticePack({
    required this.packId,
    required this.examCategoryId,
    required this.subjectId,
    required this.questions,
    required this.downloadedAt,
    required this.expiresAt,
  });

  factory OfflinePracticePack.fromJson(Map<String, dynamic> json) {
    final rawQuestions = (json['questions'] as List<dynamic>? ?? []);
    final questions = rawQuestions
        .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return OfflinePracticePack(
      packId: json['pack_id'] ?? 0,
      examCategoryId: json['exam_category_id'] ?? 0,
      subjectId: json['subject_id'],
      questions: questions,
      downloadedAt: json['downloaded_at'] ?? '',
      expiresAt: json['expires_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pack_id': packId,
      'exam_category_id': examCategoryId,
      'subject_id': subjectId,
      'questions': questions.map((q) => {
        'id': q.id,
        'exam_category_id': q.examCategoryId,
        'subject_id': q.subjectId,
        'text': q.text,
        'explanation': q.explanation,
        'difficulty': q.difficulty,
        'options': q.options.map((o) => {
          'id': o.id,
          'question_id': o.questionId,
          'text': o.text,
          'is_correct': o.isCorrect,
        }).toList(),
      }).toList(),
      'downloaded_at': downloadedAt,
      'expires_at': expiresAt,
    };
  }
}
