import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/features/home/domain/entities/dashboard_stats.dart';
import 'package:livemcq3/features/home/data/models/recent_job.dart';

class JobCard extends StatelessWidget {
  final RecentJob job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(job.title),
        subtitle: Text('${job.company} • ${job.location}'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => context.push('/jobs/${job.id}'),
      ),
    );
  }
}
