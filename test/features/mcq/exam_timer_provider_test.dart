import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/features/mcq/presentation/providers/exam_timer_provider.dart';

void main() {
  group('ExamTimerProvider', () {
    test('initializes with provided seconds', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final timer = container.read(examTimerProvider(120));
      expect(timer, 120);
    });

    test('tick decrements timer', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      container.read(examTimerProvider.notifier).tick();
      expect(container.read(examTimerProvider(120)), 119);
    });
  });
}
