import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';

class ContestListScreen extends ConsumerWidget {
  const ContestListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    // In production, watch a contest list provider
    return Scaffold(
      appBar: AppBar(title: Text(l10n.contests)),
      body: const Center(child: Text('Contest list placeholder')),
    );
  }
}
