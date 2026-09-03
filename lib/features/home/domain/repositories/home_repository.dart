import 'package:equatable/equatable.dart';
import 'package:livemcq3/features/home/domain/entities/dashboard_stats.dart';

abstract class HomeRepository {
  Future<DashboardStats> getStats();
  Future<List<UpcomingContest>> getUpcomingContests();
  Future<List<RecentJob>> getRecentJobs();
  Future<List<ContinueReading>> getContinueReading();
}

class UpcomingContest extends Equatable {
  final int id;
  final String title;
  final String startAt;
  final int participantsCount;

  const UpcomingContest({
    required this.id,
    required this.title,
    required this.startAt,
    required this.participantsCount,
  });

  @override
  List<Object?> get props => [id, title, startAt, participantsCount];
}

class RecentJob extends Equatable {
  final int id;
  final String title;
  final String company;
  final String location;

  const RecentJob({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
  });

  @override
  List<Object?> get props => [id, title, company, location];
}

class ContinueReading extends Equatable {
  final int id;
  final String title;
  final String cover;
  final double progress;

  const ContinueReading({
    required this.id,
    required this.title,
    required this.cover,
    required this.progress,
  });

  @override
  List<Object?> get props => [id, title, cover, progress];
}
