// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(signUpMutation)
final signUpMutationProvider = SignUpMutationProvider._();

final class SignUpMutationProvider
    extends $FunctionalProvider<Mutation<Unit>, Mutation<Unit>, Mutation<Unit>>
    with $Provider<Mutation<Unit>> {
  SignUpMutationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signUpMutationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signUpMutationHash();

  @$internal
  @override
  $ProviderElement<Mutation<Unit>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Mutation<Unit> create(Ref ref) {
    return signUpMutation(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Mutation<Unit> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Mutation<Unit>>(value),
    );
  }
}

String _$signUpMutationHash() => r'7cbc31d35330f7af2c37dbb2ceeabbfe6171bc95';

@ProviderFor(signInMutation)
final signInMutationProvider = SignInMutationProvider._();

final class SignInMutationProvider
    extends
        $FunctionalProvider<Mutation<Agent>, Mutation<Agent>, Mutation<Agent>>
    with $Provider<Mutation<Agent>> {
  SignInMutationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signInMutationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signInMutationHash();

  @$internal
  @override
  $ProviderElement<Mutation<Agent>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Mutation<Agent> create(Ref ref) {
    return signInMutation(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Mutation<Agent> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Mutation<Agent>>(value),
    );
  }
}

String _$signInMutationHash() => r'315ee372f707e028e561386d183189f91226171e';

@ProviderFor(forgotPasswordMutation)
final forgotPasswordMutationProvider = ForgotPasswordMutationProvider._();

final class ForgotPasswordMutationProvider
    extends $FunctionalProvider<Mutation<Unit>, Mutation<Unit>, Mutation<Unit>>
    with $Provider<Mutation<Unit>> {
  ForgotPasswordMutationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'forgotPasswordMutationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$forgotPasswordMutationHash();

  @$internal
  @override
  $ProviderElement<Mutation<Unit>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Mutation<Unit> create(Ref ref) {
    return forgotPasswordMutation(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Mutation<Unit> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Mutation<Unit>>(value),
    );
  }
}

String _$forgotPasswordMutationHash() =>
    r'4548106b3f3a986445ee8808bce906f1a4b3a140';

/// We make a separate mutation for OTP resending so we don't react to the success and navigate to the next page when the user just wants to resend the OTP without actually submitting the form

@ProviderFor(resendOtpMutation)
final resendOtpMutationProvider = ResendOtpMutationProvider._();

/// We make a separate mutation for OTP resending so we don't react to the success and navigate to the next page when the user just wants to resend the OTP without actually submitting the form

final class ResendOtpMutationProvider
    extends $FunctionalProvider<Mutation<Unit>, Mutation<Unit>, Mutation<Unit>>
    with $Provider<Mutation<Unit>> {
  /// We make a separate mutation for OTP resending so we don't react to the success and navigate to the next page when the user just wants to resend the OTP without actually submitting the form
  ResendOtpMutationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resendOtpMutationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resendOtpMutationHash();

  @$internal
  @override
  $ProviderElement<Mutation<Unit>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Mutation<Unit> create(Ref ref) {
    return resendOtpMutation(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Mutation<Unit> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Mutation<Unit>>(value),
    );
  }
}

String _$resendOtpMutationHash() => r'2006df1de8638118682b387c6aa9d9662b6f5f6d';

@ProviderFor(signOutMutation)
final signOutMutationProvider = SignOutMutationProvider._();

final class SignOutMutationProvider
    extends $FunctionalProvider<Mutation<Unit>, Mutation<Unit>, Mutation<Unit>>
    with $Provider<Mutation<Unit>> {
  SignOutMutationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signOutMutationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signOutMutationHash();

  @$internal
  @override
  $ProviderElement<Mutation<Unit>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Mutation<Unit> create(Ref ref) {
    return signOutMutation(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Mutation<Unit> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Mutation<Unit>>(value),
    );
  }
}

String _$signOutMutationHash() => r'565c7ee502872080c9334b35812b924e59382f23';

@ProviderFor(AuthController)
final authControllerProvider = AuthControllerProvider._();

final class AuthControllerProvider
    extends $NotifierProvider<AuthController, void> {
  AuthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authControllerHash();

  @$internal
  @override
  AuthController create() => AuthController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$authControllerHash() => r'bbca77fc4a9296c11e0ffbb1e8314d63a775d9f6';

abstract class _$AuthController extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
