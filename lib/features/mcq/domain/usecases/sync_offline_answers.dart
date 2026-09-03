import 'package:livemcq3/features/mcq/domain/entities/answer.dart';
import 'package:livemcq3/features/mcq/domain/repositories/mcq_repository.dart';

class SyncOfflineAnswers {
  final McqRepository repository;
  SyncOfflineAnswers(this.repository);

  Future<void> call(String sessionId, List<Answer> answers) => repository.syncOfflineAnswers(sessionId, answers);
}
