class CvTemplateModel {
  final int id;
  final String name;
  final String? description;
  final String? previewImage;

  CvTemplateModel({
    required this.id,
    required this.name,
    this.description,
    this.previewImage,
  });

  factory CvTemplateModel.fromJson(Map<String, dynamic> json) {
    return CvTemplateModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'],
      previewImage: json['preview_image'],
    );
  }
}

class CvModel {
  final int id;
  final String title;
  final String status;
  final CvTemplateModel? template;

  CvModel({
    required this.id,
    required this.title,
    required this.status,
    this.template,
  });

  factory CvModel.fromJson(Map<String, dynamic> json) {
    final templateJson = json['template'] as Map<String, dynamic>?;
    return CvModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      status: json['status'] ?? 'draft',
      template: templateJson != null ? CvTemplateModel.fromJson(templateJson) : null,
    );
  }
}
