// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_info.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(connectivity)
final connectivityProvider = ConnectivityProvider._();

final class ConnectivityProvider
    extends $FunctionalProvider<Connectivity, Connectivity, Connectivity>
    with $Provider<Connectivity> {
  ConnectivityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'connectivityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$connectivityHash();

  @$internal
  @override
  $ProviderElement<Connectivity> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Connectivity create(Ref ref) {
    return connectivity(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Connectivity value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Connectivity>(value),
    );
  }
}

String _$connectivityHash() => r'dbbaa751fbd9afcb3ec3c33a3b00257f5fe5682c';

@ProviderFor(internetConnection)
final internetConnectionProvider = InternetConnectionProvider._();

final class InternetConnectionProvider
    extends
        $FunctionalProvider<
          InternetConnection,
          InternetConnection,
          InternetConnection
        >
    with $Provider<InternetConnection> {
  InternetConnectionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'internetConnectionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$internetConnectionHash();

  @$internal
  @override
  $ProviderElement<InternetConnection> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  InternetConnection create(Ref ref) {
    return internetConnection(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InternetConnection value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InternetConnection>(value),
    );
  }
}

String _$internetConnectionHash() =>
    r'62cb6a0092f46dc7fd4593630fd106a896610412';

@ProviderFor(networkInfo)
final networkInfoProvider = NetworkInfoProvider._();

final class NetworkInfoProvider
    extends $FunctionalProvider<NetworkInfo, NetworkInfo, NetworkInfo>
    with $Provider<NetworkInfo> {
  NetworkInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'networkInfoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$networkInfoHash();

  @$internal
  @override
  $ProviderElement<NetworkInfo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NetworkInfo create(Ref ref) {
    return networkInfo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NetworkInfo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NetworkInfo>(value),
    );
  }
}

String _$networkInfoHash() => r'df5a428e01aa48f3b8f56e832b47845e8c7e779e';
