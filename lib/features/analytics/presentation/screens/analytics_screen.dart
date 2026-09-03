import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/features/analytics/presentation/providers/analytics_providers.dart';
import 'package:livemcq3/core/themes/app_theme.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsAsync = ref.watch(analyticsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Performance Analytics'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(analyticsProvider),
        child: analyticsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (data) {
            final weakAreas = (data['weak_areas'] as List<dynamic>? ?? []);
            final avgScore = (data['average_score'] as num? ?? 0).toDouble();
            final totalExams = (data['total_exams'] as int? ?? 0);
            final recentExams = (data['recent_exams'] as List<dynamic>? ?? []);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          'Total Exams',
                          totalExams.toString(),
                          Icons.assignment_turned_in,
                          Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildMetricCard(
                          'Avg. Score',
                          '${avgScore.toStringAsFixed(1)}%',
                          Icons.trending_up,
                          Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          'Accuracy Rate',
                          '${(avgScore * 0.95).toStringAsFixed(1)}%',
                          Icons.speed,
                          Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildMetricCard(
                          'Leaderboard Pts',
                          '${(totalExams * 50)}',
                          Icons.emoji_events,
                          Colors.purple,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.warning_amber_rounded, color: Colors.amber),
                              SizedBox(width: 8),
                              Text(
                                'Topic-Wise Weak Areas',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (weakAreas.isEmpty)
                            const Text('No weak areas identified yet.')
                          else
                            ...weakAreas.map((item) {
                              final topic = item['topic']?.toString() ?? 'Unknown';
                              final score = (item['score'] as num? ?? 0).toDouble();
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: _buildWeakTopicBar(topic, score, Colors.red),
                              );
                            }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Recent Exam Sessions',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  if (recentExams.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Text('No exams taken yet. Start with a Daily Quiz!'),
                      ),
                    )
                  else
                    ...recentExams.map((item) {
                      final score = item['score']?.toString() ?? '0';
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppTheme.primary.withValues(alpha: 0.1),
                            child: const Icon(Icons.quiz, color: AppTheme.primary),
                          ),
                          title: Text(item['exam']?.toString() ?? 'MCQ Model Test'),
                          subtitle: Text('Score: $score% | Status: Completed'),
                          trailing: const Icon(Icons.check_circle, color: Colors.green),
                        ),
                      );
                    }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildWeakTopicBar(String topic, double progress, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(topic, style: const TextStyle(fontSize: 13)),
            Text('${(progress * 100).toInt()}%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey.shade200,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ],
    );
  }
}
