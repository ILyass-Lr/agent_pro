import 'package:agent_pro/core/types/sign_in_field.dart';
import 'package:agent_pro/features/auth/domain/entities/agent.dart';
import 'package:agent_pro/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_notifier.g.dart';
part 'sign_in_notifier.freezed.dart';

@freezed
abstract class SignInState with _$SignInState {
  const factory SignInState({
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool rememberMe,
    @JsonKey(includeFromJson: false, includeToJson: false)
    /// The Error Map that maps a field to one of the 3 states:
    /// - null: No error (validated successfully)
    /// - none(): Not yet validated / no validation performed
    /// - some("error message"): An error with the message "error message"
    @Default({SignInField.email: None(), SignInField.password: None()})
    Map<SignInField, Option<String>> validationErrors,
  }) = _SignInState;
}

@Riverpod(keepAlive: true)
class SignInNotifier extends _$SignInNotifier {
  @override
  SignInState build() {
    final rememberedEmail = ref.watch(authRepositoryProvider).getRememberedEmail();
    if (rememberedEmail != null) {
      return SignInState(email: rememberedEmail, rememberMe: true);
    }
    return const SignInState();
  }

  void setEmail(String value) {
    state = state.copyWith(
      email: value,
      validationErrors: _setError(
        state.validationErrors,
        SignInField.email,
        Email.create(value).getLeft().map((failure) => failure.message).getOrElse(() => ''),
      ),
    );
  }

  String? _passwordError(String pass) {
    return switch (pass) {
      '' => "Password cannot be empty",
      _ when RegExp(r'^\s').hasMatch(pass) || RegExp(r'\s$').hasMatch(pass) =>
        "Cannot start or end with whitespace(s)",
      _ when RegExp(r'\s{2,}').hasMatch(pass) => "Cannot contain consecutive whitespace characters",
      _ => null,
    };
  }

  void setPassword(String pass) {
    final errorMessage = _passwordError(pass);

    state = state.copyWith(
      password: pass,
      validationErrors: _setError(state.validationErrors, SignInField.password, errorMessage),
    );
  }

  void toggleRememberMe() {
    state = state.copyWith(rememberMe: !state.rememberMe);
  }

  Map<SignInField, Option<String>> _setError(
    Map<SignInField, Option<String>> current,
    SignInField field,
    String? message,
  ) {
    final updated = Map<SignInField, Option<String>>.from(current);
    if (message == null || message.isEmpty) {
      updated.remove(field);
    } else {
      updated[field] = some(message);
    }
    return updated;
  }

  bool get isValidForm =>
      Email.create(state.email).isRight() && _passwordError(state.password) == null;
}
