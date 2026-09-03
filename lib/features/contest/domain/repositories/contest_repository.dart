import 'package:equatable/equatable.dart';
import 'package:livemcq3/features/contest/domain/entities/contest.dart';

abstract class ContestRepository {
  Future<List<Contest>> getContests();
  Future<Contest> getContest(int id);
  Future<void> joinContest(int id);
  Future<void> submitContest(int id, Map<String, dynamic> answers);
  Future<ContestArena> getArena(int id);
  Future<ContestResult> getResult(int id);
}
