import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:livemcq3/features/books/domain/usecases/purchase_book.dart';
part 'book_provider.g.dart';

final purchaseBookProvider = Provider<PurchaseBook>((ref) => PurchaseBook(ref.read(bookRepositoryProvider)));
final getLibraryProvider = Provider<GetLibrary>((ref) => GetLibrary(ref.read(bookRepositoryProvider)));
final getPreviewUrlProvider = Provider<GetPreviewUrl>((ref) => GetPreviewUrl(ref.read(bookRepositoryProvider)));
