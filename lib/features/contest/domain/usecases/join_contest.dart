import 'package:livemcq3/features/contest/domain/entities/contest.dart';
import 'package:livemcq3/features/contest/domain/repositories/contest_repository.dart';

class JoinContest {
  final ContestRepository repository;
  JoinContest(this.repository);
  Future<void> call(int id) => repository.joinContest(id);
}

class SubmitContest {
  final ContestRepository repository;
  SubmitContest(this.repository);
  Future<void> call(int id, Map<String, dynamic> answers) => repository.submitContest(id, answers);
}

class GetLeaderboard {
  final ContestRepository repository;
  GetLeaderboard(this.repository);
  Future<List<LeaderboardEntry>> call(int id) async {
    final arena = await repository.getArena(id);
    return arena.leaderboard;
  }
}
