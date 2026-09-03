import 'package:livemcq3/features/mcq/domain/repositories/mcq_repository.dart';

class BookmarkQuestion {
  final McqRepository repository;
  BookmarkQuestion(this.repository);

  Future<void> call(int questionId, {bool bookmark = true}) {
    return bookmark ? repository.bookmarkQuestion(questionId) : repository.unbookmarkQuestion(questionId);
  }
}
