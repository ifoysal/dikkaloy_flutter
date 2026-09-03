import 'package:equatable/equatable.dart';
import 'package:livemcq3/features/notifications/domain/entities/app_notification.dart';
import 'package:livemcq3/features/profile/domain/entities/profile.dart';

abstract class NotificationRepository {
  Future<List<AppNotification>> getNotifications();
  Future<void> markAsRead(int id);
  Future<NotificationPreferences> getPreferences();
  Future<NotificationPreferences> updatePreferences(NotificationPreferences preferences);
}
