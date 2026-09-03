// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseModel _$PurchaseModelFromJson(Map<String, dynamic> json) =>
    PurchaseModel(
      id: (json['id'] as num).toInt(),
      bookId: (json['bookId'] as num).toInt(),
      method: json['method'] as String,
      status: json['status'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$PurchaseModelToJson(PurchaseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bookId': instance.bookId,
      'method': instance.method,
      'status': instance.status,
      'createdAt': instance.createdAt,
    };
