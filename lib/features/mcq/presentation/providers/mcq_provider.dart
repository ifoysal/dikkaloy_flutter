import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:livemcq3/features/mcq/domain/entities/question.dart';
import 'package:livemcq3/features/mcq/domain/entities/category.dart';
import 'package:livemcq3/features/mcq/domain/entities/answer.dart';
import 'package:livemcq3/features/mcq/domain/entities/exam_session.dart';
import 'package:livemcq3/features/mcq/domain/entities/weak_area.dart';
import 'package:livemcq3/features/mcq/domain/repositories/mcq_repository.dart';
import 'package:livemcq3/features/mcq/domain/usecases/get_categories.dart';
import 'package:livemcq3/features/mcq/domain/usecases/get_questions.dart';
import 'package:livemcq3/features/mcq/domain/usecases/submit_exam.dart';
import 'package:livemcq3/features/mcq/domain/usecases/bookmark_question.dart';
import 'package:livemcq3/features/mcq/domain/usecases/sync_offline_answers.dart';
import 'package:livemcq3/features/mcq/domain/usecases/get_bookmarks.dart';
import 'package:livemcq3/features/mcq/domain/usecases/get_weak_areas.dart';
import 'package:livemcq3/core/providers/app_providers.dart';
part 'mcq_provider.g.dart';

final getCategoriesUseCaseProvider = Provider<GetCategories>((ref) => GetCategories(ref.read(mcqRepositoryProvider)));
final getQuestionsUseCaseProvider = Provider<GetQuestions>((ref) => GetQuestions(ref.read(mcqRepositoryProvider)));
final submitExamUseCaseProvider = Provider<SubmitExam>((ref) => SubmitExam(ref.read(mcqRepositoryProvider)));
final bookmarkQuestionUseCaseProvider = Provider<BookmarkQuestion>((ref) => BookmarkQuestion(ref.read(mcqRepositoryProvider)));
final syncOfflineAnswersUseCaseProvider = Provider<SyncOfflineAnswers>((ref) => SyncOfflineAnswers(ref.read(mcqRepositoryProvider)));
final getBookmarksUseCaseProvider = Provider<GetBookmarks>((ref) => GetBookmarks(ref.read(mcqRepositoryProvider)));
final getWeakAreasUseCaseProvider = Provider<GetWeakAreas>((ref) => GetWeakAreas(ref.read(mcqRepositoryProvider)));

@riverpod
Future<List<Question>> questions(QuestionsRef ref, int categoryId) async {
  final usecase = ref.watch(getQuestionsUseCaseProvider);
  final result = await usecase(categoryId);
  return result;
}

@riverpod
Future<List<Category>> categories(CategoriesRef ref) async {
  final usecase = ref.watch(getCategoriesUseCaseProvider);
  return usecase();
}

@riverpod
Future<List<WeakArea>> weakAreas(WeakAreasRef ref) async {
  final usecase = ref.watch(getWeakAreasUseCaseProvider);
  return usecase();
}

final submitExamProvider = Provider<Future<ExamResult> Function(int categoryId, List<Answer> answers)>((ref) {
  final usecase = ref.watch(submitExamUseCaseProvider);
  return (int categoryId, List<Answer> answers) => usecase(categoryId, answers);
});
