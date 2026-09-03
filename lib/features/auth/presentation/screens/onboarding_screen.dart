import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school, size: 120, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 32),
            Text(l10n.appName, style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 16),
            Text('Your coaching & career companion', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () => context.go('/login'),
              child: Text(l10n.login),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => context.go('/register'),
              child: Text(l10n.register),
            ),
          ],
        ),
      ),
    );
  }
}
