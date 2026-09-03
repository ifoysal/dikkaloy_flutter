import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'contest_result_model.g.dart';

@JsonSerializable()
class ContestResultModel extends Equatable {
  final int rank;
  final int score;
  @JsonKey(name: 'total_participants')
  final int totalParticipants;

  const ContestResultModel({required this.rank, required this.score, required this.totalParticipants});

  @override
  List<Object?> get props => [rank, score, totalParticipants];

  factory ContestResultModel.fromJson(Map<String, dynamic> json) => _$ContestResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$ContestResultModelToJson(this);
}
