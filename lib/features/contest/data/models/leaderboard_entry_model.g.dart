// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaderboardEntryModel _$LeaderboardEntryModelFromJson(
        Map<String, dynamic> json) =>
    LeaderboardEntryModel(
      userId: (json['user_id'] as num).toInt(),
      name: json['name'] as String,
      score: (json['score'] as num).toInt(),
    );

Map<String, dynamic> _$LeaderboardEntryModelToJson(
        LeaderboardEntryModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'score': instance.score,
    };
