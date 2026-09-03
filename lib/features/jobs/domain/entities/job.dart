import 'package:equatable/equatable.dart';

class Job extends Equatable {
  final int id;
  final String title;
  final String company;
  final String location;
  final String description;
  final String? salaryRange;
  final String employmentType;
  final bool saved;

  const Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.description,
    this.salaryRange,
    required this.employmentType,
    this.saved = false,
  });

  @override
  List<Object?> get props => [id, title, company, location, description, salaryRange, employmentType, saved];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'company': company,
        'location': location,
        'description': description,
        'salary_range': salaryRange,
        'employment_type': employmentType,
        'saved': saved,
      };

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json['id'] as int,
        title: json['title'] as String,
        company: json['company'] as String,
        location: json['location'] as String,
        description: json['description'] as String,
        salaryRange: json['salary_range'] as String?,
        employmentType: json['employment_type'] as String,
        saved: json['saved'] as bool? ?? false,
      );
}

class JobAlert extends Equatable {
  final int id;
  final String title;
  final String location;
  final String employmentType;

  const JobAlert({required this.id, required this.title, required this.location, required this.employmentType});

  @override
  List<Object?> get props => [id, title, location, employmentType];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'location': location,
        'employment_type': employmentType,
      };

  factory JobAlert.fromJson(Map<String, dynamic> json) => JobAlert(
        id: json['id'] as int,
        title: json['title'] as String,
        location: json['location'] as String,
        employmentType: json['employment_type'] as String,
      );
}

class Application extends Equatable {
  final int id;
  final String jobTitle;
  final String company;
  final String status;
  final String appliedAt;

  const Application({required this.id, required this.jobTitle, required this.company, required this.status, required this.appliedAt});

  @override
  List<Object?> get props => [id, jobTitle, company, status, appliedAt];

  Map<String, dynamic> toJson() => {
        'id': id,
        'job_title': jobTitle,
        'company': company,
        'status': status,
        'applied_at': appliedAt,
      };

  factory Application.fromJson(Map<String, dynamic> json) => Application(
        id: json['id'] as int,
        jobTitle: json['job_title'] as String,
        company: json['company'] as String,
        status: json['status'] as String,
        appliedAt: json['applied_at'] as String,
      );
}
