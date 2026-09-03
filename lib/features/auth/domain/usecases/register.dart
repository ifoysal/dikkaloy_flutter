import 'package:livemcq3/features/auth/data/models/register_request.dart';
import 'package:livemcq3/features/auth/domain/entities/auth_result.dart';
import 'package:livemcq3/features/auth/domain/repositories/auth_repository.dart' hide AuthResult;

class Register {
  final AuthRepository repository;
  Register(this.repository);

  Future<AuthResult> call(RegisterRequest request) => repository.register(request);
}
