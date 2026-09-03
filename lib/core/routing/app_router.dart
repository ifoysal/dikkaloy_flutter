import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/providers/auth_providers.dart';
import 'package:livemcq3/features/auth/presentation/screens/splash_screen.dart';
import 'package:livemcq3/features/auth/presentation/screens/login_screen.dart';
import 'package:livemcq3/features/auth/presentation/screens/register_screen.dart';
import 'package:livemcq3/features/auth/presentation/screens/phone_login_screen.dart';
import 'package:livemcq3/features/auth/presentation/screens/otp_verify_screen.dart';
import 'package:livemcq3/features/auth/presentation/screens/profile_setup_screen.dart';
import 'package:livemcq3/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:livemcq3/features/dashboard/presentation/screens/home_screen.dart';
import 'package:livemcq3/features/mcq/presentation/screens/practice_screen.dart';
import 'package:livemcq3/features/mcq/presentation/screens/subjects_screen.dart';
import 'package:livemcq3/features/mcq/presentation/screens/chapters_screen.dart';
import 'package:livemcq3/features/mcq/presentation/screens/exam_screen.dart';
import 'package:livemcq3/features/mcq/presentation/screens/exam_result_screen.dart';
import 'package:livemcq3/features/mcq/presentation/screens/exam_history_screen.dart';
import 'package:livemcq3/features/mcq/presentation/screens/offline_practice_screen.dart';
import 'package:livemcq3/features/mcq/presentation/screens/quiz_payment_gate_screen.dart';
import 'package:livemcq3/features/mcq/presentation/screens/quiz_dcb_payment_screen.dart';
import 'package:livemcq3/features/jobs/presentation/screens/saved_jobs_screen.dart';
import 'package:livemcq3/features/jobs/presentation/screens/jobs_screen.dart';
import 'package:livemcq3/features/jobs/presentation/screens/job_detail_screen.dart';
import 'package:livemcq3/features/jobs/presentation/screens/job_alerts_screen.dart';
import 'package:livemcq3/features/jobs/presentation/screens/cv_builder_screen.dart';
import 'package:livemcq3/features/books/presentation/screens/books_screen.dart';
import 'package:livemcq3/features/books/presentation/screens/book_detail_screen.dart';
import 'package:livemcq3/features/books/presentation/screens/book_reader_screen.dart';
import 'package:livemcq3/features/books/presentation/screens/orders_screen.dart';
import 'package:livemcq3/features/contests/presentation/screens/contests_screen.dart';
import 'package:livemcq3/features/contests/presentation/screens/contest_arena_screen.dart';
import 'package:livemcq3/features/contests/presentation/screens/contest_result_screen.dart';
import 'package:livemcq3/features/profile/presentation/screens/profile_screen.dart';
import 'package:livemcq3/features/profile/presentation/screens/notification_preferences_screen.dart';
import 'package:livemcq3/features/profile/presentation/screens/settings_screen.dart';
import 'package:livemcq3/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:livemcq3/features/quiz/presentation/screens/daily_quiz_screen.dart';
import 'package:livemcq3/features/quiz/presentation/screens/quiz_result_screen.dart';
import 'package:livemcq3/features/syllabus/presentation/screens/syllabus_screen.dart';
import 'package:livemcq3/features/syllabus/presentation/screens/syllabus_detail_screen.dart';
import 'package:livemcq3/features/courses/presentation/screens/courses_screen.dart';
import 'package:livemcq3/features/courses/presentation/screens/course_detail_screen.dart';
import 'package:livemcq3/features/analytics/presentation/screens/analytics_screen.dart';
import 'package:livemcq3/features/applications/presentation/screens/applications_screen.dart';
import 'package:livemcq3/features/library/presentation/screens/library_screen.dart';
import 'package:livemcq3/features/leaderboard/presentation/screens/leaderboard_screen.dart';
import 'package:livemcq3/features/mcq/domain/repositories/mcq_repository.dart';
import 'package:livemcq3/features/mcq/domain/entities/weak_area.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final authStatusProvider = Provider<bool>((ref) {
  return ref.watch(authNotifierProvider).valueOrNull != null;
});

final _routerRefreshProvider = Provider<ValueNotifier<void>>((ref) {
  final notifier = ValueNotifier<void>(null);
  ref.listen<bool>(authStatusProvider, (_, __) => notifier.value = null);
  return notifier;
});

final appRouterProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = ref.watch(_routerRefreshProvider);
  final loggedIn = ref.watch(authStatusProvider);
  final authState = ref.watch(authNotifierProvider);
  return GoRouter(
    initialLocation: '/',
    navigatorKey: rootNavigatorKey,
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final isLoading = authState.isLoading && !loggedIn;
      if (isLoading) return null;

      final fullPath = state.fullPath ?? state.uri.toString();
      final loggingIn = fullPath == '/login' ||
          fullPath == '/register' ||
          fullPath == '/phone-login' ||
          fullPath == '/otp-verify' ||
          fullPath == '/profile-setup' ||
          fullPath == '/onboarding';

      final shouldProtect = fullPath.startsWith('/home');

      if (shouldProtect && !loggedIn) return '/login';
      if (loggedIn && loggingIn) return '/home';

      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/onboarding', builder: (context, state) => const OnboardingScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
      GoRoute(path: '/phone-login', builder: (context, state) => const PhoneLoginScreen()),
      GoRoute(
        path: '/otp-verify',
        builder: (context, state) {
          final phone = state.extra as String? ?? '';
          return OtpVerifyScreen(phone: phone);
        },
      ),
      GoRoute(path: '/profile-setup', builder: (context, state) => const ProfileSetupScreen()),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(path: 'practice', builder: (context, state) => const PracticeScreen()),
          GoRoute(path: 'subjects/:categoryId', builder: (context, state) => SubjectsScreen(categoryId: int.parse(state.pathParameters['categoryId']!))),
          GoRoute(path: 'chapters/:subjectId', builder: (context, state) => ChaptersScreen(subjectId: int.parse(state.pathParameters['subjectId']!))),
          GoRoute(path: 'exams/:categoryId', builder: (context, state) => ExamScreen(categoryId: int.parse(state.pathParameters['categoryId']!))),
          GoRoute(path: 'exam/result', builder: (context, state) {
            final data = state.extra as Map<String, dynamic>?;
            if (data == null) return const Scaffold(body: Center(child: Text('No result data')));
            final result = ExamResult(
              score: (data['score'] as num).toDouble(),
              total: data['total'] as int,
              correct: data['correct'] as int,
              weakAreas: (data['weak_areas'] as List?)?.map((e) => WeakArea.fromJson(e as Map<String, dynamic>)).toList() ?? const [],
            );
            return ExamResultScreen(result: result);
          }),
          GoRoute(path: 'exam-history', builder: (context, state) => const ExamHistoryScreen()),
          GoRoute(path: 'offline-practice', builder: (context, state) => const OfflinePracticeScreen()),
          GoRoute(path: 'jobs', builder: (context, state) => const JobsScreen()),
          GoRoute(path: 'jobs/saved', builder: (context, state) => const SavedJobsScreen()),
          GoRoute(path: 'jobs/:id', builder: (context, state) => JobDetailScreen(jobId: int.parse(state.pathParameters['id']!))),
          GoRoute(path: 'job-alerts', builder: (context, state) => const JobAlertsScreen()),
          GoRoute(path: 'cv-builder', builder: (context, state) => const CvBuilderScreen()),
          GoRoute(path: 'books', builder: (context, state) => const BooksScreen()),
          GoRoute(path: 'books/:id', builder: (context, state) => BookDetailScreen(bookId: int.parse(state.pathParameters['id']!))),
          GoRoute(path: 'books/:id/reader', builder: (context, state) => BookReaderScreen(bookId: int.parse(state.pathParameters['id']!))),
          GoRoute(path: 'orders', builder: (context, state) => const OrdersScreen()),
          GoRoute(path: 'contests', builder: (context, state) => const ContestsScreen()),
          GoRoute(path: 'contests/:id/arena', builder: (context, state) => ContestArenaScreen(contestId: int.parse(state.pathParameters['id']!))),
          GoRoute(path: 'contests/:id/result', builder: (context, state) => ContestResultScreen(contestId: int.parse(state.pathParameters['id']!))),
          GoRoute(path: 'profile', builder: (context, state) => const ProfileScreen()),
          GoRoute(path: 'notifications', builder: (context, state) => const NotificationsScreen()),
          GoRoute(path: 'notification-preferences', builder: (context, state) => const NotificationPreferencesScreen()),
          GoRoute(path: 'settings', builder: (context, state) => const SettingsScreen()),
          GoRoute(path: 'quiz', builder: (context, state) => const DailyQuizScreen()),
          GoRoute(path: 'quiz/:id/result', builder: (context, state) => QuizResultScreen(quizId: state.pathParameters['id']!)),
          GoRoute(path: 'syllabus', builder: (context, state) => const SyllabusScreen()),
          GoRoute(path: 'syllabus/:id', builder: (context, state) => SyllabusDetailScreen(categoryId: state.pathParameters['id']!)),
          GoRoute(path: 'courses', builder: (context, state) => const CoursesScreen()),
          GoRoute(path: 'courses/:id', builder: (context, state) => CourseDetailScreen(courseId: state.pathParameters['id']!)),
          GoRoute(path: 'analytics', builder: (context, state) => const AnalyticsScreen()),
          GoRoute(path: 'applications', builder: (context, state) => const ApplicationsScreen()),
          GoRoute(path: 'library', builder: (context, state) => const LibraryScreen()),
          GoRoute(path: 'leaderboard', builder: (context, state) => const LeaderboardScreen()),
          GoRoute(
            path: 'quiz/payment-gate/:categoryId',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>? ?? {};
              return QuizPaymentGateScreen(
                categoryId: state.pathParameters['categoryId']!,
                categoryName: extra['categoryName'] ?? 'Quiz',
                pricePoisha: extra['pricePoisha'] ?? 0,
              );
            },
          ),
          GoRoute(
            path: 'quiz/dcb-payment/:categoryId',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>? ?? {};
              return QuizDcbPaymentScreen(
                categoryId: state.pathParameters['categoryId']!,
                transactionId: extra['transactionId'] ?? '',
                phone: extra['phone'] ?? '',
                operator: extra['operator'] ?? '',
                categoryName: extra['categoryName'] ?? 'Quiz',
              );
            },
          ),
        ],
      ),
    ],
  );
});

final appRouter = appRouterProvider;

class RouterRefreshStream extends ChangeNotifier {
  void notify() => notifyListeners();
}
