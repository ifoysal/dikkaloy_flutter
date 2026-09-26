import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:livemcq3/features/auth/presentation/screens/splash_screen.dart';
import 'package:livemcq3/features/auth/presentation/screens/auth_screen.dart';
import 'package:livemcq3/features/home/presentation/screens/home_screen.dart';
import 'package:livemcq3/features/mcq/presentation/screens/categories_screen.dart';
import 'package:livemcq3/features/mcq/presentation/screens/practice_screen.dart';
import 'package:livemcq3/features/mcq/presentation/screens/exam_screen.dart';
import 'package:livemcq3/features/mcq/presentation/screens/analytics_screen.dart';
import 'package:livemcq3/features/mcq/presentation/screens/offline_download_screen.dart';
import 'package:livemcq3/features/contest/presentation/screens/contest_list_screen.dart';
import 'package:livemcq3/features/contest/presentation/screens/contest_detail_screen.dart';
import 'package:livemcq3/features/contest/presentation/screens/contest_arena_screen.dart';
import 'package:livemcq3/features/contest/presentation/screens/contest_result_screen.dart';
import 'package:livemcq3/features/contest/presentation/screens/waiting_room_screen.dart';
import 'package:livemcq3/features/jobs/presentation/screens/job_list_screen.dart';
import 'package:livemcq3/features/jobs/presentation/screens/job_detail_screen.dart';
import 'package:livemcq3/features/jobs/presentation/screens/saved_jobs_screen.dart';
import 'package:livemcq3/features/jobs/presentation/screens/job_alerts_screen.dart';
import 'package:livemcq3/features/jobs/presentation/screens/applications_screen.dart';
import 'package:livemcq3/features/books/presentation/screens/book_catalog_screen.dart';
import 'package:livemcq3/features/books/presentation/screens/book_detail_screen.dart';
import 'package:livemcq3/features/books/presentation/screens/book_reader_screen.dart';
import 'package:livemcq3/features/books/presentation/screens/library_screen.dart';
import 'package:livemcq3/features/books/presentation/screens/order_history_screen.dart';
import 'package:livemcq3/features/books/presentation/screens/checkout_screen.dart';
import 'package:livemcq3/features/cv/presentation/screens/cv_list_screen.dart';
import 'package:livemcq3/features/cv/presentation/screens/cv_edit_screen.dart';
import 'package:livemcq3/features/cv/presentation/screens/cv_preview_screen.dart';
import 'package:livemcq3/features/profile/presentation/screens/profile_screen.dart';
import 'package:livemcq3/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:livemcq3/features/profile/presentation/screens/settings_screen.dart';
import 'package:livemcq3/features/profile/presentation/screens/notification_preferences_screen.dart';
import 'package:livemcq3/features/profile/presentation/screens/orders_screen.dart';
import 'package:livemcq3/features/profile/presentation/screens/app_lock_screen.dart';
import 'package:livemcq3/features/notifications/presentation/screens/notification_center_screen.dart';
import 'package:livemcq3/features/carrier_billing/presentation/screens/carrier_billing_screen.dart';
import 'package:livemcq3/features/carrier_billing/presentation/screens/subscription_status_screen.dart';
import 'package:livemcq3/core/network/dio_client.dart';
import 'package:livemcq3/core/providers/carrier_billing_provider.dart';
import 'package:livemcq3/core/network/websocket_client.dart';
import 'package:livemcq3/core/storage/secure_storage.dart';
import 'package:livemcq3/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:livemcq3/features/mcq/data/repositories/mcq_repository_impl.dart';
import 'package:livemcq3/features/mcq/data/datasources/mcq_local_data_source.dart';
import 'package:livemcq3/features/contest/data/repositories/contest_repository_impl.dart';
import 'package:livemcq3/features/jobs/data/repositories/job_repository_impl.dart';
import 'package:livemcq3/features/books/data/repositories/book_repository_impl.dart';
import 'package:livemcq3/features/cv/data/repositories/cv_repository_impl.dart';
import 'package:livemcq3/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:livemcq3/features/notifications/data/repositories/notification_repository_impl.dart';

