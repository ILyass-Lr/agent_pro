import 'dart:convert';

import 'package:agent_pro/core/error/exceptions.dart';
import 'package:agent_pro/core/error/failure.dart';
import 'package:agent_pro/core/types/sign_up_params.dart';
import 'package:agent_pro/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:agent_pro/features/auth/data/models/agent_model.dart';
import 'package:agent_pro/features/auth/data/models/auth_response.dart';
import 'package:agent_pro/features/auth/data/repositories/auth_repository_implementation.dart';
import 'package:agent_pro/features/auth/data/models/sign_up_request.dart';
import 'package:agent_pro/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:agent_pro/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:agent_pro/core/network/network_info.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockAuthRemoteDataSourceImpl extends Mock implements AuthRemoteDataSourceImpl {}

class MockAuthLocalDataSourceImpl extends Mock implements AuthLocalDataSourceImpl {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockAuthRemoteDataSourceImpl mockRemoteDataSource;
  late MockAuthLocalDataSourceImpl mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late ProviderContainer container;
  late AuthRepositoryImpl repository;

  late AgentModel tValidAgent;
  late AgentModel tInvalidAgent;
  late String tEmail;
  late String tOtp;
  late String tNewPassword;
  late String tConfirmPassword;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSourceImpl();
    mockLocalDataSource = MockAuthLocalDataSourceImpl();
    mockNetworkInfo = MockNetworkInfo();

    container = ProviderContainer(
      overrides: [
        authRemoteDataSourceProvider.overrideWithValue(mockRemoteDataSource),
        authLocalDataSourceProvider.overrideWithValue(mockLocalDataSource),
        networkInfoProvider.overrideWithValue(mockNetworkInfo),
      ],
    );

    repository = container.read(authRepositoryProvider) as AuthRepositoryImpl;

    when(() => mockLocalDataSource.clearCachedAgent()).thenAnswer((_) async => true);

