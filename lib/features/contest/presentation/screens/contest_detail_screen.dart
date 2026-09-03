import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';

class ContestDetailScreen extends StatelessWidget {
  final int contestId;
  const ContestDetailScreen({super.key, required this.contestId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('#$contestId')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: () => context.push('/contests/$contestId/arena'), child: Text(l10n.arena)),
            ElevatedButton(onPressed: () => context.push('/contests/$contestId/result'), child: Text(l10n.result)),
          ],
        ),
      ),
    );
  }
}
