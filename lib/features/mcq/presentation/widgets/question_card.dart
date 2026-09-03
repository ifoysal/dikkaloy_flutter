import 'package:flutter/material.dart';
import 'package:livemcq3/features/mcq/domain/entities/question.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final int? selectedOptionId;
  final ValueChanged<int?> onOptionSelected;

  const QuestionCard({
    super.key,
    required this.question,
    this.selectedOptionId,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question.text, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            ...question.options.map((option) {
              final isSelected = selectedOptionId == option.id;
              return RadioListTile<int>(
                value: option.id,
                groupValue: selectedOptionId,
                onChanged: (v) => onOptionSelected(v),
                title: Text(option.text),
                selected: isSelected,
              );
            }),
          ],
        ),
      ),
    );
  }
}
