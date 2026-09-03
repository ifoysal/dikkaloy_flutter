import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/storage/secure_storage.dart';
import 'package:livemcq3/core/network/dio_client.dart';
import 'package:livemcq3/core/storage/hive_boxes.dart';
import 'package:livemcq3/routing/app_router.dart';
import 'package:livemcq3/features/mcq/data/repositories/mcq_repository_impl.dart';
import 'package:livemcq3/features/mcq/data/datasources/mcq_local_data_source.dart';
import 'package:livemcq3/features/mcq/domain/repositories/mcq_repository.dart';
import 'package:livemcq3/features/contest/data/repositories/contest_repository_impl.dart';
import 'package:livemcq3/features/contest/domain/repositories/contest_repository.dart';
import 'package:livemcq3/features/jobs/data/repositories/job_repository_impl.dart';
import 'package:livemcq3/features/jobs/domain/repositories/job_repository.dart';
import 'package:livemcq3/features/books/data/repositories/book_repository_impl.dart';
import 'package:livemcq3/features/books/domain/repositories/book_repository.dart';
import 'package:livemcq3/features/cv/data/repositories/cv_repository_impl.dart';
import 'package:livemcq3/features/cv/domain/repositories/cv_repository.dart';
import 'package:livemcq3/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:livemcq3/features/profile/domain/repositories/profile_repository.dart';
import 'package:livemcq3/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:livemcq3/features/notifications/domain/repositories/notification_repository.dart';
import 'package:livemcq3/features/home/data/repositories/home_repository_impl.dart';
import 'package:livemcq3/features/home/domain/repositories/home_repository.dart';
import 'package:livemcq3/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:livemcq3/features/auth/domain/repositories/auth_repository.dart';
part 'app_providers.g.dart';

@riverpod
SecureStorage secureStorage(SecureStorageRef ref) => SecureStorage();

@riverpod
DioClient dioClient(DioClientRef ref) {
  final storage = ref.read(secureStorageProvider);
  return DioClient(secureStorage: storage);
}

@riverpod
GoRouter router(RouterRef ref) {
  final storage = ref.read(secureStorageProvider);
  final dio = ref.read(dioClientProvider);
  return createRouter(storage, dio);
}

@riverpod
McqRepository mcqRepository(McqRepositoryRef ref) {
  final dio = ref.read(dioClientProvider);
  return McqRepositoryImpl(dio: dio.dio, localDataSource: McqLocalDataSource());
}

@riverpod
ContestRepository contestRepository(ContestRepositoryRef ref) {
  final dio = ref.read(dioClientProvider);
  return ContestRepositoryImpl(dio.dio);
}

@riverpod
JobRepository jobRepository(JobRepositoryRef ref) {
  final dio = ref.read(dioClientProvider);
  return JobRepositoryImpl(dio.dio);
}

@riverpod
BookRepository bookRepository(BookRepositoryRef ref) {
  final dio = ref.read(dioClientProvider);
  return BookRepositoryImpl(dio.dio);
}

@riverpod
CvRepository cvRepository(CvRepositoryRef ref) {
  final dio = ref.read(dioClientProvider);
  return CvRepositoryImpl(dio.dio);
}

@riverpod
ProfileRepository profileRepository(ProfileRepositoryRef ref) {
  final dio = ref.read(dioClientProvider);
  return ProfileRepositoryImpl(dio.dio);
}

@riverpod
NotificationRepository notificationRepository(NotificationRepositoryRef ref) {
  final dio = ref.read(dioClientProvider);
  return NotificationRepositoryImpl(dio.dio);
}

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  final dio = ref.read(dioClientProvider);
  return HomeRepositoryImpl(dio.dio);
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final dio = ref.read(dioClientProvider);
  return AuthRepositoryImpl(dio.dio, secureStorage: dio.secureStorage);
}

@riverpod
FutureOr<void> initializeApp(InitializeAppRef ref) async {
  await HiveBoxes.init();
}
