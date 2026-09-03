import 'package:flutter/material.dart';
import 'package:livemcq3/features/notifications/domain/entities/app_notification.dart';

class NotificationTile extends StatelessWidget {
  final AppNotification notification;

  const NotificationTile({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(notification.title),
      subtitle: Text(notification.body),
      trailing: Icon(notification.read ? Icons.check_circle : Icons.circle),
    );
  }
}
