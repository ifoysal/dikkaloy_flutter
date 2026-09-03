// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookModel _$BookModelFromJson(Map<String, dynamic> json) => BookModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      author: json['author'] as String,
      cover: json['cover'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      isPurchased: json['is_purchased'] as bool,
      isPremium: json['is_premium'] as bool,
    );

Map<String, dynamic> _$BookModelToJson(BookModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'cover': instance.cover,
      'description': instance.description,
      'price': instance.price,
      'is_purchased': instance.isPurchased,
      'is_premium': instance.isPremium,
    };
