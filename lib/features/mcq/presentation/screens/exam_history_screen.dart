import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/providers/mcq_providers.dart';

class ExamHistoryScreen extends ConsumerWidget {
  const ExamHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(examHistoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Exam History')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(examHistoryProvider),
        child: historyAsync.when(
          loading: () => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: const [Center(child: CircularProgressIndicator())],
          ),
          error: (e, _) => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [Center(child: Text('Error: $e'))],
          ),
          data: (sessions) {
            if (sessions.isEmpty) {
              return const Center(child: Text('No exam history yet'));
            }
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];
                return Card(
                  child: ListTile(
                    title: Text('Score: ${session.score.toStringAsFixed(1)}%'),
                    subtitle: Text('Correct: ${session.correctAnswers}/${session.totalQuestions} • Type: ${session.type ?? 'MCQ'}'),
                    trailing: const Icon(Icons.arrow_forward_ios),
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
