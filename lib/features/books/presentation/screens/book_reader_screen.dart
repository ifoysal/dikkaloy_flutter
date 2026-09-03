import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';
import 'package:livemcq3/core/providers/app_providers.dart';

class BookReaderScreen extends ConsumerStatefulWidget {
  final int bookId;
  const BookReaderScreen({super.key, required this.bookId});

  @override
  ConsumerState<BookReaderScreen> createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends ConsumerState<BookReaderScreen> {
  String? _url;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadSignedUrl();
  }

  Future<void> _loadSignedUrl() async {
    try {
      final url = await ref.read(bookRepositoryProvider).getDownloadUrl(widget.bookId);
      if (mounted) {
        setState(() => _url = url);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _error = e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: Text('${l10n.reader} #${widget.bookId}')),
        body: Center(child: Text('${l10n.error}: $_error')),
      );
    }
    if (_url == null) {
      return Scaffold(
        appBar: AppBar(title: Text('${l10n.reader} #${widget.bookId}')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text('${l10n.reader} #${widget.bookId}')),
      body: SfPdfViewer.network(_url!),
    );
  }
}
