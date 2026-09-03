import 'package:equatable/equatable.dart';
import 'package:livemcq3/features/auth/data/models/user_model.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? avatar;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatar,
  });

  factory User.fromModel(UserModel model) => User(
        id: model.id,
        name: model.name,
        email: model.email,
        phone: model.phone,
        avatar: model.avatar,
      );

  @override
  List<Object?> get props => [id, name, email, phone, avatar];
}
