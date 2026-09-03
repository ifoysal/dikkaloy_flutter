import 'package:livemcq3/features/mcq/domain/entities/weak_area.dart';
import 'package:livemcq3/features/mcq/domain/repositories/mcq_repository.dart';

class GetWeakAreas {
  final McqRepository repository;

  GetWeakAreas(this.repository);

  Future<List<WeakArea>> call() async {
    return await repository.getWeakAreas();
  }
}
