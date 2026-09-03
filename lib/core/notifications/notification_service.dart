import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:go_router/go_router.dart';
import '../routing/app_router.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: DarwinInitializationSettings(),
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        final payload = response.payload;
        if (payload != null && payload.isNotEmpty) {
          _handleNotificationTap(payload);
        }
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showLocalNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final route = message.data['route']?.toString() ?? '';
      if (route.isNotEmpty) {
        _handleNotificationTap(route);
      }
    });

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      final route = initialMessage.data['route']?.toString() ?? '';
      if (route.isNotEmpty) {
        _handleNotificationTap(route);
      }
    }
  }

  static void _handleNotificationTap(String route) {
    if (route.isEmpty) return;
    final context = rootNavigatorKey.currentContext;
    if (context != null && context.mounted) {
      GoRouter.of(context).push(route);
    }
  }

  static Future<void> _showLocalNotification(
    RemoteMessage message,
  ) async {
    final notification = message.notification;
    if (notification == null) return;

    const androidDetail = AndroidNotificationDetails(
      'livemcq_channel',
      'LiveMCQ Notifications',
      channelDescription: 'Notifications from LiveMCQ',
      importance: Importance.max,
      priority: Priority.high,
    );
    const iosDetail = DarwinNotificationDetails();
    const notificationDetails = NotificationDetails(
      android: androidDetail,
      iOS: iosDetail,
    );

    await _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      notificationDetails,
      payload: message.data['route']?.toString(),
    );
  }

  static Future<String?> getFcmToken() async {
    return await FirebaseMessaging.instance.getToken();
  }
}
