import 'package:dio/dio.dart';
import 'package:livemcq3/core/constants/api_constants.dart';
import 'package:livemcq3/features/notifications/domain/entities/app_notification.dart';
import 'package:livemcq3/features/profile/domain/entities/profile.dart';
import 'package:livemcq3/features/notifications/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final Dio dio;
  NotificationRepositoryImpl(this.dio);

  @override
  Future<List<AppNotification>> getNotifications() async {
    final response = await dio.get(ApiConstants.notificationsPreferences());
    final list = response.data['data'] as List<dynamic>? ?? [];
    return list.whereType<Map<String, dynamic>>().map((n) => AppNotification(
          id: n['id'] as int,
          title: n['title'] as String,
          body: n['body'] as String,
          type: n['type'] as String,
          data: n['data'] != null ? Map<String, dynamic>.from(n['data'] as Map) : null,
          read: n['read_at'] != null,
          createdAt: n['created_at'] as String,
        )).toList();
  }

  @override
  Future<void> markAsRead(int id) async {
    await dio.put('/api/v1/notifications/$id/read');
  }

  @override
  Future<NotificationPreferences> getPreferences() async {
    final response = await dio.get(ApiConstants.notificationsPreferences());
    final data = response.data['data'] as Map<String, dynamic>;
    return NotificationPreferences(
      pushEnabled: data['push'] as bool? ?? true,
      emailEnabled: data['email'] as bool? ?? true,
      smsEnabled: data['sms'] as bool? ?? false,
    );
  }

  @override
  Future<NotificationPreferences> updatePreferences(NotificationPreferences preferences) async {
    final response = await dio.put(ApiConstants.notificationsPreferences(), data: {
      'push': preferences.pushEnabled,
      'email': preferences.emailEnabled,
      'sms': preferences.smsEnabled,
    });
    final data = response.data['data'] as Map<String, dynamic>;
    return NotificationPreferences(
      pushEnabled: data['push'] as bool,
      emailEnabled: data['email'] as bool,
      smsEnabled: data['sms'] as bool,
    );
  }
}
