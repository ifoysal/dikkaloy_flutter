import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';
import 'package:livemcq3/features/mcq/presentation/providers/mcq_provider.dart';
import 'package:livemcq3/features/mcq/domain/entities/question.dart';
import 'package:livemcq3/features/mcq/presentation/widgets/question_card.dart';

class PracticeScreen extends ConsumerStatefulWidget {
  final int categoryId;
  const PracticeScreen({super.key, required this.categoryId});

  @override
  ConsumerState<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends ConsumerState<PracticeScreen> {
  int _currentIndex = 0;
  final Map<int, int?> _answers = {};

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final asyncQuestions = ref.watch(questionsProvider(widget.categoryId));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.categories)),
      body: asyncQuestions.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('${l10n.error}: $e')),
        data: (questions) {
          if (questions.isEmpty) return Center(child: Text(l10n.noData));
          final question = questions[_currentIndex];
          return Column(
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
          );
        },
      ),
    );
  }
}
