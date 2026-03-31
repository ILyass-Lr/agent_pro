import 'package:agent_pro/features/auth/domain/entities/agent.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_status_notifier.g.dart';
part 'auth_status_notifier.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.unauthenticated({String? message}) = _Unauthenticated;
  const factory AuthState.authenticated(Agent agent) = _Authenticated;
  const factory AuthState.blocked(String message, String reason) = _Blocked;
}

@Riverpod(keepAlive: true)
class AuthStatusNotifier extends _$AuthStatusNotifier {
  @override
  AuthState build() => const AuthState.initial();

  void login(Agent agent) {
    state = AuthState.authenticated(agent);
  }

  void logout([String? message]) {
    state = AuthState.unauthenticated(message: message);
  }

  String? consumeLogoutMessage() {
    return state.maybeWhen(
      unauthenticated: (message) {
        if (message == null || message.isEmpty) return null;
        state = const AuthState.unauthenticated();
        return message;
      },
      orElse: () => null,
    );
  }

  void block(String message, String reason) {
    state = AuthState.blocked(message, reason);
  }
}
