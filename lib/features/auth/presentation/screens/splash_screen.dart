import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/providers/auth_providers.dart';
import 'package:livemcq3/core/themes/app_theme.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    // Wait briefly for the initial checkAuth() (fired from AuthNotifier's
    // constructor) to resolve so we don't flash the login screen for an
    // already-logged-in user.
    var authState = ref.read(authNotifierProvider);
    if (authState.isLoading) {
      final completer = Completer<void>();
      late final ProviderSubscription sub;
      sub = ref.listenManual(authNotifierProvider, (_, next) {
        if (!next.isLoading && !completer.isCompleted) completer.complete();
      });
      await completer.future.timeout(const Duration(seconds: 5), onTimeout: () {});
      sub.close();
      authState = ref.read(authNotifierProvider);
    }

    if (!mounted) return;
    context.go(authState.valueOrNull != null ? '/home' : '/auth');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school, size: 88, color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              'দিক্ষালয়',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 6),
            Text(
              'Dikkhaloy',
              style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.8), letterSpacing: 2),
            ),
            const SizedBox(height: 40),
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
