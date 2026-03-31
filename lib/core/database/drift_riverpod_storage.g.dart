// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_riverpod_storage.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(driftRiverpodStorage)
final driftRiverpodStorageProvider = DriftRiverpodStorageProvider._();

final class DriftRiverpodStorageProvider
    extends
        $FunctionalProvider<
          DriftRiverpodStorage,
          DriftRiverpodStorage,
          DriftRiverpodStorage
        >
    with $Provider<DriftRiverpodStorage> {
  DriftRiverpodStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driftRiverpodStorageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driftRiverpodStorageHash();

  @$internal
  @override
  $ProviderElement<DriftRiverpodStorage> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DriftRiverpodStorage create(Ref ref) {
    return driftRiverpodStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DriftRiverpodStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DriftRiverpodStorage>(value),
    );
  }
}

String _$driftRiverpodStorageHash() =>
    r'd0423df0dc78d628d64767b947ea3aedd4b53dbd';
