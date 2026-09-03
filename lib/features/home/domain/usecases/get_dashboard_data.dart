import 'package:livemcq3/features/home/domain/entities/dashboard_stats.dart';
import 'package:livemcq3/features/home/domain/repositories/home_repository.dart';

class GetDashboardData {
  final HomeRepository repository;
  GetDashboardData(this.repository);

  Future<Map<String, dynamic>> call() async {
    final stats = await repository.getStats();
    final contests = await repository.getUpcomingContests();
    final jobs = await repository.getRecentJobs();
    final reading = await repository.getContinueReading();
    return {
      'stats': stats,
      'contests': contests,
      'jobs': jobs,
      'reading': reading,
    };
  }
}
