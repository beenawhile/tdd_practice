import 'package:flutter_test/flutter_test.dart';
import 'package:tddpractice/core/infrastructure/simple_network_connection_checker.dart';

void main() {
  final checker = SimpleNetworkConnectionChecker();

  group(
    "SimpleNetworkConnectionChecker",
    () {
      test(
        "should return bool value",
        () async {
          final results = await checker.isConnected;
          expect(results, isA<bool>());
        },
      );

      test(
        "should return true if the device is connected to internet",
        () async {
          final results = await checker.isConnected;
          expect(results, true);
        },
      );
    },
  );
}
