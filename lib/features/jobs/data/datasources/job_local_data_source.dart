import 'package:hive/hive.dart';
import 'package:livemcq3/core/storage/hive_boxes.dart';
import 'package:livemcq3/features/jobs/domain/entities/job.dart';

class JobLocalDataSource {
  JobLocalDataSource();

  Future<void> saveJob(Job job) async {
    final box = HiveBoxes.getSavedJobsBox();
    await box.put(job.id, job.toJson());
  }

  Job? getJob(int id) {
    final box = HiveBoxes.getSavedJobsBox();
    final data = box.get(id);
    if (data == null) return null;
    return Job.fromJson(data as Map<String, dynamic>);
  }

  Future<void> removeJob(int id) async {
    final box = HiveBoxes.getSavedJobsBox();
    await box.delete(id);
  }

  List<Job> getAllSaved() {
    final box = HiveBoxes.getSavedJobsBox();
    return box.values.map((e) => Job.fromJson(e as Map<String, dynamic>)).toList();
  }
}
