import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'job_model.g.dart';

@JsonSerializable()
class JobModel extends Equatable {
  final int id;
  final String title;
  final String company;
  final String location;
  final String description;
  @JsonKey(name: 'salary_range')
  final String? salaryRange;
  @JsonKey(name: 'employment_type')
  final String employmentType;
  @JsonKey(name: 'saved')
  final bool saved;

  const JobModel({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.description,
    this.salaryRange,
    required this.employmentType,
    required this.saved,
  });

  @override
  List<Object?> get props => [id, title, company, location, description, salaryRange, employmentType, saved];

  factory JobModel.fromJson(Map<String, dynamic> json) => _$JobModelFromJson(json);
  Map<String, dynamic> toJson() => _$JobModelToJson(this);
}
