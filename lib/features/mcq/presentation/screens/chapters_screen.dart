import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/providers/mcq_providers.dart';
import 'package:livemcq3/core/themes/app_theme.dart';

class ChaptersScreen extends ConsumerWidget {
  final int subjectId;

  const ChaptersScreen({super.key, required this.subjectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chaptersAsync = ref.watch(chaptersProvider(subjectId));

    return Scaffold(
      appBar: AppBar(title: const Text('Chapters')),
      body: chaptersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (chapters) {
          if (chapters.isEmpty) {
            return const Center(child: Text('No chapters available'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: chapters.length,
            itemBuilder: (context, index) {
              final chapter = chapters[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.segment, color: AppTheme.accent),
                  title: Text(chapter.name),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
              );
            },
          );
        },
      ),
    );
  }
}
