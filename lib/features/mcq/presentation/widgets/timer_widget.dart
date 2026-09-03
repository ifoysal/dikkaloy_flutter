import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/features/mcq/presentation/providers/exam_timer_provider.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';

class TimerWidget extends ConsumerWidget {
  final int totalSeconds;
  final VoidCallback? onTimeUp;

  const TimerWidget({super.key, required this.totalSeconds, this.onTimeUp});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remainingSeconds = ref.watch(examTimerProvider(totalSeconds));
    final m = remainingSeconds ~/ 60;
    final s = remainingSeconds % 60;
    return Text('${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.error));
  }
}
