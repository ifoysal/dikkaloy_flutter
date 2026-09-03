import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/providers/app_providers.dart';

final syllabusRepositoryProvider = Provider((ref) {
  return ref.watch(dioClientProvider);
});

final syllabusProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final client = ref.watch(syllabusRepositoryProvider);
  final response = await client.dio.get('/api/v1/syllabus');
  final data = response.data['data'] as Map<String, dynamic>? ?? {};
  final items = data.entries.map((e) {
    final value = e.value as Map<String, dynamic>;
    return <String, dynamic>{
      'key': e.key,
      ...value,
    };
  }).toList();
  return items;
});

final syllabusCategoryProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, categoryId) async {
  final client = ref.watch(syllabusRepositoryProvider);
  final response = await client.dio.get('/api/v1/syllabus');
  final data = response.data['data'] as Map<String, dynamic>? ?? {};
  final category = data[categoryId] as Map<String, dynamic>?;
  if (category == null) {
    throw Exception('Syllabus category not found');
  }
  return <String, dynamic>{
    'key': categoryId,
    ...category,
  };
});
