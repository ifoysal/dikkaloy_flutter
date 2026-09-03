import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';

class CvListScreen extends ConsumerWidget {
  const CvListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.cvBuilder)),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.push('/cvs/new'),
          child: Text(l10n.createCv),
        ),
      ),
    );
  }
}
