// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_init_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Responsible for initializing the authentication state of the app on startup.
/// It checks for an existing access token, validates it, and updates the [AuthStatusNotifier] accordingly.

@ProviderFor(authInit)
final authInitProvider = AuthInitProvider._();

/// Responsible for initializing the authentication state of the app on startup.
/// It checks for an existing access token, validates it, and updates the [AuthStatusNotifier] accordingly.

final class AuthInitProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  /// Responsible for initializing the authentication state of the app on startup.
  /// It checks for an existing access token, validates it, and updates the [AuthStatusNotifier] accordingly.
  AuthInitProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authInitProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authInitHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return authInit(ref);
  }
}

String _$authInitHash() => r'12e077d29ca140d093ee94da86cc8672682bbafa';
