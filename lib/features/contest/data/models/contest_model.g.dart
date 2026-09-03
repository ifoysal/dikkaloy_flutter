// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contest_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContestModel _$ContestModelFromJson(Map<String, dynamic> json) => ContestModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      startAt: json['start_at'] as String,
      endAt: json['end_at'] as String,
      entryFee: (json['entry_fee'] as num).toInt(),
      prize: (json['prize'] as num).toInt(),
      participantsCount: (json['participants_count'] as num).toInt(),
      joined: json['joined'] as bool,
    );

Map<String, dynamic> _$ContestModelToJson(ContestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'start_at': instance.startAt,
      'end_at': instance.endAt,
      'entry_fee': instance.entryFee,
      'prize': instance.prize,
      'participants_count': instance.participantsCount,
      'joined': instance.joined,
    };
