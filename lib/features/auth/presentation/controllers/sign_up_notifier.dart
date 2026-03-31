import 'dart:io';

import 'package:agent_pro/core/database/drift_riverpod_storage.dart';
import 'package:agent_pro/core/types/sign_up_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/experimental/persist.dart';
import 'package:riverpod_annotation/experimental/json_persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/agent.dart';

part 'sign_up_notifier.g.dart';
part 'sign_up_notifier.freezed.dart';

@freezed
abstract class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String email,
    @Default('') String phoneNumber,
    @Default('') String password,
    @Default('') String confirmPassword,
    @Default('') String agencyName,
    @Default('') String licenseNumber,
    @Default('') String licenseFilePath,
    @Default(false) bool acceptedTerms,
    // Validation errors for each field, the below fields are required
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default({
      SignUpField.firstName: None(),
      SignUpField.lastName: None(),
      SignUpField.email: None(),
      SignUpField.phoneNumber: None(),
      SignUpField.password: None(),
      SignUpField.confirmPassword: None(),
      SignUpField.agencyName: None(),
    })
    Map<SignUpField, Option<String>> validationErrors,
  }) = _SignUpState;

  factory SignUpState.fromJson(Map<String, dynamic> json) => _$SignUpStateFromJson(json);
}

@riverpod
@JsonPersist()
class SignUpNotifier extends _$SignUpNotifier {
  static const String persistedDraftKey = 'DRAFT_SIGN_UP_FORM';
  bool _hydratedFromPersistedDraft = false;

  @override
  String get key => persistedDraftKey;

  @override
  SignUpState build() {
    persist(ref.watch(driftRiverpodStorageProvider));

    // Check if a draft was just restored and hydrate its validation errors immediately
    final restoredState = state;
    if (!_hydratedFromPersistedDraft && _hasDraftData(restoredState)) {
      _hydratedFromPersistedDraft = true;
      return restoredState.copyWith(validationErrors: hydrateValidationErrors(restoredState));
    }

    return const SignUpState();
  }

  bool _hasDraftData(SignUpState draft) {
    return draft.firstName.isNotEmpty ||
        draft.lastName.isNotEmpty ||
        draft.email.isNotEmpty ||
        draft.phoneNumber.isNotEmpty ||
        draft.password.isNotEmpty ||
        draft.confirmPassword.isNotEmpty ||
        draft.agencyName.isNotEmpty ||
        draft.licenseNumber.isNotEmpty ||
        draft.licenseFilePath.isNotEmpty ||
        draft.acceptedTerms;
  }

  // This method performs validation hydration, useful when loading a draft that was persisted without real-time validation (e.g., after app restart).
  Map<SignUpField, Option<String>> hydrateValidationErrors(SignUpState draft) {
    final errors = <SignUpField, Option<String>>{};

    void putIfInvalid(SignUpField field, String? message) {
      if (message != null) errors[field] = some(message);
    }

    putIfInvalid(SignUpField.firstName, _fieldError(draft.firstName, SignUpField.firstName));
    putIfInvalid(SignUpField.lastName, _fieldError(draft.lastName, SignUpField.lastName));
    putIfInvalid(SignUpField.email, _fieldError(draft.email, SignUpField.email));
    putIfInvalid(SignUpField.phoneNumber, _fieldError(draft.phoneNumber, SignUpField.phoneNumber));
    putIfInvalid(SignUpField.agencyName, _fieldError(draft.agencyName, SignUpField.agencyName));

    if (draft.licenseNumber.isNotEmpty) {
      putIfInvalid(
        SignUpField.licenseNumber,
        _fieldError(draft.licenseNumber, SignUpField.licenseNumber),
      );
    }

    if (draft.licenseFilePath.isNotEmpty) {
      // Pure hydration only validates value shape; it intentionally skips async file existence checks.
      putIfInvalid(
        SignUpField.licenseFilePath,
        _fieldError(draft.licenseFilePath, SignUpField.licenseFilePath),
      );
    }

    putIfInvalid(SignUpField.password, _passwordError(draft.password));

    if (draft.confirmPassword.isEmpty || draft.confirmPassword != draft.password) {
      errors[SignUpField.confirmPassword] = some('Passwords do not match');
    }

    return errors;
  }

  Future<void> clearPersistedDraft() async {
    state = const SignUpState();
    await ref.read(driftRiverpodStorageProvider).delete(key);
  }

  // [PAGE 1] Personal Information
  void setFirstName(String value) {
    final errors = _setError(
      state.validationErrors,
      SignUpField.firstName,
      _fieldError(value, SignUpField.firstName),
    );
    state = state.copyWith(firstName: value, validationErrors: errors);
  }

  void setLastName(String value) {
    final errors = _setError(
      state.validationErrors,
      SignUpField.lastName,
      _fieldError(value, SignUpField.lastName),
    );
    state = state.copyWith(lastName: value, validationErrors: errors);
  }

  void setEmail(String value) {
    final errors = _setError(
      state.validationErrors,
      SignUpField.email,
      _fieldError(value, SignUpField.email),
    );
    state = state.copyWith(email: value, validationErrors: errors);
  }

  void setPhoneNumber(String value) {
    final errors = _setError(
      state.validationErrors,
      SignUpField.phoneNumber,
      _fieldError(value, SignUpField.phoneNumber),
    );
    state = state.copyWith(phoneNumber: value, validationErrors: errors);
  }

