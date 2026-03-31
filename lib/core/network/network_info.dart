import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_info.g.dart';

abstract interface class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;
  final InternetConnection internetConnection;

  NetworkInfoImpl(this.connectivity, this.internetConnection);

  @override
  Future<bool> get isConnected async {
    final connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }
    return await internetConnection.hasInternetAccess;
  }
}

@riverpod
Connectivity connectivity(Ref ref) => Connectivity();

@riverpod
InternetConnection internetConnection(Ref ref) => InternetConnection();

@riverpod
NetworkInfo networkInfo(Ref ref) {
  final connectivity = ref.watch(connectivityProvider);
  final internetConnection = ref.watch(internetConnectionProvider);
  return NetworkInfoImpl(connectivity, internetConnection);
}
