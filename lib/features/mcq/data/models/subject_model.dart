import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'subject_model.g.dart';

@JsonSerializable()
class SubjectModel extends Equatable {
  final int id;
  final int categoryId;
  final String name;
  @JsonKey(name: 'chapter_count')
  final int chapterCount;

  const SubjectModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.chapterCount,
  });

  @override
  List<Object?> get props => [id, categoryId, name, chapterCount];

  factory SubjectModel.fromJson(Map<String, dynamic> json) => _$SubjectModelFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectModelToJson(this);
}
