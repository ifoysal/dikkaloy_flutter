import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static Future<bool> get isConnected async {
    final result = await Connectivity().checkConnectivity();
    return result.any((c) => c != ConnectivityResult.none);
  }

  static Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      Connectivity().onConnectivityChanged.map((results) => results is List<ConnectivityResult> ? results : [results as ConnectivityResult]);
}
