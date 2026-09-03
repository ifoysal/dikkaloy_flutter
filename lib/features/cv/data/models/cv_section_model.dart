import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'cv_section_model.g.dart';

@JsonSerializable()
class CvSectionModel extends Equatable {
  final String key;
  final String value;

  const CvSectionModel({required this.key, required this.value});

  @override
  List<Object?> get props => [key, value];

  factory CvSectionModel.fromJson(Map<String, dynamic> json) => _$CvSectionModelFromJson(json);
  Map<String, dynamic> toJson() => _$CvSectionModelToJson(this);
}
