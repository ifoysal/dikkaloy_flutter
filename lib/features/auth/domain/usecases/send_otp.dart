import 'package:livemcq3/features/auth/domain/repositories/auth_repository.dart';

class SendOtp {
  final AuthRepository repository;
  SendOtp(this.repository);

  Future<void> call(String phone) => repository.sendOtp(phone);
}
