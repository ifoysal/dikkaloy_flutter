import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/providers/app_providers.dart';

final courseRepositoryProvider = Provider((ref) {
  return ref.watch(dioClientProvider);
});

final coursesProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final client = ref.watch(courseRepositoryProvider);
  final response = await client.dio.get('/api/v1/courses');
  final data = response.data['data'] as List;
  return data.cast<Map<String, dynamic>>();
});

final courseDetailProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, courseId) async {
  final client = ref.watch(courseRepositoryProvider);
  final response = await client.dio.get('/api/v1/courses/$courseId');
  final data = response.data['data'] as Map<String, dynamic>;
  return data;
});

final enrollmentProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, courseId) async {
  return {'enrolled': false};
});
