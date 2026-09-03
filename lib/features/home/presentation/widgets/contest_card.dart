import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/features/home/domain/entities/dashboard_stats.dart';
import 'package:livemcq3/features/home/data/models/upcoming_contest.dart';

class ContestCard extends StatelessWidget {
  final UpcomingContest contest;

  const ContestCard({super.key, required this.contest});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(contest.title),
        subtitle: Text('Starts: ${contest.startAt} • ${contest.participantsCount} participants'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => context.push('/contests/${contest.id}'),
      ),
    );
  }
}
