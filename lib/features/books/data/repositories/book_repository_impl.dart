import 'package:dio/dio.dart';
import 'package:livemcq3/core/constants/api_constants.dart';
import 'package:livemcq3/features/books/domain/entities/book.dart';
import 'package:livemcq3/features/books/domain/repositories/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final Dio dio;
  BookRepositoryImpl(this.dio);

  @override
  Future<List<Book>> getBooks() async {
    final response = await dio.get(ApiConstants.books());
    final list = response.data['data'] as List<dynamic>;
    return list.whereType<Map<String, dynamic>>().map((b) => Book(
          id: b['id'] as int,
          title: b['title'] as String,
          author: b['author'] as String,
          cover: b['cover'] as String,
          description: b['description'] as String?,
          price: (b['price'] as num).toDouble(),
          purchased: b['purchased'] as bool? ?? false,
          isPremium: b['is_premium'] as bool? ?? false,
        )).toList();
  }

  @override
  Future<Book> getBook(int id) async {
    final response = await dio.get(ApiConstants.book(id));
    final b = response.data['data'] as Map<String, dynamic>;
    return Book(
      id: b['id'] as int,
      title: b['title'] as String,
      author: b['author'] as String,
      cover: b['cover'] as String,
      description: b['description'] as String?,
      price: (b['price'] as num).toDouble(),
      purchased: b['purchased'] as bool? ?? false,
      isPremium: b['is_premium'] as bool? ?? false,
    );
  }

  @override
  Future<String> getPreviewUrl(int id) async {
    final response = await dio.get(ApiConstants.bookPreview(id));
    return response.data['data']['url'] as String;
  }

  @override
  Future<String> getDownloadUrl(int id) async {
    final response = await dio.get(ApiConstants.bookDownload(id));
    return response.data['data']['download_url'] as String;
  }

  @override
  Future<Order> purchase(int id, String method) async {
    final response = await dio.post(ApiConstants.paymentsInitiate(), data: {'book_id': id, 'method': method});
    final data = response.data['data'] as Map<String, dynamic>;
    return Order(
      id: data['order_id'] as int,
      bookTitle: data['book_title'] as String,
      amount: (data['amount'] as num).toDouble(),
      status: data['status'] as String,
      createdAt: data['created_at'] as String,
    );
  }

  @override
  Future<List<Order>> getOrders() async {
    final response = await dio.get(ApiConstants.orders());
    final list = response.data['data'] as List<dynamic>;
    return list.whereType<Map<String, dynamic>>().map((o) => Order(
          id: o['id'] as int,
          bookTitle: o['book_title'] as String,
          amount: (o['amount'] as num).toDouble(),
          status: o['status'] as String,
          createdAt: o['created_at'] as String,
        )).toList();
  }

  @override
  Future<List<Book>> getLibrary() async {
    final response = await dio.get(ApiConstants.books());
    final list = response.data['data'] as List<dynamic>;
    return list.whereType<Map<String, dynamic>>().where((b) => b['purchased'] == true).map((b) => Book(
          id: b['id'] as int,
          title: b['title'] as String,
          author: b['author'] as String,
          cover: b['cover'] as String,
          price: (b['price'] as num).toDouble(),
          purchased: true,
          isPremium: b['is_premium'] as bool? ?? false,
        )).toList();
  }
}
