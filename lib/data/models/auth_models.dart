import 'package:livemcq3/data/models/user_model.dart';

class LoginRequestModel {
  final String email;
  final String password;

  LoginRequestModel({required this.email, required this.password});

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

class PhoneLoginRequestModel {
  final String phone;

  PhoneLoginRequestModel({required this.phone});

  Map<String, dynamic> toJson() => {'phone': phone};
}

class RegisterRequestModel {
  final String name;
  final String email;
  final String password;
  final String? phone;

  RegisterRequestModel({required this.name, required this.email, required this.password, this.phone});

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        if (phone != null) 'phone': phone,
      };
}

class OtpVerifyRequestModel {
  final String phone;
  final String otp;
  final String? purpose;

  OtpVerifyRequestModel({required this.phone, required this.otp, this.purpose});

  Map<String, dynamic> toJson() => {'phone': phone, 'otp': otp, 'purpose': purpose};
}

class AuthResponseModel {
  final String token;
  final UserModel user;

  AuthResponseModel({required this.token, required this.user});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      token: json['token'] ?? '',
      user: UserModel.fromJson(json['user'] ?? {}),
    );
  }
}
