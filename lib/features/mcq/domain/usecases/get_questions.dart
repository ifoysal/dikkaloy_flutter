import 'package:livemcq3/features/mcq/domain/entities/question.dart';
import 'package:livemcq3/features/mcq/domain/repositories/mcq_repository.dart';

class GetQuestions {
  final McqRepository repository;
  GetQuestions(this.repository);

  Future<List<Question>> call(int categoryId) => repository.getQuestions(categoryId);
}
