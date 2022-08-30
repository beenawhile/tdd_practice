import 'package:tddpractice/core/infrastructure/i_network_info.dart';
import 'package:tddpractice/core/infrastructure/simple_network_connection_checker.dart';

class NetworkInfo implements INetworkInfo {
  const NetworkInfo({
    required SimpleNetworkConnectionChecker checker,
  }) : _checker = checker;

  final SimpleNetworkConnectionChecker _checker;

  @override
  Future<bool> get isOnline => _checker.isConnected;
}
