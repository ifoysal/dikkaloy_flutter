import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/providers/auth_providers.dart';
import 'package:livemcq3/features/profile/presentation/screens/notification_preferences_screen.dart';

final notificationPreferencesProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  return ref.read(authNotifierProvider.notifier).getNotificationPreferences();
});

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefsAsync = ref.watch(notificationPreferencesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationPreferencesScreen()),
            ),
          ),
        ],
      ),
      body: prefsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (prefs) {
          final enabledCount = prefs.values.where((v) => v == true).length;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.notifications_none, size: 80, color: Colors.grey.shade400),
                const SizedBox(height: 16),
                Text('No notifications yet', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey.shade600)),
                const SizedBox(height: 8),
                Text('$enabledCount notification types enabled', style: TextStyle(fontSize: 14, color: Colors.grey.shade500)),
              ],
            ),
          );
        },
      ),
    );
  }
}
