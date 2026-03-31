// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_remote_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authRemoteDataSourceImpl)
final authRemoteDataSourceImplProvider = AuthRemoteDataSourceImplProvider._();

final class AuthRemoteDataSourceImplProvider
    extends
        $FunctionalProvider<
          AuthRemoteDataSourceImpl,
          AuthRemoteDataSourceImpl,
          AuthRemoteDataSourceImpl
        >
    with $Provider<AuthRemoteDataSourceImpl> {
  AuthRemoteDataSourceImplProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRemoteDataSourceImplProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRemoteDataSourceImplHash();

  @$internal
  @override
  $ProviderElement<AuthRemoteDataSourceImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthRemoteDataSourceImpl create(Ref ref) {
    return authRemoteDataSourceImpl(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRemoteDataSourceImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRemoteDataSourceImpl>(value),
    );
  }
}

String _$authRemoteDataSourceImplHash() =>
    r'5e1a76c1e52e335a3c9096fbf63cbc820e82b41a';

@ProviderFor(authRemoteDataSource)
final authRemoteDataSourceProvider = AuthRemoteDataSourceProvider._();

final class AuthRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          AuthRemoteDataSource,
          AuthRemoteDataSource,
          AuthRemoteDataSource
        >
    with $Provider<AuthRemoteDataSource> {
  AuthRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<AuthRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthRemoteDataSource create(Ref ref) {
    return authRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRemoteDataSource>(value),
    );
  }
}

String _$authRemoteDataSourceHash() =>
    r'6bbadec9ea4328fe3964cd8b2ba1b3a8518c71eb';

@ProviderFor(tokenRefresher)
final tokenRefresherProvider = TokenRefresherProvider._();

final class TokenRefresherProvider
    extends $FunctionalProvider<TokenRefresher, TokenRefresher, TokenRefresher>
    with $Provider<TokenRefresher> {
  TokenRefresherProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tokenRefresherProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tokenRefresherHash();

  @$internal
  @override
  $ProviderElement<TokenRefresher> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TokenRefresher create(Ref ref) {
    return tokenRefresher(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TokenRefresher value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TokenRefresher>(value),
    );
  }
}

String _$tokenRefresherHash() => r'4fdca3c55cd9433a77d5f340f69dad24f16f206b';
