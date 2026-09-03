import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'job_alert_model.g.dart';

@JsonSerializable()
class JobAlertModel extends Equatable {
  final int? id;
  final String title;
  final String location;
  @JsonKey(name: 'employment_type')
  final String employmentType;

  const JobAlertModel({this.id, required this.title, required this.location, required this.employmentType});

  @override
  List<Object?> get props => [id, title, location, employmentType];

  factory JobAlertModel.fromJson(Map<String, dynamic> json) => _$JobAlertModelFromJson(json);
  Map<String, dynamic> toJson() => _$JobAlertModelToJson(this);
}
