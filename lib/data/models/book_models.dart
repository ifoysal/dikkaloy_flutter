import 'package:livemcq3/features/books/domain/entities/book.dart';

class BookModel {
  final int id;
  final String title;
  final String author;
  final String? description;
  final int price;
  final String? coverImage;
  final String? previewFilePath;
  final String? filePath;
  final bool isPublished;
  final bool isPurchased;
  final String? purchasedAt;

  static bool _toBool(dynamic value) {
    if (value is bool) return value;
    if (value is int) return value != 0;
    if (value is String) return value.toLowerCase() == 'true' || value == '1';
    return false;
  }

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    this.description,
    this.price = 0,
    this.coverImage,
    this.previewFilePath,
    this.filePath,
    this.isPublished = true,
    this.isPurchased = false,
    this.purchasedAt,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      description: json['description'],
      price: json['price'] ?? 0,
      coverImage: json['cover_image'],
      previewFilePath: json['preview_file_path'],
      filePath: json['file_path'],
      isPublished: _toBool(json['is_published'] ?? true),
      isPurchased: json['is_purchased'] ?? false,
      purchasedAt: json['purchased_at']?.toString(),
    );
  }

  Book toEntity() => Book(
        id: id,
        title: title,
        author: author,
        cover: coverImage ?? '',
        description: description,
        price: price.toDouble(),
        purchased: isPurchased,
        isPremium: false,
      );
}

class PurchaseModel {
  final int id;
  final int userId;
  final int bookId;
  final String transactionId;
  final double amount;
  final String status;
  final String? createdAt;
  final BookModel? book;

  PurchaseModel({
    required this.id,
    required this.userId,
    required this.bookId,
    required this.transactionId,
    required this.amount,
    required this.status,
    this.createdAt,
    this.book,
  });

  factory PurchaseModel.fromJson(Map<String, dynamic> json) {
    return PurchaseModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      bookId: json['book_id'] ?? 0,
      transactionId: json['transaction_id'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      status: json['status'] ?? '',
      createdAt: json['created_at']?.toString(),
      book: json['book'] != null ? BookModel.fromJson(json['book'] as Map<String, dynamic>) : null,
    );
  }
}

class OrderModel {
  final int id;
  final String type;
  final int itemId;
  final String itemTitle;
  final double amount;
  final String status;
  final String? transactionId;
  final String? createdAt;

  OrderModel({
    required this.id,
    required this.type,
    required this.itemId,
    required this.itemTitle,
    required this.amount,
    required this.status,
    this.transactionId,
    this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? 0,
      type: json['type'] ?? '',
      itemId: json['item_id'] ?? 0,
      itemTitle: json['item_title'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      status: json['status'] ?? '',
      transactionId: json['transaction_id'],
      createdAt: json['created_at']?.toString(),
    );
  }
}
