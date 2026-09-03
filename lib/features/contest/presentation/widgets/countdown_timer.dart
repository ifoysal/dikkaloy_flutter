import 'package:flutter/material.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';

class CountdownTimer extends StatelessWidget {
  final int seconds;
  const CountdownTimer({super.key, required this.seconds});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return Text('${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}', style: Theme.of(context).textTheme.headlineMedium);
  }
}
