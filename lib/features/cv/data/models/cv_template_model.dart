import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'cv_template_model.g.dart';

@JsonSerializable()
class CvTemplateModel extends Equatable {
  final int id;
  final String name;
  final String preview;

  const CvTemplateModel({required this.id, required this.name, required this.preview});

  @override
  List<Object?> get props => [id, name, preview];

  factory CvTemplateModel.fromJson(Map<String, dynamic> json) => _$CvTemplateModelFromJson(json);
  Map<String, dynamic> toJson() => _$CvTemplateModelToJson(this);
}
