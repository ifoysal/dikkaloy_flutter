import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';

class BookDetailScreen extends StatelessWidget {
  final int bookId;
  const BookDetailScreen({super.key, required this.bookId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('#$bookId')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: () => context.push('/books/$bookId/reader'), child: Text('Read')),
            ElevatedButton(onPressed: () => context.push('/checkout?book=$bookId'), child: Text(l10n.checkout)),
          ],
        ),
      ),
    );
  }
}
