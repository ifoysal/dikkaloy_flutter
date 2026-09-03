import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/providers/app_providers.dart';

final leaderboardProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final client = ref.watch(dioClientProvider);
  final response = await client.dio.get('/api/v1/leaderboard');
  final data = response.data['data'] as List;
  return data.cast<Map<String, dynamic>>();
});

class LeaderboardScreen extends ConsumerWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderboardAsync = ref.watch(leaderboardProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboard')),
      body: leaderboardAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (entries) {
          if (entries.isEmpty) {
            return const Center(child: Text('No leaderboard entries yet'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: index < 3 ? Colors.amber : Colors.grey.shade200,
                  child: Text('${index + 1}'),
                ),
                title: Text(entry['name']?.toString() ?? 'Anonymous'),
                trailing: Text('${entry['score']} pts'),
              );
            },
          );
        },
      ),
    );
  }
}
