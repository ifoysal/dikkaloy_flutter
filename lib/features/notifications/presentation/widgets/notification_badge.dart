import 'package:flutter/material.dart';
import 'package:livemcq3/core/themes/app_theme.dart';

class NotificationBadge extends StatelessWidget {
  final int count;
  final Widget child;
  final double? dotSize;

  const NotificationBadge({
    super.key,
    required this.count,
    required this.child,
    this.dotSize,
  });

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return child;

    return Badge(
      backgroundColor: AppTheme.error,
      textColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: child,
    );
  }
}
