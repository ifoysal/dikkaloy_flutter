import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';

class JobDetailScreen extends StatelessWidget {
  final int jobId;
  const JobDetailScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('#$jobId')),
      body: Center(child: TextButton.icon(onPressed: () {}, icon: const Icon(Icons.work), label: Text(l10n.apply))),
    );
  }
}
