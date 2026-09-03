import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'cv_model.g.dart';

@JsonSerializable()
class CvModel extends Equatable {
  final int id;
  final String title;
  final String template;
  final Map<String, dynamic> sections;
  final String? pdfUrl;

  const CvModel({required this.id, required this.title, required this.template, required this.sections, this.pdfUrl});

  @override
  List<Object?> get props => [id, title, template, sections, pdfUrl];

  factory CvModel.fromJson(Map<String, dynamic> json) => _$CvModelFromJson(json);
  Map<String, dynamic> toJson() => _$CvModelToJson(this);
}
