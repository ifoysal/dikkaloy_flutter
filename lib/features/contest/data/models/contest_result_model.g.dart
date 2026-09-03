// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contest_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContestResultModel _$ContestResultModelFromJson(Map<String, dynamic> json) =>
    ContestResultModel(
      rank: (json['rank'] as num).toInt(),
      score: (json['score'] as num).toInt(),
      totalParticipants: (json['total_participants'] as num).toInt(),
    );

Map<String, dynamic> _$ContestResultModelToJson(ContestResultModel instance) =>
    <String, dynamic>{
      'rank': instance.rank,
      'score': instance.score,
      'total_participants': instance.totalParticipants,
    };
