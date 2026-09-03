import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:livemcq3/features/jobs/domain/usecases/save_job.dart';
part 'job_provider.g.dart';

final saveJobProvider = Provider<SaveJob>((ref) => SaveJob(ref.read(jobRepositoryProvider)));
final unsaveJobProvider = Provider<UnsaveJob>((ref) => UnsaveJob(ref.read(jobRepositoryProvider)));
final createAlertProvider = Provider<CreateAlert>((ref) => CreateAlert(ref.read(jobRepositoryProvider)));
final deleteAlertProvider = Provider<DeleteAlert>((ref) => DeleteAlert(ref.read(jobRepositoryProvider)));
