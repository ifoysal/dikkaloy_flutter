import 'package:equatable/equatable.dart';
import 'package:livemcq3/features/jobs/domain/entities/job.dart';

abstract class JobRepository {
  Future<List<Job>> getJobs();
  Future<Job> getJob(int id);
  Future<void> saveJob(int id);
  Future<void> unsaveJob(int id);
  Future<List<Job>> getSavedJobs();
  Future<void> createAlert(JobAlert alert);
  Future<void> deleteAlert(int id);
  Future<List<JobAlert>> getJobAlerts();
  Future<List<Application>> getApplications();
}
