import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'weak_area_model.g.dart';

@JsonSerializable()
class WeakAreaModel extends Equatable {
  final String topic;
  final double score;
  final int attempts;

  const WeakAreaModel({required this.topic, required this.score, required this.attempts});

  @override
  List<Object?> get props => [topic, score, attempts];

  factory WeakAreaModel.fromJson(Map<String, dynamic> json) => _$WeakAreaModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeakAreaModelToJson(this);
}
