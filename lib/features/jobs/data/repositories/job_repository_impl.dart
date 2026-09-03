import 'package:dio/dio.dart';
import 'package:livemcq3/core/constants/api_constants.dart';
import 'package:livemcq3/features/jobs/domain/entities/job.dart';
import 'package:livemcq3/features/jobs/domain/repositories/job_repository.dart';

class JobRepositoryImpl implements JobRepository {
  final Dio dio;
  JobRepositoryImpl(this.dio);

  @override
  Future<List<Job>> getJobs() async {
    final response = await dio.get(ApiConstants.jobs());
    final list = response.data['data'] as List<dynamic>;
    return list.whereType<Map<String, dynamic>>().map((j) => Job(
          id: j['id'] as int,
          title: j['title'] as String,
          company: j['company'] as String,
          location: j['location'] as String,
          description: j['description'] as String,
          salaryRange: j['salary_range'] as String?,
          employmentType: j['employment_type'] as String,
          saved: j['saved'] as bool? ?? false,
        )).toList();
  }

  @override
  Future<Job> getJob(int id) async {
    final response = await dio.get(ApiConstants.job(id));
    final j = response.data['data'] as Map<String, dynamic>;
    return Job(
      id: j['id'] as int,
      title: j['title'] as String,
      company: j['company'] as String,
      location: j['location'] as String,
      description: j['description'] as String,
      salaryRange: j['salary_range'] as String?,
      employmentType: j['employment_type'] as String,
      saved: j['saved'] as bool? ?? false,
    );
  }

  @override
  Future<void> saveJob(int id) async {
    await dio.post(ApiConstants.saveJob(id));
  }

  @override
  Future<void> unsaveJob(int id) async {
    await dio.delete(ApiConstants.unsaveJob(id));
  }

  @override
  Future<List<Job>> getSavedJobs() async {
    final response = await dio.get(ApiConstants.savedJobs());
    final list = response.data['data'] as List<dynamic>;
    return list.whereType<Map<String, dynamic>>().map((j) => Job(
          id: j['id'] as int,
          title: j['title'] as String,
          company: j['company'] as String,
          location: j['location'] as String,
          description: j['description'] as String,
          salaryRange: j['salary_range'] as String?,
          employmentType: j['employment_type'] as String,
          saved: true,
        )).toList();
  }

  @override
  Future<void> createAlert(JobAlert alert) async {
    await dio.post(ApiConstants.jobAlerts(), data: alert.toJson());
  }

  @override
  Future<void> deleteAlert(int id) async {
    await dio.delete(ApiConstants.jobAlert(id));
  }

  @override
  Future<List<JobAlert>> getJobAlerts() async {
    final response = await dio.get(ApiConstants.jobAlerts());
    final list = response.data['data'] as List<dynamic>;
    return list.whereType<Map<String, dynamic>>().map((a) => JobAlert(
          id: a['id'] as int,
          title: a['title'] as String,
          location: a['location'] as String,
          employmentType: a['employment_type'] as String,
        )).toList();
  }

  @override
  Future<List<Application>> getApplications() async {
    final response = await dio.get(ApiConstants.applications());
    final list = response.data['data'] as List<dynamic>;
    return list.whereType<Map<String, dynamic>>().map((a) => Application(
          id: a['id'] as int,
          jobTitle: a['job_title'] as String,
          company: a['company'] as String,
          status: a['status'] as String,
          appliedAt: a['applied_at'] as String,
        )).toList();
  }
}
