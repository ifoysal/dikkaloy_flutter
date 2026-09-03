import 'package:flutter/material.dart';

class ExamResultScreen extends StatelessWidget {
  final dynamic result;

  const ExamResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Result')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Score: ${(result is double ? result : 0.0).toStringAsFixed(1)}%', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            Text('Result recorded'),
          ],
        ),
      ),
    );
  }
}
