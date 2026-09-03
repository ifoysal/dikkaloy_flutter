import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'application_model.g.dart';

@JsonSerializable()
class ApplicationModel extends Equatable {
  final int id;
  @JsonKey(name: 'job_title')
  final String jobTitle;
  final String company;
  final String status;
  @JsonKey(name: 'applied_at')
  final String appliedAt;

  const ApplicationModel({
    required this.id,
    required this.jobTitle,
    required this.company,
    required this.status,
    required this.appliedAt,
  });

  @override
  List<Object?> get props => [id, jobTitle, company, status, appliedAt];

  factory ApplicationModel.fromJson(Map<String, dynamic> json) => _$ApplicationModelFromJson(json);
  Map<String, dynamic> toJson() => _$ApplicationModelToJson(this);
}
