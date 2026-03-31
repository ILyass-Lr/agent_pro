// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_notifier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignUpState _$SignUpStateFromJson(Map<String, dynamic> json) => _SignUpState(
  firstName: json['firstName'] as String? ?? '',
  lastName: json['lastName'] as String? ?? '',
  email: json['email'] as String? ?? '',
  phoneNumber: json['phoneNumber'] as String? ?? '',
  password: json['password'] as String? ?? '',
  confirmPassword: json['confirmPassword'] as String? ?? '',
  agencyName: json['agencyName'] as String? ?? '',
  licenseNumber: json['licenseNumber'] as String? ?? '',
  licenseFilePath: json['licenseFilePath'] as String? ?? '',
  acceptedTerms: json['acceptedTerms'] as bool? ?? false,
);

Map<String, dynamic> _$SignUpStateToJson(_SignUpState instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'agencyName': instance.agencyName,
      'licenseNumber': instance.licenseNumber,
      'licenseFilePath': instance.licenseFilePath,
      'acceptedTerms': instance.acceptedTerms,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SignUpNotifier)
@JsonPersist()
final signUpProvider = SignUpNotifierProvider._();

@JsonPersist()
final class SignUpNotifierProvider
    extends $NotifierProvider<SignUpNotifier, SignUpState> {
  SignUpNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signUpProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signUpNotifierHash();

  @$internal
  @override
  SignUpNotifier create() => SignUpNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignUpState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignUpState>(value),
    );
  }
}

String _$signUpNotifierHash() => r'e6b3d4ed40a2a3ddfd89d3b3c8bbebdf95e787cf';

@JsonPersist()
abstract class _$SignUpNotifierBase extends $Notifier<SignUpState> {
  SignUpState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SignUpState, SignUpState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SignUpState, SignUpState>,
              SignUpState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

// **************************************************************************
// JsonGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
abstract class _$SignUpNotifier extends _$SignUpNotifierBase {
  /// The default key used by [persist].
  String get key {
    const resolvedKey = "SignUpNotifier";
    return resolvedKey;
  }

  /// A variant of [persist], for JSON-specific encoding.
  ///
  /// You can override [key] to customize the key used for storage.
  PersistResult persist(
    FutureOr<Storage<String, String>> storage, {
    String? key,
    String Function(SignUpState state)? encode,
    SignUpState Function(String encoded)? decode,
    StorageOptions options = const StorageOptions(),
  }) {
    return NotifierPersistX(this).persist<String, String>(
      storage,
      key: key ?? this.key,
      encode: encode ?? $jsonCodex.encode,
      decode:
          decode ??
          (encoded) {
            final e = $jsonCodex.decode(encoded);
            return SignUpState.fromJson(e as Map<String, Object?>);
          },
      options: options,
    );
  }
}
