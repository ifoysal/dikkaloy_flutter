import 'package:dio/dio.dart';
import 'package:livemcq3/core/constants/api_constants.dart';
import 'package:livemcq3/features/contest/domain/entities/contest.dart';
import 'package:livemcq3/features/contest/domain/repositories/contest_repository.dart' hide ContestArena, ContestResult, LeaderboardEntry;

class ContestRepositoryImpl implements ContestRepository {
  final Dio dio;
  ContestRepositoryImpl(this.dio);

  @override
  Future<List<Contest>> getContests() async {
    final response = await dio.get(ApiConstants.contests());
    final list = response.data['data'] as List<dynamic>;
    return list.whereType<Map<String, dynamic>>().map((c) => Contest(
          id: c['id'] as int,
          title: c['title'] as String,
          description: c['description'] as String,
          startAt: c['start_at'] as String,
          endAt: c['end_at'] as String,
          entryFee: c['entry_fee'] as int,
          prize: c['prize'] as int,
          participantsCount: c['participants_count'] as int,
          joined: c['joined'] as bool? ?? false,
        )).toList();
  }

  @override
  Future<Contest> getContest(int id) async {
    final response = await dio.get(ApiConstants.contest(id));
    final c = response.data['data'] as Map<String, dynamic>;
    return Contest(
      id: c['id'] as int,
      title: c['title'] as String,
      description: c['description'] as String,
      startAt: c['start_at'] as String,
      endAt: c['end_at'] as String,
      entryFee: c['entry_fee'] as int,
      prize: c['prize'] as int,
      participantsCount: c['participants_count'] as int,
      joined: c['joined'] as bool? ?? false,
    );
  }

  @override
  Future<void> joinContest(int id) async {
    await dio.post(ApiConstants.joinContest(id));
  }

  @override
  Future<void> submitContest(int id, Map<String, dynamic> answers) async {
    await dio.post(ApiConstants.submitContest(id), data: {'answers': answers});
  }

  @override
  Future<ContestArena> getArena(int id) async {
    final response = await dio.get(ApiConstants.contestArena(id));
    final data = response.data['data'] as Map<String, dynamic>;
    final leaderboard = (data['leaderboard'] as List<dynamic>).map((l) => LeaderboardEntry(
          userId: l['user_id'] as int,
          name: l['name'] as String,
          score: l['score'] as int,
        )).toList();
    return ContestArena(
      leaderboard: leaderboard,
      timeRemaining: data['time_remaining'] as int,
      started: data['started'] as bool,
    );
  }

  @override
  Future<ContestResult> getResult(int id) async {
    final response = await dio.get(ApiConstants.contestResult(id));
    final data = response.data['data'] as Map<String, dynamic>;
    return ContestResult(
      rank: data['rank'] as int,
      score: data['score'] as int,
      totalParticipants: data['total_participants'] as int,
    );
  }
}
