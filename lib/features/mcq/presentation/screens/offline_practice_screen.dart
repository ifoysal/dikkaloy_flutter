import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/providers/mcq_providers.dart';
import 'package:livemcq3/core/themes/app_theme.dart';

class OfflinePracticeScreen extends ConsumerWidget {
  const OfflinePracticeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packs = ref.watch(offlinePracticePacksProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Offline Practice')),
      body: packs.isEmpty
          ? const Center(child: Text('No downloaded question sets'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: packs.length,
              itemBuilder: (context, index) {
                final pack = packs[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.download, color: AppTheme.primary),
                    title: Text('Category #${pack.examCategoryId}'),
                    subtitle: Text('${pack.questions.length} questions'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                );
              },
            ),
    );
  }
}
