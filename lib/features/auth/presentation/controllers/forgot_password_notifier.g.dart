// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ForgotPasswordNotifier)
final forgotPasswordProvider = ForgotPasswordNotifierProvider._();

final class ForgotPasswordNotifierProvider
    extends $NotifierProvider<ForgotPasswordNotifier, ForgotPasswordState> {
  ForgotPasswordNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'forgotPasswordProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$forgotPasswordNotifierHash();

  @$internal
  @override
  ForgotPasswordNotifier create() => ForgotPasswordNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ForgotPasswordState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ForgotPasswordState>(value),
    );
  }
}

String _$forgotPasswordNotifierHash() =>
    r'eefbc501aae81d259460b91f3a0328d2c8c92860';

abstract class _$ForgotPasswordNotifier extends $Notifier<ForgotPasswordState> {
  ForgotPasswordState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ForgotPasswordState, ForgotPasswordState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ForgotPasswordState, ForgotPasswordState>,
              ForgotPasswordState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(OtpTimer)
final otpTimerProvider = OtpTimerProvider._();

final class OtpTimerProvider extends $NotifierProvider<OtpTimer, int> {
  OtpTimerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'otpTimerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$otpTimerHash();

  @$internal
  @override
  OtpTimer create() => OtpTimer();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$otpTimerHash() => r'883eefa6c00f168156911b54a9b241f2b73182c1';

abstract class _$OtpTimer extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
