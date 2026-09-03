import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'saved_job_model.g.dart';

@JsonSerializable()
class SavedJobModel extends Equatable {
  final int id;
  final String title;
  final String company;

  const SavedJobModel({required this.id, required this.title, required this.company});

  @override
  List<Object?> get props => [id, title, company];

  factory SavedJobModel.fromJson(Map<String, dynamic> json) => _$SavedJobModelFromJson(json);
  Map<String, dynamic> toJson() => _$SavedJobModelToJson(this);
}
