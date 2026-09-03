import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';
import 'package:livemcq3/features/mcq/presentation/providers/mcq_provider.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final asyncWeakAreas = ref.watch(weakAreasProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.analytics)),
      body: asyncWeakAreas.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('${l10n.error}: $e')),
        data: (weakAreas) {
          if (weakAreas.isEmpty) return Center(child: Text(l10n.noData));
          return ListView.builder(
            itemCount: weakAreas.length,
            itemBuilder: (context, index) {
              final area = weakAreas[index];
              return ListTile(
                title: Text(area.topic),
                subtitle: LinearProgressIndicator(value: area.score / 100),
                trailing: Text('${area.score.toStringAsFixed(0)}%'),
              );
            },
          );
        },
      ),
    );
  }
}
