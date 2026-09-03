import 'package:livemcq3/features/mcq/domain/entities/category.dart';
import 'package:livemcq3/features/mcq/domain/repositories/mcq_repository.dart';

class GetCategories {
  final McqRepository repository;
  GetCategories(this.repository);

  Future<List<Category>> call() => repository.getCategories();
}
