import 'package:flutter/material.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';

class AppFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;

  const AppFilterChip({super.key, required this.label, this.selected = false, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
    );
  }
}
