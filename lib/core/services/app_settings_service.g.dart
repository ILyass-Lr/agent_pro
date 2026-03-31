// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appSettingService)
final appSettingServiceProvider = AppSettingServiceProvider._();

final class AppSettingServiceProvider
    extends
        $FunctionalProvider<
          AppSettingService,
          AppSettingService,
          AppSettingService
        >
    with $Provider<AppSettingService> {
  AppSettingServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appSettingServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appSettingServiceHash();

  @$internal
  @override
  $ProviderElement<AppSettingService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppSettingService create(Ref ref) {
    return appSettingService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppSettingService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppSettingService>(value),
    );
  }
}

String _$appSettingServiceHash() => r'b59be87113c79b17f062b475c3cd67383f1cd3a3';
