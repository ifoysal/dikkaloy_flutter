import 'package:livemcq3/features/auth/domain/repositories/auth_repository.dart';

class VerifyOtp {
  final AuthRepository repository;
  VerifyOtp(this.repository);

  Future<void> call(String phone, String otp) => repository.verifyOtp(phone, otp);
}
