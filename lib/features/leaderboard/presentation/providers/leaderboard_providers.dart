import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/providers/app_providers.dart';

final leaderboardRepositoryProvider = Provider((ref) {
  return ref.watch(dioClientProvider);
});

final leaderboardProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final client = ref.watch(leaderboardRepositoryProvider);
  final response = await client.dio.get('/api/v1/leaderboard');
  final data = response.data['data'] as List;
  return data.cast<Map<String, dynamic>>();
});
