import 'package:livemcq3/features/mcq/domain/entities/bookmark.dart';
import 'package:livemcq3/features/mcq/domain/repositories/mcq_repository.dart';

class GetBookmarks {
  final McqRepository repository;
  GetBookmarks(this.repository);
  Future<List<Bookmark>> call() => repository.getBookmarks();
}
