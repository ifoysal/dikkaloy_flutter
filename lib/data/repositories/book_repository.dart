import 'package:livemcq3/core/constants/endpoints.dart';
import 'package:livemcq3/core/network/dio_client.dart';
import 'package:livemcq3/data/models/book_models.dart';

class BookRepository {
  final DioClient dioClient;

  BookRepository(this.dioClient);

  Future<List<BookModel>> getBooks() async {
    final response = await dioClient.dio.get(ApiEndpoints.books);
    final data = response.data['data'] as List;
    return data.map((e) => BookModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<BookModel> getBookDetail(int id) async {
    final response = await dioClient.dio.get(ApiEndpoints.bookDetail(id));
    final data = response.data['data'] as Map<String, dynamic>;
    return BookModel.fromJson(data);
  }

  Future<String?> getBookDownloadUrl(int id) async {
    final response = await dioClient.dio.get(ApiEndpoints.bookDownload(id));
    final data = response.data['data'] as Map<String, dynamic>?;
    return data?['url'] as String?;
  }

  Future<Map<String, dynamic>?> getBookPreviewUrl(int id) async {
    final response = await dioClient.dio.get(ApiEndpoints.bookPreview(id));
    if (response.data['success'] == false) return null;
    return response.data['data'] as Map<String, dynamic>?;
  }

  Future<List<PurchaseModel>> getPurchases() async {
    final response = await dioClient.dio.get(ApiEndpoints.orders);
    final data = response.data['data'] as List;
    return data.map((e) => PurchaseModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<OrderModel>> getOrders() async {
    final response = await dioClient.dio.get(ApiEndpoints.orders);
    final data = response.data['data'] as List;
    return data.map((e) => OrderModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<String> initiatePayment(int bookId, int amount, {String payableType = 'book', int? payableId, String? customerPhone, String? customerEmail}) async {
    final response = await dioClient.dio.post(
      ApiEndpoints.paymentsInitiate,
      data: {
        'gateway': 'bkash',
        'amount': amount,
        'payable_type': payableType,
        'payable_id': payableId ?? bookId,
        if (customerPhone != null) 'customer_phone': customerPhone,
        if (customerEmail != null) 'customer_email': customerEmail,
      },
    );
    final data = response.data['data'] as Map<String, dynamic>;
    return data['redirect_url'] as String? ?? data['payment_url'] as String? ?? '';
  }

  Future<bool> verifyPayment(String transactionId) async {
    final response = await dioClient.dio.post(
      ApiEndpoints.paymentsVerify,
      data: {'transaction_id': transactionId},
    );
    return response.data['success'] == true;
  }

  Future<Map<String, dynamic>> getPaymentStatus(String transactionId) async {
    final response = await dioClient.dio.get(ApiEndpoints.paymentStatus(transactionId));
    return response.data['data'] as Map<String, dynamic>;
  }
}
