import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final String? description;
  final int questionCount;
  final bool isPremium;
  final int pricePoisha;
  final double priceBdt;

  const Category({
    required this.id,
    required this.name,
    this.description,
    required this.questionCount,
    this.isPremium = false,
    this.pricePoisha = 0,
    this.priceBdt = 0,
  });

  @override
  List<Object?> get props => [id, name, description, questionCount, isPremium, pricePoisha, priceBdt];
}
