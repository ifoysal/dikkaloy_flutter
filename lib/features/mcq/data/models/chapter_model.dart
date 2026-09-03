import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'chapter_model.g.dart';

@JsonSerializable()
class ChapterModel extends Equatable {
  final int id;
  final int subjectId;
  final String name;
  final String? description;

  const ChapterModel({
    required this.id,
    required this.subjectId,
    required this.name,
    this.description,
  });

  @override
  List<Object?> get props => [id, subjectId, name, description];

  factory ChapterModel.fromJson(Map<String, dynamic> json) => _$ChapterModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChapterModelToJson(this);
}
