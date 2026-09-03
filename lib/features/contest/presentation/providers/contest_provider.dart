import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:livemcq3/features/contest/domain/usecases/join_contest.dart';
part 'contest_provider.g.dart';

final joinContestProvider = Provider<JoinContest>((ref) => JoinContest(ref.read(contestRepositoryProvider)));
final submitContestProvider = Provider<SubmitContest>((ref) => SubmitContest(ref.read(contestRepositoryProvider)));
final getLeaderboardProvider = Provider<GetLeaderboard>((ref) => GetLeaderboard(ref.read(contestRepositoryProvider)));
