import 'dart:async';

import 'package:agent_pro/core/types/forgot_password_field.dart';
import 'package:agent_pro/features/auth/domain/entities/agent.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'forgot_password_notifier.freezed.dart';
part 'forgot_password_notifier.g.dart';

@freezed
abstract class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState({
    @Default('') String email,
    @Default('') String otp,
    @Default('') String password,
    @Default('') String confirmPassword,
    @JsonKey(includeFromJson: false, includeToJson: false)
    /// The Error Map that maps a field to one of the 3 states:
    /// - null: No error (validated successfully)
    /// - none(): Not yet validated / no validation performed
    /// - some("error message"): An error with the message "error message"
    @Default({
      ForgotPasswordField.email: None(),
      ForgotPasswordField.otp: None(),
      ForgotPasswordField.password: None(),
      ForgotPasswordField.confirmPassword: None(),
    })
    Map<ForgotPasswordField, Option<String>> validationErrors,
  }) = _ForgotPasswordState;
}

@Riverpod(keepAlive: true)
class ForgotPasswordNotifier extends _$ForgotPasswordNotifier {
  @override
  ForgotPasswordState build() => const ForgotPasswordState();
  // [PAGE 1] - Validation
  void setEmail(String value) {
    state = state.copyWith(
      email: value,
      validationErrors: _setError(
        state.validationErrors,
        ForgotPasswordField.email,
        Email.create(value).getLeft().map((failure) => failure.message).getOrElse(() => ''),
      ),
    );
  }

  // [PAGE 2] - Validation
  String? _otpError(String otp) {
    if (otp.isEmpty) {
      return 'OTP cannot be empty';
    } else if (otp.length != 6) {
      return 'OTP must be 6 digits long';
    } else if (!RegExp(r'^\d{6}$').hasMatch(otp)) {
      return 'OTP must contain only digits';
    }
    return null;
  }

  void setOtp(String value) {
    state = state.copyWith(
      otp: value,
      validationErrors: _setError(
        state.validationErrors,
        ForgotPasswordField.otp,
        _otpError(value),
      ),
    );
  }

  // [PAGE 3] - Validation
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
    var errors = _setError(
      state.validationErrors,
      ForgotPasswordField.password,
      _passwordError(value),
    );
    if (errors[ForgotPasswordField.password] == null) {
      errors = _setError(
        errors,
        ForgotPasswordField.confirmPassword,
        state.confirmPassword == value ? null : 'Passwords do not match',
      );
    }
    state = state.copyWith(password: value, validationErrors: errors);
  }

  void setConfirmPassword(String value) {
    final errors = _setError(
      state.validationErrors,
      ForgotPasswordField.confirmPassword,
      value == state.password ? null : 'Passwords do not match',
    );
    state = state.copyWith(confirmPassword: value, validationErrors: errors);
  }

  Map<ForgotPasswordField, Option<String>> _setError(
    Map<ForgotPasswordField, Option<String>> current,
    ForgotPasswordField field,
    String? message,
  ) {
    final updated = Map<ForgotPasswordField, Option<String>>.from(current);
    if (message == null || message.isEmpty) {
      updated.remove(field);
    } else {
      updated[field] = some(message);
    }
    return updated;
  }

  bool get isValidPageOne => state.validationErrors[ForgotPasswordField.email] == null;
  bool get isValidPageTwo => state.validationErrors[ForgotPasswordField.otp] == null;
  bool get isValidAll =>
      Email.create(state.email).isRight() &&
      _otpError(state.otp) == null &&
      _passwordError(state.password) == null &&
      _passwordError(state.confirmPassword) == null &&
      state.password == state.confirmPassword;
}

@riverpod
class OtpTimer extends _$OtpTimer {
  Timer? _timer;

  @override
  int build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    return 0;
  }

  void start({int seconds = 60}) {
    state = seconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        state--;
      } else {
        timer.cancel();
      }
    });
  }
}
