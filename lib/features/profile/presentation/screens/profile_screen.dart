import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';
import 'package:livemcq3/core/providers/auth_providers.dart' as dcb_auth;
import 'package:livemcq3/core/themes/app_theme.dart';
import 'package:livemcq3/features/auth/presentation/providers/auth_provider.dart';
import 'package:livemcq3/features/profile/presentation/widgets/settings_tile.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  Future<void> _confirmUnsubscribe(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('সাবস্ক্রিপশন বাতিল নিশ্চিতকরণ'),
        content: const Text(
          'আপনি কি নিশ্চিত যে আপনার রবি/এয়ারটেল দৈনিক ক্যারিয়ার বিলিং সাবস্ক্রিপশন বাতিল করতে চান? '
          'বাতিল করলে আপনি প্রিমিয়াম সুবিধার এক্সেস হারাবেন এবং লগ-আউট হয়ে যাবেন।\n\n'
          'বিকল্প ম্যানুয়াল পদ্ধতি:\n'
          '• ডায়াল প্যাড: *213*99# ডায়াল করুন\n'
          '• এসএমএস: STOP DIKKHALOY লিখে 21213 নম্বরে পাঠান',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('না, বাতিল করবেন না')),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('হ্যাঁ, বাতিল করুন', style: TextStyle(color: AppTheme.error)),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final message = await ref.read(dcb_auth.authNotifierProvider.notifier).unsubscribeCarrierBilling();
      if (!context.mounted) return;
      Navigator.of(context).pop(); // close loading dialog
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      context.go('/auth');
    } catch (e) {
      if (!context.mounted) return;
      Navigator.of(context).pop(); // close loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst('Exception: ', '')), backgroundColor: AppTheme.error),
      );
    }
  }

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
          SettingsTile(title: 'সাবস্ক্রিপশন বাতিল করুন', onTap: () => _confirmUnsubscribe(context, ref)),
          SettingsTile(title: l10n.deleteAccount, onTap: () {}),
          SettingsTile(title: l10n.logout, onTap: () => ref.read(authProvider.notifier).logout()),
        ],
      ),
    );
  }
}
