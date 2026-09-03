import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/providers/app_providers.dart';

final analyticsRepositoryProvider = Provider((ref) {
  return ref.watch(dioClientProvider);
});

final analyticsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final client = ref.watch(analyticsRepositoryProvider);
  final response = await client.dio.get('/api/v1/analytics');
  final data = response.data['data'] as Map<String, dynamic>;
  return data;
});
