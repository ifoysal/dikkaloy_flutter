import 'package:livemcq3/core/constants/endpoints.dart';
import 'package:livemcq3/core/network/dio_client.dart';
import 'package:livemcq3/data/models/exam_models.dart';

class McqRepository {
  final DioClient dioClient;

  McqRepository(this.dioClient);

  Future<List<ExamCategoryModel>> getCategories() async {
    final response = await dioClient.dio.get(ApiEndpoints.categories);
    final data = response.data['data'] as List;
    return data.map((e) => ExamCategoryModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<SubjectModel>> getSubjects(int categoryId) async {
    final response = await dioClient.dio.get(ApiEndpoints.subjects(categoryId));
    final data = response.data['data'] as List;
    return data.map((e) => SubjectModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<ChapterModel>> getChapters(int subjectId) async {
    final response = await dioClient.dio.get(ApiEndpoints.chapters(subjectId));
    final data = response.data['data'] as List;
    return data.map((e) => ChapterModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<QuestionModel>> getQuestions(int categoryId, {int limit = 20, int? subjectId, int? chapterId}) async {
    final response = await dioClient.dio.get(
      ApiEndpoints.questions(categoryId),
      queryParameters: {
        'limit': limit,
        if (subjectId != null) 'subject_id': subjectId,
        if (chapterId != null) 'chapter_id': chapterId,
      },
    );
    final data = response.data['data'] as List;
    return data.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<ExamSubmitResultModel> submitExam(
    int categoryId,
    Map<int, int> answers, {
    int? subjectId,
  }) async {
    final response = await dioClient.dio.post(
      ApiEndpoints.submitCategory(categoryId),
      data: {
        'answers': answers.map((k, v) => MapEntry(k.toString(), v)),
        if (subjectId != null) 'subject_id': subjectId,
      },
    );
    final data = response.data['data'] as Map<String, dynamic>;
    return ExamSubmitResultModel.fromJson(data);
  }

  Future<void> bookmarkQuestion(int questionId) async {
    await dioClient.dio.post(ApiEndpoints.bookmarkQuestion(questionId));
  }

  Future<void> removeBookmark(int questionId) async {
    await dioClient.dio.delete(ApiEndpoints.removeBookmark(questionId));
  }

  Future<List<BookmarkModel>> getBookmarks() async {
    final response = await dioClient.dio.get(ApiEndpoints.bookmarks);
    final data = response.data['data'] as List;
    return data.map((e) => BookmarkModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Map<String, dynamic>> downloadOfflinePractice(int examCategoryId, {int? subjectId}) async {
    final response = await dioClient.dio.post(
      ApiEndpoints.offlinePracticeDownload,
      data: {
        'exam_category_id': examCategoryId,
        if (subjectId != null) 'subject_id': subjectId,
      },
    );
    return response.data['data'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> syncOfflinePractice(int packId, List<Map<String, dynamic>> answers) async {
    final response = await dioClient.dio.post(
      ApiEndpoints.offlinePracticeSync(packId),
      data: {'answers': answers},
    );
    return response.data['data'] as Map<String, dynamic>;
  }

  Future<List<ExamSessionModel>> getExamHistory() async {
    final response = await dioClient.dio.get(ApiEndpoints.examHistory);
    final data = response.data['data'] as List;
    return data.map((e) => ExamSessionModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}
