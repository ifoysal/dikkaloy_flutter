import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final int id;
  final String title;
  final String author;
  final String cover;
  final String? description;
  final double price;
  final bool purchased;
  final bool isPremium;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.cover,
    this.description,
    required this.price,
    this.purchased = false,
    this.isPremium = false,
  });

  @override
  List<Object?> get props => [id, title, author, cover, description, price, purchased, isPremium];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'cover': cover,
        'description': description,
        'price': price,
        'purchased': purchased,
        'is_premium': isPremium,
      };

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json['id'] as int,
        title: json['title'] as String,
        author: json['author'] as String,
        cover: json['cover'] as String,
        description: json['description'] as String?,
        price: (json['price'] as num).toDouble(),
        purchased: json['purchased'] as bool? ?? false,
        isPremium: json['is_premium'] as bool? ?? false,
      );
}