GoRouter createRouter(SecureStorage secureStorage, DioClient dioClient) {
  final authRepo = AuthRepositoryImpl(dioClient.dio, secureStorage: secureStorage);
  final mcqRepo = McqRepositoryImpl(dio: dioClient.dio, localDataSource: McqLocalDataSource());
  final contestRepo = ContestRepositoryImpl(dioClient.dio);
  final jobRepo = JobRepositoryImpl(dioClient.dio);
  final bookRepo = BookRepositoryImpl(dioClient.dio);
  final cvRepo = CvRepositoryImpl(dioClient.dio);
  final notificationRepo = NotificationRepositoryImpl(dioClient.dio);
  final profileRepo = ProfileRepositoryImpl(dioClient.dio);

  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/auth', builder: (_, __) => const AuthScreen()),
      GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
      GoRoute(path: '/categories', builder: (_, __) => const CategoriesScreen()),
      GoRoute(path: '/practice/:categoryId', builder: (_, state) => PracticeScreen(categoryId: int.parse(state.pathParameters['categoryId']!))),
      GoRoute(path: '/exam/:categoryId', builder: (_, state) => ExamScreen(categoryId: int.parse(state.pathParameters['categoryId']!))),
      GoRoute(path: '/analytics', builder: (_, __) => const AnalyticsScreen()),
      GoRoute(path: '/offline', builder: (_, __) => const OfflineDownloadScreen()),
      GoRoute(path: '/contests', builder: (_, __) => const ContestListScreen()),
      GoRoute(path: '/contests/:id', builder: (_, state) => ContestDetailScreen(contestId: int.parse(state.pathParameters['id']!))),
      GoRoute(path: '/contests/:id/arena', builder: (_, state) => ContestArenaScreen(contestId: int.parse(state.pathParameters['id']!))),
      GoRoute(path: '/contests/:id/result', builder: (_, state) => ContestResultScreen(contestId: int.parse(state.pathParameters['id']!))),
      GoRoute(path: '/jobs', builder: (_, __) => const JobListScreen()),
      GoRoute(path: '/jobs/:id', builder: (_, state) => JobDetailScreen(jobId: int.parse(state.pathParameters['id']!))),
      GoRoute(path: '/saved-jobs', builder: (_, __) => const SavedJobsScreen()),
      GoRoute(path: '/job-alerts', builder: (_, __) => const JobAlertsScreen()),
      GoRoute(path: '/applications', builder: (_, __) => const ApplicationsScreen()),
      GoRoute(path: '/books', builder: (_, __) => const BookCatalogScreen()),
      GoRoute(path: '/books/:id', builder: (_, state) => BookDetailScreen(bookId: int.parse(state.pathParameters['id']!))),
      GoRoute(path: '/books/:id/reader', builder: (_, state) => BookReaderScreen(bookId: int.parse(state.pathParameters['id']!))),
      GoRoute(path: '/library', builder: (_, __) => const LibraryScreen()),
      GoRoute(path: '/orders', builder: (_, __) => const OrderHistoryScreen()),
      GoRoute(path: '/checkout', builder: (_, state) => CheckoutScreen(bookId: int.tryParse(state.uri.queryParameters['book'] ?? ''))),
      GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
      GoRoute(path: '/profile/edit', builder: (_, __) => const EditProfileScreen()),
      GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
      GoRoute(path: '/notification-preferences', builder: (_, __) => const NotificationPreferencesScreen()),
      GoRoute(path: '/app-lock', builder: (_, __) => const AppLockScreen()),
      GoRoute(path: '/cvs', builder: (_, __) => const CvListScreen()),
      GoRoute(path: '/cvs/new', builder: (_, __) => const CvEditScreen(cvId: null)),
      GoRoute(path: '/cvs/:id/edit', builder: (_, state) => CvEditScreen(cvId: int.parse(state.pathParameters['id']!))),
      GoRoute(path: '/cvs/:id/preview', builder: (_, state) => CvPreviewScreen(cvId: int.parse(state.pathParameters['id']!))),
      GoRoute(path: '/notifications', builder: (_, __) => const NotificationCenterScreen()),
      GoRoute(path: '/carrier-billing', builder: (_, __) => const CarrierBillingScreen()),
      GoRoute(path: '/subscription-status', builder: (_, __) => const SubscriptionStatusScreen()),
    ],
  );
}