    registerFallbackValue(
      SignUpRequest(
        firstName: '',
        lastName: '',
        email: '',
        phoneNumber: '',
        password: '',
        confirmPassword: '',
        agencyName: '',
        fifaLicense: '',
        licenseFilePath: '',
      ),
    );
    registerFallbackValue(
      AgentModel(
        id: BigInt.from(1),
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        phoneNumber: '+1234567890',
        agencyName: 'John Agency',
        fifaLicense: 'FIFA-2026',
        licenseFilePath: '/path/to/file.pdf',
        country: 'Morocco',
        city: 'Rabat',
      ),
    );
    registerFallbackValue((email: '', password: '', rememberMe: false));
  });
  setUpAll(() {
    tValidAgent = AgentModel.fromJson(jsonDecode(fixture('agent/valid.json')));
    tInvalidAgent = AgentModel.fromJson(jsonDecode(fixture('agent/invalid_email.json')));
    tEmail = 'joe.doe@gmail.com';
    tOtp = '123456';
    tNewPassword = 'newPassword123';
    tConfirmPassword = 'newPassword123';
  });

  tearDown(() {
    container.dispose();
  });

  group('signUp', () {
    const SignUpParams tSignUpParams = (
      personal: (
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        phoneNumber: '1234567890',
      ),
      security: (password: 'password123', confirmPassword: 'password123'),
      professional: (
        agencyName: 'Doe Agency',
        fifaLicense: 'FIFA12345',
        licenseFilePath: '/path/to/license.pdf',
      ),
    );
    test(
      'should check network connectivity before making remote call and return Right(unit) when successful',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.signUp(any())).thenAnswer((_) async => const Right(unit));

        // act
        final result = await repository.signUp(tSignUpParams);
        // assert
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(() => mockRemoteDataSource.signUp(any())).called(1);
        expect(result, const Right(unit));
      },
    );

    test('should return NetworkFailure when there is no network connectivity', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // act
      final result = await repository.signUp(tSignUpParams);

      // assert
      verify(() => mockNetworkInfo.isConnected).called(1);
      verifyNever(() => mockRemoteDataSource.signUp(any()));
      expect(result, const Left(NetworkFailure()));
    });
  });

  group('signIn', () {
    const tSignInParams = (
      email: 'john.doe@example.com',
      password: 'password123',
      rememberMe: false,
    );
    late AuthResponse tAuthResponse;

    setUp(() {
      tAuthResponse = AuthResponse(
        message: 'Sign in successful',
        agent: tValidAgent,
        tokens: const TokenModel(accessToken: 'accessToken', refreshToken: 'refreshToken'),
      );
    });
    test(
      'should check network connectivity before making remote call and return Right(agent) when successful',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          () => mockRemoteDataSource.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => tAuthResponse);
        when(() => mockLocalDataSource.clearTokens()).thenAnswer((_) async {});
        when(() => mockLocalDataSource.clearRememberedEmail()).thenAnswer((_) async {});
        when(() => mockLocalDataSource.cacheAgent(any())).thenAnswer((_) async => true);

        // act
        final result = await repository.signIn(
          email: tSignInParams.email,
          password: tSignInParams.password,
          rememberMe: tSignInParams.rememberMe,
        );
        // assert
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(
          () => mockRemoteDataSource.signIn(
            email: tSignInParams.email,
            password: tSignInParams.password,
          ),
        ).called(1);
        verify(() => mockLocalDataSource.cacheAgent(any())).called(1);
        expect(result.isRight(), isTrue);
        final agent = result.getOrElse((_) => throw StateError('Expected Right(agent)'));
        expect(agent.email.value, tValidAgent.email);
      },
    );

    test('should clear tokens and remembered email from local data source on sign in', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        () => mockRemoteDataSource.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => tAuthResponse);
      when(() => mockLocalDataSource.clearTokens()).thenAnswer((_) async {});
      when(() => mockLocalDataSource.clearRememberedEmail()).thenAnswer((_) async {});
      when(() => mockLocalDataSource.cacheAgent(any())).thenAnswer((_) async => true);

      // act
      final result = await repository.signIn(
        email: tValidAgent.email,
        password: "password123",
        rememberMe: false,
      );

      // assert
      expect(result.isRight(), isTrue);
      final agent = result.getOrElse((_) => throw StateError('Expected Right(agent)'));
      expect(agent.email.value, tValidAgent.email);
      verify(() => mockLocalDataSource.clearTokens()).called(1);
      verify(() => mockLocalDataSource.clearRememberedEmail()).called(1);
    });

    test('should save tokens to local data source when Remember Me is enabled', () async {
      // arrange
      const tAccessToken = 'accessToken';
      const tRefreshToken = 'refreshToken';
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        () => mockRemoteDataSource.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => tAuthResponse);
      when(() => mockLocalDataSource.saveTokens(any(), any())).thenAnswer((_) async {});
      when(() => mockLocalDataSource.saveRememberedEmail(any())).thenAnswer((_) async {});
      when(() => mockLocalDataSource.cacheAgent(any())).thenAnswer((_) async => true);

      // act
      final result = await repository.signIn(
        email: tValidAgent.email,
        password: "password123",
        rememberMe: true,
      );

      // assert
      expect(result.isRight(), isTrue);
      final agent = result.getOrElse((_) => throw StateError('Expected Right(agent)'));
      expect(agent.email.value, tValidAgent.email);
      verify(() => mockLocalDataSource.saveTokens(tAccessToken, tRefreshToken)).called(1);
    });

    test('should return NetworkFailure when there is no network connectivity', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // act
      final result = await repository.signIn(
        email: tSignInParams.email,
        password: tSignInParams.password,
        rememberMe: tSignInParams.rememberMe,
      );

      // assert
      verify(() => mockNetworkInfo.isConnected).called(1);
      verifyNever(
        () => mockRemoteDataSource.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      );
      expect(result, const Left(NetworkFailure()));
    });
  });

  group('signOut', () {
    test(
      'should clear tokens and remembered email from local data source and return Right(unit)',
      () async {
        // arrange
        when(() => mockLocalDataSource.clearTokens()).thenAnswer((_) async {});
        when(() => mockLocalDataSource.clearRememberedEmail()).thenAnswer((_) async {});

        // act
        final result = await repository.signOut();

        // assert
        verify(() => mockLocalDataSource.clearTokens()).called(1);
        verify(() => mockLocalDataSource.clearRememberedEmail()).called(1);
        expect(result, const Right(unit));
      },
    );
    test('should return Left(CacheFailure) when an exception occurs during sign out', () async {
      // arrange
      when(
        () => mockLocalDataSource.clearTokens(),
      ).thenThrow(PlatformException(code: 'clear_tokens_error'));

      // act
      final result = await repository.signOut();

      // assert
      verify(() => mockLocalDataSource.clearTokens()).called(1);
      verifyNever(() => mockLocalDataSource.clearRememberedEmail());
      expect(result.isLeft(), isTrue);
      final failure = result.getLeft().toNullable();
      expect(failure, isA<CacheFailure>());
      expect((failure as CacheFailure).message, contains("Failed to sign out"));
    });
  });
  group('getCurrentAgent', () {
    test('should return agent from remote data source when connected to network', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.getAgentDetails()).thenAnswer((_) async => tValidAgent);

      // act
      final result = await repository.getCurrentAgent();
      // assert
      verify(() => mockNetworkInfo.isConnected).called(1);
      verify(() => mockRemoteDataSource.getAgentDetails()).called(1);
      expect(result.isRight(), isTrue);
      final agent = result.getOrElse((_) => throw StateError('Expected Right(agent)'));
      expect(agent.email.value, tValidAgent.email);
    });

    test('should return ServerFailure when remote data source throws ServerException', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        () => mockRemoteDataSource.getAgentDetails(),
      ).thenThrow(ServerException(message: "Server error"));

      // act
      final result = await repository.getCurrentAgent();

      // assert
      verify(() => mockNetworkInfo.isConnected).called(1);
      verify(() => mockRemoteDataSource.getAgentDetails()).called(1);
      expect(result.isLeft(), isTrue);
      expect(result.getLeft().toNullable(), isA<ServerFailure>());
    });

    test('should throw ServerFailure when incoming data is invalid', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.getAgentDetails()).thenAnswer((_) async => tInvalidAgent);

      // act
      final result = await repository.getCurrentAgent();

      // assert
      verify(() => mockNetworkInfo.isConnected).called(1);
      verify(() => mockRemoteDataSource.getAgentDetails()).called(1);
      expect(result.isLeft(), isTrue);
      final failure = result.getLeft().toNullable();
      expect(failure, isA<ServerFailure>());
      expect((failure as ServerFailure).message, contains("Server Data error"));
    });

    test(
      'should return agent from local data source when not connected to network and fromServerOnly is false',
      () async {
        // arrange
        final tAgent = AgentModel.fromJson(jsonDecode(fixture('agent/valid.json')));
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(() => mockLocalDataSource.getCachedAgent()).thenAnswer((_) async => tAgent);

        // act
        final result = await repository.getCurrentAgent(fromServerOnly: false);

        // assert
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(() => mockLocalDataSource.getCachedAgent()).called(1);
        expect(result.isRight(), isTrue);
        final agent = result.getOrElse((_) => throw StateError('Expected Right(agent)'));
        expect(agent.email.value, tAgent.email);
      },
    );

    test('should return CacheFailure when local data source returns invalid data', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(() => mockLocalDataSource.getCachedAgent()).thenAnswer((_) async => tInvalidAgent);

      // act
      final result = await repository.getCurrentAgent(fromServerOnly: false);

      // assert
      verify(() => mockNetworkInfo.isConnected).called(1);
      verify(() => mockLocalDataSource.getCachedAgent()).called(1);
      verify(
        () => mockLocalDataSource.clearCachedAgent(),
      ).called(1); // Verify cache clearing on error
      expect(result.isLeft(), isTrue);
      final failure = result.getLeft().toNullable();
      expect(failure, isA<CacheFailure>());
      expect((failure as CacheFailure).message, contains("Cached Data error"));
    });

    test(
      'should returns CacheFailure when not connected to network and fromServerOnly is false but no cached agent found',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(() => mockLocalDataSource.getCachedAgent()).thenAnswer((_) async => null);

        // act
        final result = await repository.getCurrentAgent(fromServerOnly: false);

        // assert
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(() => mockLocalDataSource.getCachedAgent()).called(1);
        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<CacheFailure>());
        expect((failure as CacheFailure).message, contains("No cached agent found"));
      },
    );

    test(
      'should returns CacheFailure when not connected to network and fromServerOnly is false but an unexpected error occurs',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(() => mockLocalDataSource.getCachedAgent()).thenThrow(Exception("Unexpected error"));

        // act
        final result = await repository.getCurrentAgent(fromServerOnly: false);

        // assert
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(() => mockLocalDataSource.getCachedAgent()).called(1);
        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<CacheFailure>());
        expect((failure as CacheFailure).message, contains("An unexpected error occurred"));
      },
    );

    test(
      'should return NetworkFailure when not connected to network and fromServerOnly is true',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        // act
        final result = await repository.getCurrentAgent(fromServerOnly: true);

        // assert
        verify(() => mockNetworkInfo.isConnected).called(1);
        verifyNever(() => mockLocalDataSource.getCachedAgent());
        expect(result, const Left(NetworkFailure()));
      },
    );
  });

  group('sendPasswordResetEmail', () {
    test('should return Right(unit) when password reset email is sent successfully', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.sendPasswordResetEmail(any())).thenAnswer((_) async {});
      // act
      final result = await repository.sendPasswordResetEmail(tEmail);
      // assert
      verify(() => mockNetworkInfo.isConnected).called(1);
      verify(() => mockRemoteDataSource.sendPasswordResetEmail(tEmail)).called(1);
      expect(result, const Right(unit));
    });
    test('should return Left<NetworkFailure>() when not connected to network', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final result = await repository.sendPasswordResetEmail(tEmail);
      // assert
      verify(() => mockNetworkInfo.isConnected).called(1);
      expect(result, const Left(NetworkFailure()));
    });

    test(
      'should return Left<ServerFailure>() when remote data source throws ServerException',
      () async {
        // arrange
        const errorMessage = "Failed to send password reset email.";
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          () => mockRemoteDataSource.sendPasswordResetEmail(any()),
        ).thenThrow(ServerException(message: errorMessage));
        // act
        final result = await repository.sendPasswordResetEmail(tEmail);
        // assert
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(() => mockRemoteDataSource.sendPasswordResetEmail(tEmail)).called(1);
        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<ServerFailure>());
        expect((failure as ServerFailure).message, errorMessage);
      },
    );
  });

  group('verifyResetCode', () {
    test('should return Right(unit) when OTP reset code is verified successfully', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.verifyResetCode(any(), any())).thenAnswer((_) async => true);
      // act
      final result = await repository.verifyResetCode(tEmail, tOtp);
      // assert
      verify(() => mockNetworkInfo.isConnected).called(1);
      verify(() => mockRemoteDataSource.verifyResetCode(tEmail, tOtp)).called(1);
      expect(result, const Right(unit));
    });
    test(
      'should return Left<ServerFailure>() when OTP reset code is unverified successfully',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          () => mockRemoteDataSource.verifyResetCode(any(), any()),
        ).thenAnswer((_) async => false);
        // act
        final result = await repository.verifyResetCode(tEmail, tOtp);
        // assert
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(() => mockRemoteDataSource.verifyResetCode(tEmail, tOtp)).called(1);
        expect(result, const Left(ServerFailure(message: "Invalid OTP reset code.")));
      },
    );
    test('should return Left<NetworkFailure>() when not connected to network', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final result = await repository.verifyResetCode(tEmail, tOtp);
      // assert
      verify(() => mockNetworkInfo.isConnected).called(1);
      expect(result, const Left(NetworkFailure()));
    });

    test(
      'should return Left<ServerFailure>() when remote data source throws ServerException',
      () async {
        // arrange
        const errorMessage = "Failed to verify reset code.";
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          () => mockRemoteDataSource.verifyResetCode(any(), any()),
        ).thenThrow(ServerException(message: errorMessage));
        // act
        final result = await repository.verifyResetCode(tEmail, tOtp);
        // assert
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(() => mockRemoteDataSource.verifyResetCode(tEmail, tOtp)).called(1);
        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<ServerFailure>());
        expect((failure as ServerFailure).message, errorMessage);
      },
    );
  });

  group('resendOtp', () {
    test('should return Right(unit) when OTP is resent successfully', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.resendOtp(any())).thenAnswer((_) async => 60);
      // act
      final result = await repository.resendOtp(tEmail);
      // assert
      verify(() => mockNetworkInfo.isConnected).called(1);
      verify(() => mockRemoteDataSource.resendOtp(tEmail)).called(1);
      expect(result, const Right(unit));
    });
    test('should return Left<NetworkFailure>() when not connected to network', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act

      final result = await repository.resendOtp(tEmail);
      // assert
      verify(() => mockNetworkInfo.isConnected).called(1);
      expect(result, const Left(NetworkFailure()));
    });

    test(
      'should return Left<RateLimitFailure>() when resend OTP is requested before cooldown ends',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        repository.setNextAllowedResendForTest(DateTime.now().add(const Duration(seconds: 30)));

        // act
        final result = await repository.resendOtp(tEmail);

        // assert
        verify(() => mockNetworkInfo.isConnected).called(1);
        verifyNever(() => mockRemoteDataSource.resendOtp(any()));
        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<RateLimitFailure>());
      },
    );

    test(
      'should return Left<ServerFailure>() when remote data source throws ServerException',
      () async {
        // arrange
        const errorMessage = "Failed to resend OTP.";
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          () => mockRemoteDataSource.resendOtp(any()),
        ).thenThrow(ServerException(message: errorMessage));
        // act
        final result = await repository.resendOtp(tEmail);
        // assert
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(() => mockRemoteDataSource.resendOtp(tEmail)).called(1);
        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<ServerFailure>());
        expect((failure as ServerFailure).message, errorMessage);
      },
    );

    test(
      'should return Left<ServerFailure>() with cooldown message when resend OTP is requested during cooldown',
      () async {
        // arrange
        const errorMessage = "Please wait 30 seconds before requesting a new OTP.";
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          () => mockRemoteDataSource.resendOtp(any()),
        ).thenThrow(ServerException(message: errorMessage, coolDownSeconds: 30));
        // act
        final result = await repository.resendOtp(tEmail);
        // assert
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(() => mockRemoteDataSource.resendOtp(tEmail)).called(1);
        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<RateLimitFailure>());
        expect((failure as RateLimitFailure).message, errorMessage);
      },
    );
  });

  group('resetPassword', () {
    test('should return Right(unit) when password is reset successfully', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        () => mockRemoteDataSource.resetPassword(any(), any(), any(), any()),
      ).thenAnswer((_) async {});
      // act
      final result = await repository.resetPassword(tEmail, tOtp, tNewPassword, tConfirmPassword);
      // assert
      verify(() => mockNetworkInfo.isConnected).called(1);
      verify(
        () => mockRemoteDataSource.resetPassword(tEmail, tOtp, tNewPassword, tConfirmPassword),
      ).called(1);
      expect(result, const Right(unit));
    });

    test('should return Left<NetworkFailure>() when not connected to network', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final result = await repository.resetPassword(tEmail, tOtp, tNewPassword, tConfirmPassword);
      // assert
      verify(() => mockNetworkInfo.isConnected).called(1);
      expect(result, const Left(NetworkFailure()));
    });

    test(
      'should return Left<ServerFailure>() when remote data source throws ServerException',
      () async {
        // arrange
        const errorMessage = "Failed to reset password.";
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          () => mockRemoteDataSource.resetPassword(any(), any(), any(), any()),
        ).thenThrow(ServerException(message: errorMessage));
        // act
        final result = await repository.resetPassword(tEmail, tOtp, tNewPassword, tConfirmPassword);
        // assert
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(
          () => mockRemoteDataSource.resetPassword(tEmail, tOtp, tNewPassword, tConfirmPassword),
        ).called(1);
        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<ServerFailure>());
        expect((failure as ServerFailure).message, errorMessage);
      },
    );
  });
}
