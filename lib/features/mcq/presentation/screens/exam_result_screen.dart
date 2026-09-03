import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';
import 'package:livemcq3/features/mcq/domain/repositories/mcq_repository.dart';

class ExamResultScreen extends ConsumerWidget {
  final ExamResult result;

  const ExamResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.result)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${l10n.score}: ${result.correct}/${result.total}', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 24),
            Text(l10n.weakAreas, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            ...result.weakAreas.map((w) => ListTile(title: Text(w.topic), trailing: Text('${w.score.toStringAsFixed(0)}%'))),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () => context.go('/home'), child: Text(l10n.home)),
          ],
        ),
      ),
    );
  }
}
