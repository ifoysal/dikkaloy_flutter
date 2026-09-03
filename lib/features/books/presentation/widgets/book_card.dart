import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';
import 'package:livemcq3/features/books/domain/entities/book.dart';

class BookCard extends StatelessWidget {
  final Book book;
  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: book.cover.isNotEmpty ? Image.network(book.cover, width: 50, height: 75, fit: BoxFit.cover) : null,
        title: Text(book.title),
        subtitle: Text(book.author),
        trailing: Text('\$${book.price.toStringAsFixed(2)}'),
        onTap: () => context.push('/books/${book.id}'),
      ),
    );
  }
}
