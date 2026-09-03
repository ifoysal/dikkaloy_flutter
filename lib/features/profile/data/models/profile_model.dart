import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? avatar;
  final String? bio;

  const ProfileModel({required this.id, required this.name, required this.email, this.phone, this.avatar, this.bio});

  @override
  List<Object?> get props => [id, name, email, phone, avatar, bio];

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
