import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';

class CvPreviewScreen extends ConsumerWidget {
  final int cvId;
  const CvPreviewScreen({super.key, required this.cvId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.previewCv)),
      body: const Center(child: Text('CV preview placeholder')),
    );
  }
}
