class JobCircularModel {
  final int id;
  final int jobCategoryId;
  final String title;
  final String companyName;
  final String description;
  final String? requirements;
  final String? salaryRange;
  final String? location;
  final String deadline;
  final String status;
  final String? sourceName;
  final String? applicationLink;
  final String? sourceUrl;
  final JobCategoryModel? category;
  final String? companyLogo;

  JobCircularModel({
    required this.id,
    required this.jobCategoryId,
    required this.title,
    required this.companyName,
    required this.description,
    this.requirements,
    this.salaryRange,
    this.location,
    required this.deadline,
    required this.status,
    this.sourceName,
    this.applicationLink,
    this.sourceUrl,
    this.category,
    this.companyLogo,
  });

  factory JobCircularModel.fromJson(Map<String, dynamic> json) {
    return JobCircularModel(
      id: json['id'] ?? 0,
      jobCategoryId: json['job_category_id'] ?? 0,
      title: json['title'] ?? '',
      companyName: json['company_name'] ?? '',
      description: json['description'] ?? '',
      requirements: json['requirements'],
      salaryRange: json['salary_range'],
      location: json['location'],
      deadline: json['deadline']?.toString() ?? '',
      status: json['status'] ?? 'pending',
      sourceName: json['source_name'],
      applicationLink: json['application_link'],
      sourceUrl: json['source_url'],
      category: json['category'] != null ? JobCategoryModel.fromJson(json['category'] as Map<String, dynamic>) : null,
      companyLogo: json['company_logo'],
    );
  }
}

class JobCategoryModel {
  final int id;
  final String name;

  JobCategoryModel({required this.id, required this.name});

  factory JobCategoryModel.fromJson(Map<String, dynamic> json) {
    return JobCategoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class JobAlertModel {
  final int id;
  final int userId;
  final String? keyword;
  final int? jobCategoryId;
  final JobCategoryModel? category;

  JobAlertModel({
    required this.id,
    required this.userId,
    this.keyword,
    this.jobCategoryId,
    this.category,
  });

  factory JobAlertModel.fromJson(Map<String, dynamic> json) {
    return JobAlertModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      keyword: json['keyword'],
      jobCategoryId: json['job_category_id'],
      category: json['category'] != null ? JobCategoryModel.fromJson(json['category'] as Map<String, dynamic>) : null,
    );
  }
}

class SavedJobModel {
  final int id;
  final int userId;
  final int jobCircularId;
  final JobCircularModel? job;

  SavedJobModel({
    required this.id,
    required this.userId,
    required this.jobCircularId,
    this.job,
  });

  factory SavedJobModel.fromJson(Map<String, dynamic> json) {
    return SavedJobModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      jobCircularId: json['job_circular_id'] ?? 0,
      job: json['job'] != null ? JobCircularModel.fromJson(json['job'] as Map<String, dynamic>) : null,
    );
  }
}
