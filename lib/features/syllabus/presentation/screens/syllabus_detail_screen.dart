import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/features/syllabus/presentation/providers/syllabus_providers.dart';

class SyllabusDetailScreen extends ConsumerWidget {
  const SyllabusDetailScreen({super.key, required this.categoryId});

  final String categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(syllabusCategoryProvider(categoryId));

    return Scaffold(
      appBar: AppBar(title: const Text('Syllabus Detail')),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (detail) {
          final items = detail['items'] as List? ?? const [];
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(item['name']?.toString() ?? ''),
                  subtitle: item['description'] != null ? Text(item['description'].toString()) : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
