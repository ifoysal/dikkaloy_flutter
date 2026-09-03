import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/providers/app_providers.dart';
import 'package:livemcq3/data/models/contest_models.dart';
import 'package:livemcq3/data/repositories/contest_repository.dart';

final contestRepositoryProvider = Provider<ContestRepository>((ref) {
  return ContestRepository(ref.watch(dioClientProvider));
});

final contestsProvider = FutureProvider<List<LiveContestModel>>((ref) async {
  final repo = ref.watch(contestRepositoryProvider);
  return repo.getContests();
});

final contestDetailProvider = FutureProvider.family<LiveContestModel, int>((ref, contestId) async {
  final repo = ref.watch(contestRepositoryProvider);
  return repo.getContestDetail(contestId);
});

final contestQuestionsProvider = FutureProvider.family<List<ContestQuestionModel>, int>((ref, contestId) async {
  final repo = ref.watch(contestRepositoryProvider);
  return repo.getContestQuestions(contestId);
});

final contestLeaderboardProvider = FutureProvider.family<List<ContestLeaderboardEntryModel>, int>((ref, contestId) async {
  final repo = ref.watch(contestRepositoryProvider);
  return repo.getLeaderboard(contestId);
});

final contestResultProvider = FutureProvider.family<Map<String, dynamic>, int>((ref, contestId) async {
  final repo = ref.watch(contestRepositoryProvider);
  return repo.getContestResult(contestId);
});
