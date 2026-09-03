import 'package:dio/dio.dart';
import 'package:livemcq3/core/constants/api_constants.dart';
import 'package:livemcq3/core/errors/exceptions.dart';
import 'package:livemcq3/features/home/domain/entities/dashboard_stats.dart';
import 'package:livemcq3/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final Dio dio;
  HomeRepositoryImpl(this.dio);

  @override
  Future<DashboardStats> getStats() async {
    final response = await dio.get(ApiConstants.analytics);
    final data = response.data['data'] as Map<String, dynamic>;
    return DashboardStats(
      examsCompleted: (data['exams_completed'] ?? 0) as int,
      averageScore: ((data['average_score'] ?? 0) as num).toDouble(),
      savedJobsCount: (data['saved_jobs'] ?? 0) as int,
      purchasedBooksCount: (data['purchased_books'] ?? 0) as int,
    );
  }

  @override
  Future<List<UpcomingContest>> getUpcomingContests() async {
    final response = await dio.get(ApiConstants.contests());
    final list = response.data['data'] as List<dynamic>;
    return list
        .whereType<Map<String, dynamic>>()
        .map((c) => UpcomingContest(
              id: c['id'] as int,
              title: c['title'] as String,
              startAt: c['start_at'] as String,
              participantsCount: (c['participants_count'] ?? 0) as int,
            ))
        .toList();
  }

  @override
  Future<List<RecentJob>> getRecentJobs() async {
    final response = await dio.get(ApiConstants.jobs());
    final list = response.data['data'] as List<dynamic>;
    return list
        .whereType<Map<String, dynamic>>()
        .take(5)
        .map((j) => RecentJob(
              id: j['id'] as int,
              title: j['title'] as String,
              company: j['company'] as String,
              location: j['location'] as String,
            ))
        .toList();
  }

  @override
  Future<List<ContinueReading>> getContinueReading() async {
    final response = await dio.get(ApiConstants.books());
    final list = response.data['data'] as List<dynamic>;
    return list
        .whereType<Map<String, dynamic>>()
        .take(5)
        .map((b) => ContinueReading(
              id: b['id'] as int,
              title: b['title'] as String,
              cover: b['cover'] as String,
              progress: ((b['reading_progress'] ?? 0) as num).toDouble(),
            ))
        .toList();
  }
}
