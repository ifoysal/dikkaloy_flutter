import 'package:equatable/equatable.dart';

class Contest extends Equatable {
  final int id;
  final String title;
  final String description;
  final String startAt;
  final String endAt;
  final int entryFee;
  final int prize;
  final int participantsCount;
  final bool joined;

  const Contest({
    required this.id,
    required this.title,
    required this.description,
    required this.startAt,
    required this.endAt,
    required this.entryFee,
    required this.prize,
    required this.participantsCount,
    this.joined = false,
  });

  @override
  List<Object?> get props => [id, title, description, startAt, endAt, entryFee, prize, participantsCount, joined];
}

class LeaderboardEntry extends Equatable {
  final int userId;
  final String name;
  final int score;

  const LeaderboardEntry({required this.userId, required this.name, required this.score});

  @override
  List<Object?> get props => [userId, name, score];
}

class ContestArena extends Equatable {
  final List<LeaderboardEntry> leaderboard;
  final int timeRemaining;
  final bool started;

  const ContestArena({required this.leaderboard, required this.timeRemaining, required this.started});

  @override
  List<Object?> get props => [leaderboard, timeRemaining, started];
}

class ContestResult extends Equatable {
  final int rank;
  final int score;
  final int totalParticipants;

  const ContestResult({required this.rank, required this.score, required this.totalParticipants});

  @override
  List<Object?> get props => [rank, score, totalParticipants];
}
