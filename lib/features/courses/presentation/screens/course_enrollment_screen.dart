import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/features/courses/presentation/providers/course_providers.dart';

class CourseEnrollmentScreen extends ConsumerWidget {
  const CourseEnrollmentScreen({super.key, required this.courseId});

  final String courseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enrollmentAsync = ref.watch(enrollmentProvider(courseId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enrollment'),
      ),
      body: enrollmentAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (enrollment) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(enrollment['enrolled'] == true ? 'Already Enrolled' : 'Enroll in this course?'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enrollment flow placeholder')),
                    );
                  },
                  child: const Text('Confirm Enrollment'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
