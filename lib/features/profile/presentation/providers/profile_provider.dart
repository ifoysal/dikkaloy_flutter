import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:livemcq3/features/profile/domain/usecases/update_profile.dart';
part 'profile_provider.g.dart';

final updateProfileProvider = Provider<UpdateProfile>((ref) => UpdateProfile(ref.read(profileRepositoryProvider)));
final deleteAccountProvider = Provider<DeleteAccount>((ref) => DeleteAccount(ref.read(profileRepositoryProvider)));
