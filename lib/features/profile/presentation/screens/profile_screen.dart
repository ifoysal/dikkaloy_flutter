import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';
import 'package:livemcq3/features/auth/presentation/providers/auth_provider.dart';
import 'package:livemcq3/features/profile/presentation/widgets/settings_tile.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.profile)),
      body: ListView(
        children: [
          SettingsTile(title: l10n.editProfile, onTap: () => context.push('/profile/edit')),
          SettingsTile(title: l10n.settings, onTap: () => context.push('/settings')),
          SettingsTile(title: l10n.orders, onTap: () => context.push('/orders')),
          SettingsTile(title: l10n.notificationPreferences, onTap: () => context.push('/notification-preferences')),
          SettingsTile(title: l10n.deleteAccount, onTap: () {}),
          SettingsTile(title: l10n.logout, onTap: () => ref.read(authProvider.notifier).logout()),
        ],
      ),
    );
  }
}
