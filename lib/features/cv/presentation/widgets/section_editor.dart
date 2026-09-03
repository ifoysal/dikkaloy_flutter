import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';

class SectionEditor extends StatelessWidget {
  final String section;
  final Map<String, dynamic> data;
  final ValueChanged<Map<String, dynamic>>? onChanged;

  const SectionEditor({super.key, required this.section, required this.data, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(section.toUpperCase(), style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: data['value']?.toString() ?? '',
              decoration: const InputDecoration(border: OutlineInputBorder()),
              onChanged: (v) => onChanged?.call({...data, 'value': v}),
            ),
          ],
        ),
      ),
    );
  }
}
