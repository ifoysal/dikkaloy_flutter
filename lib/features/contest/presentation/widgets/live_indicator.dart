import 'package:flutter/material.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';

class LiveIndicator extends StatelessWidget {
  final bool isLive;
  const LiveIndicator({super.key, required this.isLive});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        if (isLive) ...[
          const Icon(Icons.circle, color: Colors.red, size: 12),
          const SizedBox(width: 4),
          Text('LIVE', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.red)),
        ] else
          Text(l10n.waitingRoom, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
