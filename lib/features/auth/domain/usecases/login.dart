import 'package:livemcq3/features/auth/data/models/login_request.dart';
import 'package:livemcq3/features/auth/domain/entities/auth_result.dart';
import 'package:livemcq3/features/auth/domain/repositories/auth_repository.dart' hide AuthResult;

class Login {
  final AuthRepository repository;
  Login(this.repository);

  Future<AuthResult> call(LoginRequest request) => repository.login(request);
}
