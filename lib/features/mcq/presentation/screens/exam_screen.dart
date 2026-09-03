import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';
import 'package:livemcq3/features/mcq/domain/entities/answer.dart';
import 'package:livemcq3/features/mcq/domain/repositories/mcq_repository.dart';
import 'package:livemcq3/features/mcq/presentation/providers/exam_timer_provider.dart';
import 'package:livemcq3/features/mcq/presentation/providers/mcq_provider.dart';
import 'package:livemcq3/features/mcq/presentation/widgets/question_card.dart';
import 'package:livemcq3/features/mcq/presentation/widgets/exam_result_screen.dart';

class ExamScreen extends ConsumerStatefulWidget {
  final int categoryId;
  const ExamScreen({super.key, required this.categoryId});

  @override
  ConsumerState<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends ConsumerState<ExamScreen> {
  int _currentIndex = 0;
  final Map<int, int?> _answers = {};
  ExamResult? _result;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final asyncQuestions = ref.watch(questionsProvider(widget.categoryId));
    final remainingSeconds = ref.watch(examTimerProvider(300));

    if (_result != null) {
      return ExamResultScreen(result: _result!);
    }

    return asyncQuestions.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('${l10n.error}: $e'))),
      data: (questions) {
        if (questions.isEmpty) return Scaffold(body: Center(child: Text(l10n.noData)));
        final question = questions[_currentIndex];
        final formatted = '${(remainingSeconds ~/ 60).toString().padLeft(2, '0')}:${(remainingSeconds % 60).toString().padLeft(2, '0')}';

        return PopScope(
          canPop: false,
          child: Scaffold(
            appBar: AppBar(
              title: Text(l10n.timeLeft),
              actions: [
                Center(child: Text(formatted, style: const TextStyle(fontWeight: FontWeight.bold))),
                IconButton(onPressed: _finish, icon: const Icon(Icons.check_circle)),
              ],
            ),
            body: Column(
              children: [
                LinearProgressIndicator(value: (_currentIndex + 1) / questions.length),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: QuestionCard(
                      question: question,
                      selectedOptionId: _answers[question.id],
                      onOptionSelected: (optionId) => setState(() => _answers[question.id] = optionId),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      if (_currentIndex > 0)
                        ElevatedButton(onPressed: () => setState(() => _currentIndex--), child: Text(l10n.previous)),
                      const Spacer(),
                      if (_currentIndex < questions.length - 1)
                        ElevatedButton(onPressed: () => setState(() => _currentIndex++), child: Text(l10n.next)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _finish() async {
    try {
      final l10n = AppLocalizations.of(context);
      final answers = _answers.entries.where((e) => e.value != null).map((e) => Answer(questionId: e.key, selectedOptionId: e.value!)).toList();
      final result = await ref.read(submitExamProvider)(widget.categoryId, answers);
      if (mounted) {
        setState(() => _result = result);
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${l10n.error}: $e')));
      }
    }
  }
}
