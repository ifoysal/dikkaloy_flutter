import 'package:livemcq3/features/profile/domain/entities/profile.dart';
import 'package:livemcq3/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfile {
  final ProfileRepository repository;
  UpdateProfile(this.repository);
  Future<Profile> call(Map<String, dynamic> data) => repository.updateProfile(data);
}

class DeleteAccount {
  final ProfileRepository repository;
  DeleteAccount(this.repository);
  Future<void> call() => repository.deleteAccount();
}
