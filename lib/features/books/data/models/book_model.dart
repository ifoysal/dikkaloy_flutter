import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'book_model.g.dart';

@JsonSerializable()
class BookModel extends Equatable {
  final int id;
  final String title;
  final String author;
  final String cover;
  final String? description;
  final double price;
  @JsonKey(name: 'is_purchased')
  final bool isPurchased;
  @JsonKey(name: 'is_premium')
  final bool isPremium;

  const BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.cover,
    this.description,
    required this.price,
    required this.isPurchased,
    required this.isPremium,
  });

  @override
  List<Object?> get props => [id, title, author, cover, description, price, isPurchased, isPremium];

  factory BookModel.fromJson(Map<String, dynamic> json) => _$BookModelFromJson(json);
  Map<String, dynamic> toJson() => _$BookModelToJson(this);
}
