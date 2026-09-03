import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'exam_timer_provider.g.dart';

@riverpod
class ExamTimer extends _$ExamTimer {
  @override
  int build(int seconds) => seconds;

  void tick() {
    if (state > 0) state = state - 1;
  }

  String get formatted {
    final m = state ~/ 60;
    final s = state % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}
