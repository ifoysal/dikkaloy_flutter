import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';
import 'package:livemcq3/features/jobs/domain/entities/job.dart';

class JobCard extends StatelessWidget {
  final Job job;
  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(job.title),
        subtitle: Text('${job.company} • ${job.location}'),
        trailing: Icon(job.saved ? Icons.bookmark : Icons.bookmark_border),
        onTap: () => context.push('/jobs/${job.id}'),
      ),
    );
  }
}
