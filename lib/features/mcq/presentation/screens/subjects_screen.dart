import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/providers/mcq_providers.dart';
import 'package:livemcq3/core/themes/app_theme.dart';

class SubjectsScreen extends ConsumerWidget {
  final int categoryId;

  const SubjectsScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectsAsync = ref.watch(subjectsProvider(categoryId));

    return Scaffold(
      appBar: AppBar(title: const Text('Subjects')),
      body: subjectsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (subjects) {
          if (subjects.isEmpty) {
            return const Center(child: Text('No subjects available'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              final subject = subjects[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.book, color: AppTheme.secondary),
                  title: Text(subject.name),
                  subtitle: subject.questionsCount != null
                      ? Text('${subject.questionsCount} questions')
                      : null,
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => context.push('/home/chapters/${subject.id}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
