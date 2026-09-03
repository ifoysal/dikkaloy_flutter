import 'dart:developer';

class Logger {
  static void d(String message) {
    if (const bool.fromEnvironment('dart.vm.product') != true) {
      debugPrint('[DEBUG] $message');
    }
  }

  static void e(String message, [Object? error]) {
    debugPrint('[ERROR] $message${error != null ? ": $error" : ""}');
  }

  static void w(String message) {
    debugPrint('[WARN] $message');
  }
}
