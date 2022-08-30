import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tddpractice/core/infrastructure/network_info.dart';

import 'mock_network_checker.dart';

void main() {
  late final MockNetworkChecker checker;
  late final NetworkInfo networkInfo;

  setUp(
    () {
      checker = MockNetworkChecker();
      networkInfo = NetworkInfo(checker: checker);
    },
  );

  group(
    "isConnected",
    () {
      test(
        "should forward the call to SimpleDataConnectionChecker.isConnected",
        () async {
          when(() => checker.isConnected).thenAnswer((_) async => true);

          networkInfo.isOnline;

          verify(() => checker.isConnected);
        },
      );
    },
  );
}
