import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/features/courses/presentation/providers/course_providers.dart';

class CoursesScreen extends ConsumerWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesAsync = ref.watch(coursesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(coursesProvider),
        child: coursesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (courses) {
            if (courses.isEmpty) {
              return const Center(child: Text('No courses available'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(course['title']?.toString() ?? 'Course ${index + 1}'),
                    subtitle: Text(course['description']?.toString() ?? ''),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => context.push('/home/courses/${course['id']}'),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
