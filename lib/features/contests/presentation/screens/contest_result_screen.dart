import 'package:flutter/material.dart';

class ContestResultScreen extends StatelessWidget {
  final int contestId;

  const ContestResultScreen({super.key, required this.contestId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contest Result')),
      body: Center(child: Text('Contest Result $contestId')),
    );
  }
}
