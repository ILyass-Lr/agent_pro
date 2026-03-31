// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(signUpUseCase)
final signUpUseCaseProvider = SignUpUseCaseProvider._();

final class SignUpUseCaseProvider
    extends $FunctionalProvider<SignUp, SignUp, SignUp>
    with $Provider<SignUp> {
  SignUpUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signUpUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signUpUseCaseHash();

  @$internal
  @override
  $ProviderElement<SignUp> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SignUp create(Ref ref) {
    return signUpUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignUp value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignUp>(value),
    );
  }
}

String _$signUpUseCaseHash() => r'a4d1690d7e223635ced70bcc9893688d5492a839';
