import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/features/courses/presentation/providers/course_providers.dart';

class CourseDetailScreen extends ConsumerWidget {
  const CourseDetailScreen({super.key, required this.courseId});

  final String courseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(courseDetailProvider(courseId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Detail'),
      ),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (course) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(course['title']?.toString() ?? 'Course', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 16),
                Text(course['description']?.toString() ?? ''),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => context.push('/home/courses/$courseId/enroll'),
                  child: const Text('Enroll Now'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
