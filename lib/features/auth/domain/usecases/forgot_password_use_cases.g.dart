// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_use_cases.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sendPasswordResetEmail)
final sendPasswordResetEmailProvider = SendPasswordResetEmailProvider._();

final class SendPasswordResetEmailProvider
    extends
        $FunctionalProvider<
          SendPasswordResetEmail,
          SendPasswordResetEmail,
          SendPasswordResetEmail
        >
    with $Provider<SendPasswordResetEmail> {
  SendPasswordResetEmailProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sendPasswordResetEmailProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sendPasswordResetEmailHash();

  @$internal
  @override
  $ProviderElement<SendPasswordResetEmail> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SendPasswordResetEmail create(Ref ref) {
    return sendPasswordResetEmail(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SendPasswordResetEmail value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SendPasswordResetEmail>(value),
    );
  }
}

String _$sendPasswordResetEmailHash() =>
    r'7169bc5be459aa25071e21cd70d68690d887a0c8';

@ProviderFor(verifyResetCode)
final verifyResetCodeProvider = VerifyResetCodeProvider._();

final class VerifyResetCodeProvider
    extends
        $FunctionalProvider<VerifyResetCode, VerifyResetCode, VerifyResetCode>
    with $Provider<VerifyResetCode> {
  VerifyResetCodeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verifyResetCodeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verifyResetCodeHash();

  @$internal
  @override
  $ProviderElement<VerifyResetCode> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VerifyResetCode create(Ref ref) {
    return verifyResetCode(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VerifyResetCode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VerifyResetCode>(value),
    );
  }
}

String _$verifyResetCodeHash() => r'122c0858180e5bf19d64fe8a9a8bf939881ed169';

@ProviderFor(resetPassword)
final resetPasswordProvider = ResetPasswordProvider._();

final class ResetPasswordProvider
    extends $FunctionalProvider<ResetPassword, ResetPassword, ResetPassword>
    with $Provider<ResetPassword> {
  ResetPasswordProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resetPasswordProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resetPasswordHash();

  @$internal
  @override
  $ProviderElement<ResetPassword> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ResetPassword create(Ref ref) {
    return resetPassword(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResetPassword value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResetPassword>(value),
    );
  }
}

String _$resetPasswordHash() => r'f3b489a6c24c4b4d17ac13bcf2e714fd1b207429';

@ProviderFor(resendOtp)
final resendOtpProvider = ResendOtpProvider._();

final class ResendOtpProvider
    extends $FunctionalProvider<ResendOtp, ResendOtp, ResendOtp>
    with $Provider<ResendOtp> {
  ResendOtpProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resendOtpProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resendOtpHash();

  @$internal
  @override
  $ProviderElement<ResendOtp> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ResendOtp create(Ref ref) {
    return resendOtp(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResendOtp value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResendOtp>(value),
    );
  }
}

String _$resendOtpHash() => r'f07bee6bfe3813815ef1d2d8ef86a3f53a0458ca';
