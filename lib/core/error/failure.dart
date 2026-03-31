import 'package:agent_pro/core/types/agent_status.dart';
import 'package:agent_pro/core/types/sign_up_field.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  // #--# Data / Domain Layer Failures #--#

  /// When the server returns a 404, 500, etc.
  const factory Failure.serverFailure({
    @Default('A server error occured') String message,
    SignUpField? field,
  }) = ServerFailure;

  const factory Failure.unauthorizedFailure({
    @Default('Unauthorized access') String message,
    required String reason,
    @Default(Status.pending) Status status,
  }) = UnauthorizedFailure;

  /// When local storage/cache is empty or corrupted
  const factory Failure.cacheFailure({@Default('No cached data found') String message}) =
      CacheFailure;

  /// When there is no internet connection
  const factory Failure.networkFailure({
    @Default('Please check your internet connection') String message,
  }) = NetworkFailure;

  const factory Failure.platformFailure({
    @Default('A platform related error occurred') String message,
  }) = PlatformFailure;
  // #--# Presentation Layer Failures #--#

  /// When the input is invalid (e.g., not a number)
  const factory Failure.invalidInputFailure({
    @Default('Invalid input - the number must be a positive integer or zero') String message,
  }) = InvalidInputFailure;

  /// When a method is rated too frequently (e.g., OTP resend cooldown)
  const factory Failure.rateLimitFailure({
    @Default('Too many requests - please try again later') String message,
    @Default(60) int coolDownSeconds,
  }) = RateLimitFailure;
}
