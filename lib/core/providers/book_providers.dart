import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/providers/app_providers.dart';
import 'package:livemcq3/data/models/book_models.dart';
import 'package:livemcq3/data/repositories/book_repository.dart';

final bookRepositoryProvider = Provider<BookRepository>((ref) {
  return BookRepository(ref.watch(dioClientProvider));
});

final booksProvider = FutureProvider<List<BookModel>>((ref) async {
  final repo = ref.watch(bookRepositoryProvider);
  return repo.getBooks();
});

final bookDetailProvider = FutureProvider.family<BookModel, int>((ref, bookId) async {
  final repo = ref.watch(bookRepositoryProvider);
  return repo.getBookDetail(bookId);
});

final bookDownloadUrlProvider = FutureProvider.family<String?, int>((ref, bookId) async {
  final repo = ref.watch(bookRepositoryProvider);
  return repo.getBookDownloadUrl(bookId);
});

final bookPreviewUrlProvider = FutureProvider.family<Map<String, dynamic>?, int>((ref, bookId) async {
  final repo = ref.watch(bookRepositoryProvider);
  return repo.getBookPreviewUrl(bookId);
});

final purchasesProvider = FutureProvider<List<PurchaseModel>>((ref) async {
  final repo = ref.watch(bookRepositoryProvider);
  return repo.getPurchases();
});

final ordersProvider = FutureProvider<List<OrderModel>>((ref) async {
  final repo = ref.watch(bookRepositoryProvider);
  return repo.getOrders();
});

final paymentStatusProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, transactionId) async {
  final repo = ref.watch(bookRepositoryProvider);
  return repo.getPaymentStatus(transactionId);
});
