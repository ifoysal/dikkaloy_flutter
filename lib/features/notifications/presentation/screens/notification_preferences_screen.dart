import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/providers/auth_providers.dart';

class NotificationPreferencesScreen extends ConsumerWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefsAsync = ref.watch(authNotifierProvider.notifier).getNotificationPreferences();

    return Scaffold(
      appBar: AppBar(title: const Text('Notification Preferences')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: prefsAsync,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final prefs = snapshot.data ?? {};
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SwitchListTile(
                title: const Text('Enable Notifications'),
                value: prefs['enabled'] ?? true,
                onChanged: (val) {},
              ),
              SwitchListTile(
                title: const Text('Email Notifications'),
                value: prefs['email'] ?? true,
                onChanged: (val) {},
              ),
              SwitchListTile(
                title: const Text('Push Notifications'),
                value: prefs['push'] ?? true,
                onChanged: (val) {},
              ),
            ],
          );
        },
      ),
    );
  }
}