  String? _passwordError(String pass) {
    return switch (pass) {
      '' => 'Password cannot be empty',
      _ when pass.length < 8 => 'Must be at least 8 characters long',
      _ when RegExp(r'^\s').hasMatch(pass) || RegExp(r'\s$').hasMatch(pass) =>
        'Password cannot start or end with whitespace',
      _ when RegExp(r'\s{2,}').hasMatch(pass) => 'Cannot contain consecutive whitespace characters',
      _ when !RegExp(r'^[\x00-\x7F]+$').hasMatch(pass) =>
        'Password cannot contain non-ASCII characters',
      _ when RegExp(r'password', caseSensitive: false).hasMatch(pass) =>
        "Password cannot contain the word 'password'",
      _ when RegExp(r'^\d+$').hasMatch(pass) => 'Password cannot be entirely numeric',
      _ when RegExp(r'^[a-zA-Z]+$').hasMatch(pass) => 'Password cannot be entirely alphabetic',
      _ => null,
    };
  }

  void setPassword(String value) {
    var errors = _setError(state.validationErrors, SignUpField.password, _passwordError(value));
    if (errors[SignUpField.password] == null) {
      errors = _setError(
        errors,
        SignUpField.confirmPassword,
        state.confirmPassword == value ? null : 'Passwords do not match',
      );
    }
    state = state.copyWith(password: value, validationErrors: errors);
  }

  void setConfirmPassword(String value) {
    final errors = _setError(
      state.validationErrors,
      SignUpField.confirmPassword,
      value == state.password ? null : 'Passwords do not match',
    );
    state = state.copyWith(confirmPassword: value, validationErrors: errors);
  }

  // [PAGE 2] Professional Information
  void setAgencyName(String value) {
    final errors = _setError(
      state.validationErrors,
      SignUpField.agencyName,
      _fieldError(value, SignUpField.agencyName),
    );
    state = state.copyWith(agencyName: value, validationErrors: errors);
  }

  void setLicenseNumber(String value) {
    final errors = _setError(
      state.validationErrors,
      SignUpField.licenseNumber,
      _fieldError(value, SignUpField.licenseNumber),
    );
    state = state.copyWith(licenseNumber: value, validationErrors: errors);
  }

  Future<void> setLicenseFilePath(PlatformFile value) async {
    final path = value.path ?? '';
    final extension = value.extension?.toLowerCase() ?? '';

    String? error;
    if (!['pdf', 'jpg', 'jpeg', 'png'].contains(extension)) {
      error = 'Unsupported file type!';
    } else if (value.size > 10 * 1024 * 1024) {
      error = 'File size exceeds 10MB limit';
    } else {
      error = _fieldError(path, SignUpField.licenseFilePath);
      if (error == null) {
        final existsLocally = await File(path).exists();
        if (!ref.mounted) return;
        if (!existsLocally) {
          error = 'File does not exist at the provided path';
        }
      }
    }

    final errors = _setError(state.validationErrors, SignUpField.licenseFilePath, error);
    state = state.copyWith(licenseFilePath: path, validationErrors: errors);
  }

  void setAcceptedTerms(bool value) {
    final errors = _setError(
      state.validationErrors,
      SignUpField.terms,
      value ? null : 'You must accept the terms and conditions',
    );
    state = state.copyWith(acceptedTerms: value, validationErrors: errors);
  }

  // Validation Logic
  String? _fieldError(String value, SignUpField field) {
    final result = switch (field) {
      SignUpField.firstName => Name.create(value),
      SignUpField.lastName => Name.create(value),
      SignUpField.email => Email.create(value),
      SignUpField.phoneNumber => PhoneNumber.create(value),
      SignUpField.agencyName => Name.create(value),
      SignUpField.licenseNumber => FifaLicense.create(value),
      SignUpField.licenseFilePath => FilePath.create(value),
      _ => Name.create(value),
    };

    if (result.isLeft()) {
      return result.getLeft().map((failure) => failure.message).getOrElse(() => 'Unknown Error!');
    }
    return null;
  }

  Map<SignUpField, Option<String>> _setError(
    Map<SignUpField, Option<String>> current,
    SignUpField field,
    String? message,
  ) {
    final updated = Map<SignUpField, Option<String>>.from(current);
    if (message == null) {
      updated.remove(field);
    } else {
      updated[field] = some(message);
    }
    return updated;
  }

  bool validatePageOne() {
    final currentState = state;
    final isFirstNameValid = Name.create(currentState.firstName).isRight();
    final isLastNameValid = Name.create(currentState.lastName).isRight();
    final isEmailValid = Email.create(currentState.email).isRight();
    final isPhoneValid = PhoneNumber.create(currentState.phoneNumber).isRight();
    final isPasswordValid = _passwordError(currentState.password) == null;
    final isConfirmPasswordValid =
        currentState.confirmPassword.isNotEmpty &&
        currentState.confirmPassword == currentState.password;

    return isFirstNameValid &&
        isLastNameValid &&
        isEmailValid &&
        isPhoneValid &&
        isPasswordValid &&
        isConfirmPasswordValid;
  }

  bool validateAll() {
    final pageOneValid = validatePageOne();
    final currentState = state;
    final isAgencyNameValid = Name.create(currentState.agencyName).isRight();
    final isLicenseNumberValid =
        currentState.licenseNumber.isEmpty ||
        FifaLicense.create(currentState.licenseNumber).isRight();
    final hasLicenseFilePathError =
        currentState.validationErrors[SignUpField.licenseFilePath] is Some<String>;
    final isLicenseFilePathValid =
        !hasLicenseFilePathError &&
        (currentState.licenseFilePath.isEmpty ||
            FilePath.create(currentState.licenseFilePath).isRight());

    return pageOneValid && isAgencyNameValid && isLicenseNumberValid && isLicenseFilePathValid;
  }

  void setValidationError(SignUpField field, String message) {
    final errors = _setError(state.validationErrors, field, message);
    state = state.copyWith(validationErrors: errors);
  }
}
