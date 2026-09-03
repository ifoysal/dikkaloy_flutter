class SyllabusItemModel {
  final int id;
  final String name;
  final String? description;

  SyllabusItemModel({
    required this.id,
    required this.name,
    this.description,
  });

  factory SyllabusItemModel.fromJson(Map<String, dynamic> json) {
    return SyllabusItemModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'],
    );
  }
}

class SyllabusDetailModel {
  final int categoryId;
  final String categoryName;
  final List<SyllabusItemModel> items;

  SyllabusDetailModel({
    required this.categoryId,
    required this.categoryName,
    required this.items,
  });

  factory SyllabusDetailModel.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>? ?? [])
        .map((e) => SyllabusItemModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return SyllabusDetailModel(
      categoryId: json['category_id'] ?? json['id'] ?? 0,
      categoryName: json['category_name'] ?? json['name'] ?? '',
      items: items,
    );
  }
}
