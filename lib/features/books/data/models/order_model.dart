import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel extends Equatable {
  final int id;
  @JsonKey(name: 'book_title')
  final String bookTitle;
  final double amount;
  final String status;
  @JsonKey(name: 'created_at')
  final String createdAt;

  const OrderModel({required this.id, required this.bookTitle, required this.amount, required this.status, required this.createdAt});

  @override
  List<Object?> get props => [id, bookTitle, amount, status, createdAt];

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
