class ServerException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ServerException({required this.message, this.statusCode, this.data});

  @override
  String toString() => 'ServerException: $message (status: $statusCode)';
}

class CacheException implements Exception {
  final String message;
  CacheException([this.message = 'Cache operation failed']);

  @override
  String toString() => 'CacheException: $message';
}

class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = 'Network error']);

  @override
  String toString() => 'NetworkException: $message';
}

class AuthException implements Exception {
  final String message;
  AuthException([this.message = 'Authentication failed']);

  @override
  String toString() => 'AuthException: $message';
}

class ValidationException implements Exception {
  final Map<String, dynamic> errors;
  ValidationException(this.errors);

  @override
  String toString() => 'ValidationException: $errors';
}

class PaymentException implements Exception {
  final String message;
  PaymentException([this.message = 'Payment failed']);

  @override
  String toString() => 'PaymentException: $message';
}
