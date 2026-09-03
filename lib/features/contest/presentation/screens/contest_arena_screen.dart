import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';

class ContestArenaScreen extends ConsumerWidget {
  final int contestId;
  const ContestArenaScreen({super.key, required this.contestId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.arena)),
      body: const Center(child: Text('Live contest arena placeholder')),
    );
  }
}
