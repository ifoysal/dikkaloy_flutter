import 'package:livemcq3/features/auth/domain/repositories/auth_repository.dart';

class Logout {
  final AuthRepository repository;
  Logout(this.repository);

  Future<void> call() => repository.logout();
}
