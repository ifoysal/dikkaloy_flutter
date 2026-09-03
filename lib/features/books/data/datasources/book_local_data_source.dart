import 'package:hive/hive.dart';
import 'package:livemcq3/core/storage/hive_boxes.dart';
import 'package:livemcq3/features/books/domain/entities/book.dart';

class BookLocalDataSource {
  BookLocalDataSource();

  Future<void> saveBook(Book book) async {
    final box = HiveBoxes.getLibraryBooksBox();
    await box.put(book.id, book.toJson());
  }

  Book? getBook(int id) {
    final box = HiveBoxes.getLibraryBooksBox();
    final data = box.get(id);
    if (data == null) return null;
    return Book.fromJson(data as Map<String, dynamic>);
  }

  Future<void> removeBook(int id) async {
    final box = HiveBoxes.getLibraryBooksBox();
    await box.delete(id);
  }

  List<Book> getAllLibrary() {
    final box = HiveBoxes.getLibraryBooksBox();
    return box.values.map((e) => Book.fromJson(e as Map<String, dynamic>)).toList();
  }
}
