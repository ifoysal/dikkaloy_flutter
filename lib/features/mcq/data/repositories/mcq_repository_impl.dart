import 'package:dio/dio.dart';
import 'package:livemcq3/core/constants/api_constants.dart';
import 'package:livemcq3/core/errors/exceptions.dart';
import 'package:livemcq3/features/mcq/data/models/category_model.dart';
import 'package:livemcq3/features/mcq/data/models/question_model.dart';
import 'package:livemcq3/features/mcq/domain/entities/answer.dart';
import 'package:livemcq3/features/mcq/domain/entities/category.dart';
import 'package:livemcq3/features/mcq/domain/entities/exam_session.dart';
import 'package:livemcq3/features/mcq/domain/entities/question.dart';
import 'package:livemcq3/features/mcq/domain/entities/bookmark.dart' hide WeakArea;
import 'package:livemcq3/features/mcq/domain/entities/weak_area.dart';
import 'package:livemcq3/features/mcq/domain/repositories/mcq_repository.dart';
import 'package:livemcq3/features/mcq/data/datasources/mcq_local_data_source.dart';

class McqRepositoryImpl implements McqRepository {
  final Dio dio;
  final McqLocalDataSource localDataSource;

  McqRepositoryImpl({required this.dio, required this.localDataSource});

  @override
  Future<List<Category>> getCategories() async {
    final response = await dio.get(ApiConstants.categories);
    final list = response.data['data'] as List<dynamic>;
    return list.whereType<Map<String, dynamic>>().map((c) => CategoryModel.fromJson(c).toEntity()).toList();
  }

  @override
  Future<List<Question>> getQuestions(int categoryId) async {
    final response = await dio.get(ApiConstants.categoryQuestions(categoryId));
    final list = response.data['data'] as List<dynamic>;
    return list.whereType<Map<String, dynamic>>().map((q) => QuestionModel.fromJson(q).toEntity()).toList();
  }

  @override
  Future<ExamResult> submitExam(int categoryId, List<Answer> answers) async {
    final response = await dio.post(
      ApiConstants.submitExam(categoryId),
      data: {'answers': answers.map((a) => {'question_id': a.questionId, 'selected_option_id': a.selectedOptionId}).toList()},
    );
    final data = response.data['data'] as Map<String, dynamic>;
    final weakAreas = (data['weak_areas'] as List<dynamic>?)
            ?.map((w) => WeakArea(topic: w['topic'] as String, score: (w['score'] as num).toDouble(), attempts: w['attempts'] as int))
            .toList() ??
        const [];
    return ExamResult(
      score: (data['score'] as num).toDouble(),
      total: data['total'] as int,
      correct: data['correct'] as int,
      weakAreas: weakAreas,
    );
  }

  @override
  Future<void> bookmarkQuestion(int questionId) async {
    await dio.post(ApiConstants.bookmarkQuestion(questionId));
  }

  @override
  Future<void> unbookmarkQuestion(int questionId) async {
    await dio.delete(ApiConstants.bookmarkQuestion(questionId));
  }

  @override
  Future<List<Bookmark>> getBookmarks() async {
    final response = await dio.get(ApiConstants.bookmarks());
    final list = response.data['data'] as List<dynamic>;
    return list.whereType<Map<String, dynamic>>().map((b) => Bookmark(id: b['id'] as int, questionId: b['question_id'] as int, createdAt: b['created_at'] as String)).toList();
  }

  @override
  Future<List<WeakArea>> getWeakAreas() async {
    final response = await dio.get(ApiConstants.analytics);
    final data = response.data['data'] as Map<String, dynamic>;
    final list = data['weak_areas'] as List<dynamic>? ?? [];
    return list.map((w) => WeakArea(topic: w['topic'] as String, score: (w['score'] as num).toDouble(), attempts: w['attempts'] as int)).toList();
  }

  @override
  Future<void> downloadQuestions(int categoryId) async {
    final questions = await getQuestions(categoryId);
    await localDataSource.saveQuestions(categoryId, questions);
  }

  @override
  Future<void> syncOfflineAnswers(String sessionId, List<Answer> answers) async {
    final payload = answers.map((a) => {'question_id': a.questionId, 'selected_option_id': a.selectedOptionId}).toList();
    await dio.post(ApiConstants.practiceOfflineSync(int.parse(sessionId)), data: {'answers': payload});
  }
}
