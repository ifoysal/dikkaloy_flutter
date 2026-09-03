import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/providers/app_providers.dart';
import 'package:livemcq3/data/models/job_models.dart';
import 'package:livemcq3/data/repositories/job_repository.dart';

final jobRepositoryProvider = Provider<JobRepository>((ref) {
  return JobRepository(ref.watch(dioClientProvider));
});

final jobCategoriesProvider = FutureProvider<List<JobCategoryModel>>((ref) async {
  final repo = ref.watch(jobRepositoryProvider);
  return repo.getJobCategories();
});

final jobsProvider = FutureProvider.family<List<JobCircularModel>, ({String? search, int? categoryId, String? location})>((ref, params) async {
  final repo = ref.watch(jobRepositoryProvider);
  return repo.getJobs(
    search: params.search,
    categoryId: params.categoryId,
    location: params.location,
  );
});

final jobDetailProvider = FutureProvider.family<JobCircularModel, int>((ref, jobId) async {
  final repo = ref.watch(jobRepositoryProvider);
  return repo.getJobDetail(jobId);
});

final jobAlertsProvider = FutureProvider<List<JobAlertModel>>((ref) async {
  final repo = ref.watch(jobRepositoryProvider);
  return repo.getJobAlerts();
});

final savedJobsProvider = FutureProvider<List<SavedJobModel>>((ref) async {
  final repo = ref.watch(jobRepositoryProvider);
  return repo.getSavedJobs();
});
