import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';

class CvEditScreen extends ConsumerStatefulWidget {
  final int? cvId;
  const CvEditScreen({super.key, this.cvId});

  @override
  ConsumerState<CvEditScreen> createState() => _CvEditScreenState();
}

class _CvEditScreenState extends ConsumerState<CvEditScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.cvId == null ? l10n.createCv : l10n.editCv)),
      body: const Center(child: Text('CV editor placeholder')),
    );
  }
}
