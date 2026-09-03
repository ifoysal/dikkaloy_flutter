import 'package:equatable/equatable.dart';
import 'package:livemcq3/features/books/domain/entities/book.dart';

abstract class BookRepository {
  Future<List<Book>> getBooks();
  Future<Book> getBook(int id);
  Future<String> getPreviewUrl(int id);
  Future<String> getDownloadUrl(int id);
  Future<Order> purchase(int id, String method);
  Future<List<Order>> getOrders();
  Future<List<Book>> getLibrary();
}

class Order extends Equatable {
  final int id;
  final String bookTitle;
  final double amount;
  final String status;
  final String createdAt;

  const Order({required this.id, required this.bookTitle, required this.amount, required this.status, required this.createdAt});

  @override
  List<Object?> get props => [id, bookTitle, amount, status, createdAt];
}
