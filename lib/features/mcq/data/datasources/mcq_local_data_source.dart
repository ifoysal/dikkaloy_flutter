import 'package:livemcq3/core/storage/hive_boxes.dart';
import 'package:livemcq3/features/mcq/domain/entities/question.dart';
import 'package:livemcq3/features/mcq/domain/entities/answer.dart';
import 'package:livemcq3/features/mcq/domain/entities/bookmark.dart';
import 'package:livemcq3/features/mcq/domain/entities/weak_area.dart';

class McqLocalDataSource {
  McqLocalDataSource();

  Future<void> saveQuestions(int categoryId, List<Question> questions) async {
    final box = HiveBoxes.getDownloadedQuestionsBox();
    await box.put('category_$categoryId', questions.map((q) => q.toJson()).toList());
  }

  List<Question>? getQuestions(int categoryId) {
    final box = HiveBoxes.getDownloadedQuestionsBox();
    final data = box.get('category_$categoryId');
    if (data == null) return null;
    return (data as List).map((e) => Question.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> saveExamAnswers(String sessionId, Map<int, int> answers) async {
    final box = HiveBoxes.getExamAnswersBox();
    await box.put(sessionId, answers);
  }

  Map<int, int>? getExamAnswers(String sessionId) {
    final box = HiveBoxes.getExamAnswersBox();
    final data = box.get(sessionId);
    if (data == null) return null;
    return Map<int, int>.from(data as Map);
  }

  Future<void> clearExamAnswers(String sessionId) async {
    final box = HiveBoxes.getExamAnswersBox();
    await box.delete(sessionId);
  }
}
