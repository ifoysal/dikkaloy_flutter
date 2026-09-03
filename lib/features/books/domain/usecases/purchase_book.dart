import 'package:livemcq3/features/books/domain/entities/book.dart';
import 'package:livemcq3/features/books/domain/repositories/book_repository.dart';

class PurchaseBook {
  final BookRepository repository;
  PurchaseBook(this.repository);
  Future<Order> call(int id, String method) => repository.purchase(id, method);
}

class GetLibrary {
  final BookRepository repository;
  GetLibrary(this.repository);
  Future<List<Book>> call() => repository.getLibrary();
}

class GetPreviewUrl {
  final BookRepository repository;
  GetPreviewUrl(this.repository);
  Future<String> call(int id) => repository.getPreviewUrl(id);
}
