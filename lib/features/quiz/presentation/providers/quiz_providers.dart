import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/constants/endpoints.dart';
import 'package:livemcq3/core/providers/app_providers.dart';
import 'package:livemcq3/data/models/exam_models.dart';

final dailyQuizProvider = FutureProvider<List<QuestionModel>>((ref) async {
  try {
    final dio = ref.watch(dioClientProvider);
    final response = await dio.dio.get(ApiEndpoints.dailyQuiz);
    if (response.statusCode == 200 && response.data['success'] == true) {
      final list = response.data['data'] as List<dynamic>;
      return list.map((item) => QuestionModel.fromJson(item as Map<String, dynamic>)).toList();
    }
  } catch (_) {}
  return <QuestionModel>[];
});

final quizResultProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, quizId) async {
  return {'score': 100, 'total': 10, 'correct': 10};
});

class QuizNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>?>> {
  final Ref _ref;

  QuizNotifier(this._ref) : super(const AsyncValue.data(null));

  Future<Map<String, dynamic>> submitQuiz(Map<int, int> answers) async {
    state = const AsyncValue.loading();
    try {
      final dio = _ref.read(dioClientProvider);
      final mappedAnswers = <String, int>{};
      answers.forEach((k, v) => mappedAnswers[k.toString()] = v);
      final response = await dio.dio.post(ApiEndpoints.submitDailyQuiz, data: {
        'answers': mappedAnswers,
      });
      if (response.statusCode == 200 && response.data['success'] == true) {
        final result = response.data['data'] as Map<String, dynamic>;
        state = AsyncValue.data(result);
        return result;
      }
      throw Exception('Failed to submit quiz');
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

final quizNotifierProvider = StateNotifierProvider<QuizNotifier, AsyncValue<Map<String, dynamic>?>>((ref) {
  return QuizNotifier(ref);
});
