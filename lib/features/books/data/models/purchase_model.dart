import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'purchase_model.g.dart';

@JsonSerializable()
class PurchaseModel extends Equatable {
  final int id;
  final int bookId;
  final String method;
  final String status;
  final String createdAt;

  const PurchaseModel({required this.id, required this.bookId, required this.method, required this.status, required this.createdAt});

  @override
  List<Object?> get props => [id, bookId, method, status, createdAt];

  factory PurchaseModel.fromJson(Map<String, dynamic> json) => _$PurchaseModelFromJson(json);
  Map<String, dynamic> toJson() => _$PurchaseModelToJson(this);
}
