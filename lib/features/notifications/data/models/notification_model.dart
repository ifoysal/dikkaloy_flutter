import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel extends Equatable {
  final int id;
  final String title;
  final String body;
  final String type;
  final Map<String, dynamic>? data;
  @JsonKey(name: 'read_at')
  final String? readAt;
  @JsonKey(name: 'created_at')
  final String createdAt;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    this.data,
    this.readAt,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, title, body, type, data, readAt, createdAt];

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
