import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/providers/app_providers.dart';

final applicationRepositoryProvider = Provider((ref) {
  return ref.watch(dioClientProvider);
});

final applicationsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final client = ref.watch(applicationRepositoryProvider);
  final response = await client.dio.get('/api/v1/applications');
  final data = response.data['data'] as List;
  return data.cast<Map<String, dynamic>>();
});
