import 'dart:io';

class SimpleNetworkConnectionChecker {
  Future<bool> get isConnected async {
    try {
      const lookupAddress = "www.google.com";
      final results = await InternetAddress.lookup(lookupAddress);
      if (results.isNotEmpty && results[0].rawAddress.isNotEmpty) return true;
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }
}
