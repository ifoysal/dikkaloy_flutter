import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'leaderboard_entry_model.g.dart';

@JsonSerializable()
class LeaderboardEntryModel extends Equatable {
  @JsonKey(name: 'user_id')
  final int userId;
  final String name;
  final int score;

  const LeaderboardEntryModel({required this.userId, required this.name, required this.score});

  @override
  List<Object?> get props => [userId, name, score];

  factory LeaderboardEntryModel.fromJson(Map<String, dynamic> json) => _$LeaderboardEntryModelFromJson(json);
  Map<String, dynamic> toJson() => _$LeaderboardEntryModelToJson(this);
}
