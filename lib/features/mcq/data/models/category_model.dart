import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:livemcq3/features/mcq/domain/entities/category.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel extends Equatable {
  final int id;
  final String name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'subjects_count')
  final int questionCount;
  @JsonKey(name: 'is_premium')
  final bool isPremium;
  @JsonKey(name: 'price_poisha')
  final int pricePoisha;

  const CategoryModel({
    required this.id,
    required this.name,
    this.description,
    required this.questionCount,
    this.isPremium = false,
    this.pricePoisha = 0,
  });

  @override
  List<Object?> get props => [id, name, description, questionCount, isPremium, pricePoisha];

  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  Category toEntity() => Category(
        id: id,
        name: name,
        description: description,
        questionCount: questionCount,
        isPremium: isPremium,
        pricePoisha: pricePoisha,
        priceBdt: pricePoisha / 100,
      );
}
