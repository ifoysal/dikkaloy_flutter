import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'bookmark_model.g.dart';

@JsonSerializable()
class BookmarkModel extends Equatable {
  final int id;
  @JsonKey(name: 'question_id')
  final int questionId;
  @JsonKey(name: 'created_at')
  final String createdAt;

  const BookmarkModel({
    required this.id,
    required this.questionId,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, questionId, createdAt];

  factory BookmarkModel.fromJson(Map<String, dynamic> json) => _$BookmarkModelFromJson(json);
  Map<String, dynamic> toJson() => _$BookmarkModelToJson(this);
}
