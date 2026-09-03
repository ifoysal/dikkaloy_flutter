import 'package:livemcq3/features/jobs/domain/entities/job.dart';
import 'package:livemcq3/features/jobs/domain/repositories/job_repository.dart';

class SaveJob {
  final JobRepository repository;
  SaveJob(this.repository);
  Future<void> call(int id) => repository.saveJob(id);
}

class UnsaveJob {
  final JobRepository repository;
  UnsaveJob(this.repository);
  Future<void> call(int id) => repository.unsaveJob(id);
}

class CreateAlert {
  final JobRepository repository;
  CreateAlert(this.repository);
  Future<void> call(JobAlert alert) => repository.createAlert(alert);
}

class DeleteAlert {
  final JobRepository repository;
  DeleteAlert(this.repository);
  Future<void> call(int id) => repository.deleteAlert(id);
}
