import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:livemcq3/features/notifications/domain/entities/app_notification.dart';
import 'package:livemcq3/features/notifications/domain/repositories/notification_repository.dart';
part 'notification_provider.g.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  throw UnimplementedError('Override in app scope');
});

@riverpod
Future<List<AppNotification>> notifications(NotificationsRef ref) {
  return ref.read(notificationRepositoryProvider).getNotifications();
}
