import 'package:livemcq3/features/mcq/domain/entities/answer.dart';
import 'package:livemcq3/features/mcq/domain/entities/exam_session.dart';
import 'package:livemcq3/features/mcq/domain/repositories/mcq_repository.dart';

class SubmitExam {
  final McqRepository repository;
  SubmitExam(this.repository);

  Future<ExamResult> call(int categoryId, List<Answer> answers) => repository.submitExam(categoryId, answers);
}
