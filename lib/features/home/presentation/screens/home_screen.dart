import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';
import 'package:livemcq3/features/home/presentation/providers/home_provider.dart';
import 'package:livemcq3/features/home/domain/entities/dashboard_stats.dart';
import 'package:livemcq3/features/contest/domain/entities/contest.dart';
import 'package:livemcq3/features/jobs/domain/entities/job.dart';
import 'package:livemcq3/features/home/presentation/widgets/home_widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final asyncData = ref.watch(homeProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.home)),
      body: asyncData.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('${l10n.error}: $e')),
        data: (data) {
          final stats = data['stats'] as DashboardStats;
          final contests = data['contests'] as List<dynamic>;
          final jobs = data['jobs'] as List<dynamic>;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  Expanded(child: StatsCard(title: 'Exams', value: '${stats.examsCompleted}')),
                  const SizedBox(width: 12),
                  Expanded(child: StatsCard(title: 'Avg Score', value: '${stats.averageScore.toStringAsFixed(1)}%')),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: StatsCard(title: 'Saved Jobs', value: '${stats.savedJobsCount}')),
                  const SizedBox(width: 12),
                  Expanded(child: StatsCard(title: 'Books', value: '${stats.purchasedBooksCount}')),
                ],
              ),
              const SizedBox(height: 24),
              Text(l10n.contests, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 12),
              ...contests.map((c) => ContestCard(contest: c)),
              const SizedBox(height: 24),
              Text(l10n.jobs, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 12),
              ...jobs.map((j) => JobCard(job: j)),
            ],
          );
        },
      ),
    );
  }
}
