import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/models/offline_practice_pack.dart';
import 'package:livemcq3/core/providers/app_providers.dart';
import 'package:livemcq3/data/models/exam_models.dart';
import 'package:livemcq3/data/repositories/mcq_repository.dart';

final mcqRepositoryProvider = Provider<McqRepository>((ref) {
  return McqRepository(ref.watch(dioClientProvider));
});

final examCategoriesProvider = FutureProvider<List<ExamCategoryModel>>((ref) async {
  final repo = ref.watch(mcqRepositoryProvider);
  return repo.getCategories();
});

final subjectsProvider = FutureProvider.family<List<SubjectModel>, int>((ref, categoryId) async {
  final repo = ref.watch(mcqRepositoryProvider);
  return repo.getSubjects(categoryId);
});

final chaptersProvider = FutureProvider.family<List<ChapterModel>, int>((ref, subjectId) async {
  final repo = ref.watch(mcqRepositoryProvider);
  return repo.getChapters(subjectId);
});

final categoryQuestionsProvider = FutureProvider.family<List<QuestionModel>, ({int categoryId, int? subjectId, int? chapterId})>((ref, params) async {
  final repo = ref.watch(mcqRepositoryProvider);
  return repo.getQuestions(
    params.categoryId,
    limit: 20,
    subjectId: params.subjectId,
    chapterId: params.chapterId,
  );
});

final bookmarksProvider = FutureProvider<List<BookmarkModel>>((ref) async {
  final repo = ref.watch(mcqRepositoryProvider);
  return repo.getBookmarks();
});

final examHistoryProvider = FutureProvider<List<ExamSessionModel>>((ref) async {
  final repo = ref.watch(mcqRepositoryProvider);
  return repo.getExamHistory();
});

final offlinePracticePacksProvider = StateProvider<List<OfflinePracticePack>>((ref) => []);
