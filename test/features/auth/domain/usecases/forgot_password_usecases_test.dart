import 'package:agent_pro/core/error/failure.dart';
import 'package:agent_pro/features/auth/domain/repositories/auth_repository.dart';
import 'package:agent_pro/features/auth/domain/usecases/forgot_password_use_cases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late ProviderContainer container;

  late SendPasswordResetEmail sendPasswordResetEmail;
  late VerifyResetCode verifyResetCode;
  late ResetPassword resetPassword;

  setUp(() {
    mockAuthRepository = MockAuthRepository();

    sendPasswordResetEmail = SendPasswordResetEmail(mockAuthRepository);
    verifyResetCode = VerifyResetCode(mockAuthRepository);
    resetPassword = ResetPassword(mockAuthRepository);

    container = ProviderContainer(
      overrides: [authRepositoryProvider.overrideWithValue(mockAuthRepository)],
    );
  });
  late final String tEmail;
  late final String tCode;
  late final String tNewPassword;
  late final String tConfirmPassword;
  setUpAll(() {
    tEmail = 'test@example.com';
    tCode = '123456';
    tNewPassword = 'newpassword123';
    tConfirmPassword = 'newpassword123';
  });

  tearDown(() {
    container.dispose();
  });

  group('SendPasswordResetEmail', () {
    test('calls repository method with correct email', () async {
      // arrange
      when(
        () => mockAuthRepository.sendPasswordResetEmail(tEmail),
      ).thenAnswer((_) async => const Right(unit));
      // act
      final result = await sendPasswordResetEmail(tEmail);
      // assert
      expect(result, const Right(unit));
    });
    test('returns Left when repository method fails', () async {
      // arrange
      when(
        () => mockAuthRepository.sendPasswordResetEmail(tEmail),
      ).thenAnswer((_) async => const Left(ServerFailure(message: "Email not found")));
      // act
      final result = await sendPasswordResetEmail(tEmail);
      // assert
      expect(result.isLeft(), isTrue);
      expect(result.getLeft().toNullable(), isA<ServerFailure>());
    });
  });

  group('VerifyResetCode', () {
    test('calls repository method with correct code and email', () async {
      // arrange
      when(
        () => mockAuthRepository.verifyResetCode(tEmail, tCode),
      ).thenAnswer((_) async => const Right(unit));
      // act
      final result = await verifyResetCode((email: tEmail, code: tCode));
      // assert
      expect(result, const Right(unit));
    });
    test('returns Left when repository method fails', () async {
      // arrange
      when(
        () => mockAuthRepository.verifyResetCode(tEmail, tCode),
      ).thenAnswer((_) async => const Left(ServerFailure(message: "Invalid code")));

      // act
      final result = await verifyResetCode((email: tEmail, code: tCode));
      // assert
      expect(result.isLeft(), isTrue);
      expect(result.getLeft().toNullable(), isA<ServerFailure>());
    });
  });

  group('ResendOtp', () {
    test('calls repository method with correct email', () async {
      // arrange
      when(() => mockAuthRepository.resendOtp(tEmail)).thenAnswer((_) async => const Right(unit));
      // act
      final result = await container.read(resendOtpProvider)(tEmail);
      // assert
      expect(result, const Right(unit));
    });
    test('returns Left when repository method fails', () async {
      // arrange
      when(
        () => mockAuthRepository.resendOtp(tEmail),
      ).thenAnswer((_) async => const Left(ServerFailure(message: "OTP resend failed")));
      // act
      final result = await container.read(resendOtpProvider)(tEmail);
      // assert
      expect(result.isLeft(), isTrue);
      expect(result.getLeft().toNullable(), isA<ServerFailure>());
    });
  });

  group('ResetPassword', () {
    test('calls repository method with correct password and email', () async {
      // arrange
      when(
        () => mockAuthRepository.resetPassword(tEmail, tCode, tNewPassword, tConfirmPassword),
      ).thenAnswer((_) async => const Right(unit));
      // act
      final result = await resetPassword((
        email: tEmail,
        code: tCode,
        newPassword: tNewPassword,
        confirmPassword: tConfirmPassword,
      ));
      // assert
      expect(result, const Right(unit));
    });
    test('returns Left when repository method fails', () async {
      // arrange
      when(
        () => mockAuthRepository.resetPassword(tEmail, tCode, tNewPassword, tConfirmPassword),
      ).thenAnswer((_) async => const Left(ServerFailure(message: "Password reset failed")));
      // act
      final result = await resetPassword((
        email: tEmail,
        code: tCode,
        newPassword: tNewPassword,
        confirmPassword: tConfirmPassword,
      ));
      // assert
      expect(result.isLeft(), isTrue);
      expect(result.getLeft().toNullable(), isA<ServerFailure>());
    });
  });
}
