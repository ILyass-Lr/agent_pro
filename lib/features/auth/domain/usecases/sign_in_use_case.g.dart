// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(signInUseCase)
final signInUseCaseProvider = SignInUseCaseProvider._();

final class SignInUseCaseProvider
    extends $FunctionalProvider<SignIn, SignIn, SignIn>
    with $Provider<SignIn> {
  SignInUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signInUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signInUseCaseHash();

  @$internal
  @override
  $ProviderElement<SignIn> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SignIn create(Ref ref) {
    return signInUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignIn value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignIn>(value),
    );
  }
}

String _$signInUseCaseHash() => r'd7c41a287a210497dd7f783f2f1d84fea6f72f68';
