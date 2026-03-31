import 'dart:convert';

import 'package:agent_pro/core/database/app_database.dart';
import 'package:agent_pro/core/error/failure.dart';
import 'package:agent_pro/core/services/auth_status_notifier.dart';
import 'package:agent_pro/core/usecase/usecase.dart';
import 'package:agent_pro/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:drift/native.dart';
import 'package:agent_pro/features/auth/data/models/agent_model.dart';
import 'package:agent_pro/features/auth/domain/repositories/auth_repository.dart';
import 'package:agent_pro/features/auth/domain/usecases/forgot_password_use_cases.dart';
import 'package:agent_pro/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:agent_pro/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:agent_pro/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSignUpUseCase extends Mock implements SignUp {}

class MockSignInUseCase extends Mock implements SignIn {}

class MockSignOutUseCase extends Mock implements SignOut {}

class MockSendPasswordResetEmailUseCase extends Mock implements SendPasswordResetEmail {}

class MockVerifyResetCodeUseCase extends Mock implements VerifyResetCode {}

class MockResendOtpUseCase extends Mock implements ResendOtp {}

class MockResetPasswordUseCase extends Mock implements ResetPassword {}

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late ProviderContainer container;
  late MockSignUpUseCase mockSignUpUseCase;
  late MockSignInUseCase mockSignInUseCase;
  late MockSignOutUseCase mockSignOutUseCase;
  late MockSendPasswordResetEmailUseCase mockSendPasswordResetEmailUseCase;
  late MockVerifyResetCodeUseCase mockVerifyResetCodeUseCase;
  late MockResendOtpUseCase mockResendOtpUseCase;
  late MockResetPasswordUseCase mockResetPasswordUseCase;
  late MockAuthRepository mockAuthRepository;
  late AppDatabase testDatabase;

  late AuthController authController;

  setUp(() {
    mockSignUpUseCase = MockSignUpUseCase();
    mockSignInUseCase = MockSignInUseCase();
    mockSignOutUseCase = MockSignOutUseCase();
    mockSendPasswordResetEmailUseCase = MockSendPasswordResetEmailUseCase();
    mockVerifyResetCodeUseCase = MockVerifyResetCodeUseCase();
    mockResendOtpUseCase = MockResendOtpUseCase();
    mockResetPasswordUseCase = MockResetPasswordUseCase();
    mockAuthRepository = MockAuthRepository();
    when(() => mockAuthRepository.getRememberedEmail()).thenReturn(null);
    testDatabase = AppDatabase(NativeDatabase.memory());
    container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(testDatabase),
        authRepositoryProvider.overrideWithValue(mockAuthRepository),
        signUpUseCaseProvider.overrideWithValue(mockSignUpUseCase),
        signInUseCaseProvider.overrideWithValue(mockSignInUseCase),
        sendPasswordResetEmailProvider.overrideWithValue(mockSendPasswordResetEmailUseCase),
        verifyResetCodeProvider.overrideWithValue(mockVerifyResetCodeUseCase),
        resetPasswordProvider.overrideWithValue(mockResetPasswordUseCase),
        signOutUseCaseProvider.overrideWithValue(mockSignOutUseCase),
        resendOtpProvider.overrideWithValue(mockResendOtpUseCase),
      ],
    );
    authController = container.read(authControllerProvider.notifier);
    // Fallback value for SignUpParams
    registerFallbackValue((
      personal: (firstName: '', lastName: '', email: '', phoneNumber: ''),
      security: (password: '', confirmPassword: ''),
      professional: (agencyName: '', fifaLicense: '', licenseFilePath: ''),
    ));
    // Fallback value for SignInParams
    registerFallbackValue((email: ',', password: '', rememberMe: true));
    // Fallback value for VerifyResetCode
    registerFallbackValue((email: '', code: ''));
    // Fallback value for ResetPassword
    registerFallbackValue((email: '', code: '', newPassword: '', confirmPassword: ''));
  });

  tearDown(() {
    testDatabase.close();
    container.dispose();
  });

  group('performSignUp', () {
    test('should call use case with correct params and return success', () async {
      // arrange
      when(() => mockSignUpUseCase(any())).thenAnswer((_) async => const Right(unit));

      // act
      await authController.performSignUp();

      // assert
      verify(() => mockSignUpUseCase(any())).called(1);
    });

    test('should throw a failure when use case return one', () async {
      // arrange
      const tFailure = ServerFailure(message: 'Server error');
      when(() => mockSignUpUseCase(any())).thenAnswer((_) async => const Left(tFailure));

      // act
      Future<void> call() async => await authController.performSignUp();

      // assert
      expect(call(), throwsA(isA<ServerFailure>()));
    });
  });
  group('performSignIn', () {
    test('should call use case with correct params and return agent', () async {
      // arrange
      final tAgent = AgentModel.fromJson(jsonDecode(fixture('agent/valid.json'))).toEntity();
      when(() => mockSignInUseCase(any())).thenAnswer((_) async => Right(tAgent));

      // act
      final result = await authController.performSignIn();

      // assert
      verify(() => mockSignInUseCase(any())).called(1);
      expect(result, equals(tAgent));
    });

    test('should throw a failure when use case return one', () async {
      // arrange
      const tFailure = UnauthorizedFailure(
        message: 'Access revoked',
        reason: 'Invalid credentials',
      );
      when(() => mockSignInUseCase(any())).thenAnswer((_) async => const Left(tFailure));

      // act
      Future<void> call() async => await authController.performSignIn();

      // assert
      expect(call(), throwsA(isA<UnauthorizedFailure>()));
    });
  });
  group('performSendPasswordResetEmail', () {
    test('should call use case with correct params and return success', () async {
      // arrange
      when(
        () => mockSendPasswordResetEmailUseCase(any()),
      ).thenAnswer((_) async => const Right(unit));

      // act
      await authController.sendPasswordResetEmail();

      // assert
      verify(() => mockSendPasswordResetEmailUseCase(any())).called(1);
    });

    test('should throw a failure when use case return one', () async {
      // arrange
      const tFailure = ServerFailure(message: 'Server error');
      when(
        () => mockSendPasswordResetEmailUseCase(any()),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      Future<void> call() async => await authController.sendPasswordResetEmail();

      // assert
      expect(call(), throwsA(isA<ServerFailure>()));
    });
  });
  group('performVerifyResetCode', () {
    test('should call use case with correct params and return success', () async {
      // arrange
      when(() => mockVerifyResetCodeUseCase(any())).thenAnswer((_) async => const Right(unit));

      // act
      await authController.sendOtp();

      // assert
      verify(() => mockVerifyResetCodeUseCase(any())).called(1);
    });

    test('should throw a failure when use case return one', () async {
      // arrange
      const tFailure = ServerFailure(message: 'Server error');
      when(() => mockVerifyResetCodeUseCase(any())).thenAnswer((_) async => const Left(tFailure));

      // act
      Future<void> call() async => await authController.sendOtp();

      // assert
      expect(call(), throwsA(isA<ServerFailure>()));
    });
  });

  group('performResendOtp', () {
    test('should call use case with correct params and return success', () async {
      // arrange
      when(() => mockResendOtpUseCase(any())).thenAnswer((_) async => const Right(unit));

      // act
      await authController.resendOtp();

      // assert
      verify(() => mockResendOtpUseCase(any())).called(1);
    });

    test('should not throw when use case returns failure (failure is handled)', () async {
      // arrange
      const tFailure = ServerFailure(message: 'Server error');
      when(() => mockResendOtpUseCase(any())).thenAnswer((_) async => const Left(tFailure));

      // act
      Future<void> call() async => await authController.resendOtp();

      // assert
      await expectLater(call(), completes);
      verify(() => mockResendOtpUseCase(any())).called(1);
    });
  });
  group('performResetPassword', () {
    test('should call use case with correct params and return success', () async {
      // arrange
      when(() => mockResetPasswordUseCase(any())).thenAnswer((_) async => const Right(unit));

      // act
      await authController.resetPassword();

      // assert
      verify(() => mockResetPasswordUseCase(any())).called(1);
    });

    test('should throw a failure when use case return one', () async {
      // arrange
      const tFailure = ServerFailure(message: 'Server error');
      when(() => mockResetPasswordUseCase(any())).thenAnswer((_) async => const Left(tFailure));

      // act
      Future<void> call() async => await authController.resetPassword();

      // assert
      expect(call(), throwsA(isA<ServerFailure>()));
    });
  });

  group('performSignOut', () {
    test('should call use case and logout on success', () async {
      // arrange
      when(() => mockSignOutUseCase(NoParams())).thenAnswer((_) async => const Right(unit));

      // act
      await authController.performSignOut();

      // assert
      verify(() => mockSignOutUseCase(NoParams())).called(1);
      expect(container.read(authStatusProvider), const AuthState.unauthenticated());
    });

    test('should throw a failure when use case return one', () async {
      // arrange
      const tFailure = ServerFailure(message: 'Server error');
      when(() => mockSignOutUseCase(NoParams())).thenAnswer((_) async => const Left(tFailure));

      // act
      Future<void> call() async => await authController.performSignOut();

      // assert
      expect(call(), throwsA(isA<ServerFailure>()));
    });
  });
}
