import 'package:equatable/equatable.dart';
import 'package:livemcq3/features/mcq/domain/entities/answer.dart';
import 'package:livemcq3/features/mcq/domain/entities/category.dart';
import 'package:livemcq3/features/mcq/domain/entities/question.dart';
import 'package:livemcq3/features/mcq/domain/entities/bookmark.dart' hide WeakArea;
import 'package:livemcq3/features/mcq/domain/entities/weak_area.dart';

abstract class McqRepository {
  Future<List<Category>> getCategories();
  Future<List<Question>> getQuestions(int categoryId);
  Future<ExamResult> submitExam(int categoryId, List<Answer> answers);
  Future<void> bookmarkQuestion(int questionId);
  Future<void> unbookmarkQuestion(int questionId);
  Future<List<Bookmark>> getBookmarks();
  Future<List<WeakArea>> getWeakAreas();
  Future<void> downloadQuestions(int categoryId);
  Future<void> syncOfflineAnswers(String sessionId, List<Answer> answers);
}

class ExamResult extends Equatable {
  final double score;
  final int total;
  final int correct;
  final List<WeakArea> weakAreas;

  const ExamResult({
    required this.score,
    required this.total,
    required this.correct,
    required this.weakAreas,
  });

  @override
  List<Object?> get props => [score, total, correct, weakAreas];
}
