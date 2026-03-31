import 'package:agent_pro/core/types/forgot_password_field.dart';
import 'package:agent_pro/features/auth/presentation/controllers/forgot_password_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

void main() {
  late ProviderContainer container;
  late ForgotPasswordNotifier notifier;

  setUp(() {
    container = ProviderContainer();
    notifier = container.read(forgotPasswordProvider.notifier);
  });

  tearDown(() {
    container.dispose();
  });

  test('Initial state is empty', () {
    // arrange & act
    final state = container.read(forgotPasswordProvider);
    // assert
    expect(state.email, '');
    expect(
      state.validationErrors,
      equals({
        ForgotPasswordField.email: const None(),
        ForgotPasswordField.otp: const None(),
        ForgotPasswordField.password: const None(),
        ForgotPasswordField.confirmPassword: const None(),
      }),
    );
  });
  test('isValidPageOne - returns true when there are no validation errors on page one', () {
    // arrange
    notifier.setEmail('test@example.com');
    // act
    final result = notifier.isValidPageOne;
    // assert
    expect(result, isTrue);
  });
  test('isValidPageOne - returns false when there are validation errors on page one', () {
    // arrange
    notifier.setEmail('invalid-email');
    // act
    final result = notifier.isValidPageOne;
    // assert
    expect(result, isFalse);
  });
  test('isValidPageTwo - returns true when there are no validation errors on page two', () {
    // arrange
    notifier.setOtp('123456');
    // act
    final result = notifier.isValidPageTwo;
    // assert
    expect(result, isTrue);
  });
  test('isValidPageTwo - returns false when there are validation errors on page two', () {
    // arrange
    notifier.setOtp('invalid-otp');
    // act
    final result = notifier.isValidPageTwo;
    // assert
    expect(result, isFalse);
  });
  test('isValidAll - returns true when there are no validation errors on all fields', () {
    // arrange
    notifier
      ..setEmail('test@example.com')
      ..setOtp('123456')
      ..setPassword('ValidPass123')
      ..setConfirmPassword('ValidPass123');
    // act
    final result = notifier.isValidAll;
    // assert
    expect(result, isTrue);
  });
  test('isValidAll - returns false when there are validation errors on any field', () {
    // arrange
    notifier
      ..setEmail('invalid-email')
      ..setOtp('123456')
      ..setPassword('ValidPass123')
      ..setConfirmPassword('ValidPass123');
    // act
    final result = notifier.isValidAll;
    // assert
    expect(result, isFalse);
  });
}
