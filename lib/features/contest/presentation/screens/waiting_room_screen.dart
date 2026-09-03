import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';

class WaitingRoomScreen extends ConsumerWidget {
  final int contestId;
  const WaitingRoomScreen({super.key, required this.contestId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.waitingRoom)),
      body: Center(child: Text('Waiting for contest #$contestId to start...')),
    );
  }
}
