import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'contest_model.g.dart';

@JsonSerializable()
class ContestModel extends Equatable {
  final int id;
  final String title;
  final String description;
  @JsonKey(name: 'start_at')
  final String startAt;
  @JsonKey(name: 'end_at')
  final String endAt;
  @JsonKey(name: 'entry_fee')
  final int entryFee;
  final int prize;
  @JsonKey(name: 'participants_count')
  final int participantsCount;
  @JsonKey(name: 'joined')
  final bool joined;

  const ContestModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startAt,
    required this.endAt,
    required this.entryFee,
    required this.prize,
    required this.participantsCount,
    required this.joined,
  });

  @override
  List<Object?> get props => [id, title, description, startAt, endAt, entryFee, prize, participantsCount, joined];

  factory ContestModel.fromJson(Map<String, dynamic> json) => _$ContestModelFromJson(json);
  Map<String, dynamic> toJson() => _$ContestModelToJson(this);
}
