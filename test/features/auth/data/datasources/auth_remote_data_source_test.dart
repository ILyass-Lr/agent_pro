import 'dart:io';

import 'package:agent_pro/core/error/exceptions.dart';
import 'package:agent_pro/core/storage/token_storage.dart';
import 'package:agent_pro/core/types/agent_status.dart';
import 'package:agent_pro/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:agent_pro/features/auth/data/models/agent_model.dart';
import 'package:agent_pro/features/auth/data/models/auth_response.dart';
import 'package:agent_pro/features/auth/data/models/sign_up_request.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockRefreshDio extends Mock implements Dio {}

class MockTokenStorage extends Mock implements TokenStorage {}

void main() {
  late MockDio mockDio;
  late MockRefreshDio mockRefreshDio;
  late MockTokenStorage mockTokenStorage;
  late AuthRemoteDataSourceImpl dataSource;
  late File tempFile;
  late SignUpRequest tSignUpRequest;

  setUp(() async {
    mockDio = MockDio();
    mockRefreshDio = MockRefreshDio();
    mockTokenStorage = MockTokenStorage();
    dataSource = AuthRemoteDataSourceImpl(
      client: mockDio,
      refreshDio: mockRefreshDio,
      tokenStorage: mockTokenStorage,
    );
    final tempDir = await Directory.systemTemp.createTemp('agent_test_');
    tempFile = File('${tempDir.path}/temp_license.pdf');
    await tempFile.writeAsBytes([0, 1, 2, 3, 4]); // Create a dummy file
    tSignUpRequest = SignUpRequest(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      phoneNumber: '1234567890',
      password: 'password123',
      confirmPassword: 'password123',
      agencyName: 'Doe Agency',
      fifaLicense: 'FIFA12345',
      licenseFilePath: tempFile.path,
    );
  });

  tearDownAll(() async {
    if (await tempFile.exists()) {
      await tempFile.delete();
    }
  });

  // Authentication
  group('AuthRemoteDataSource - signUp', () {
    test('should perform a POST request to the correct endpoint with form data', () async {
      // arrange
      when(
        () => mockDio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/accounts/agents/register/'),
          statusCode: 201,
        ),
      );
      // act
      await dataSource.signUp(tSignUpRequest);
      // assert
      verify(
        () => mockDio.post(
          '/accounts/agents/register/',
          data: any(named: 'data', that: predicate((data) => data is FormData)),
          options: any(
            named: 'options',
            that: predicate<Options>((options) => options.contentType == 'multipart/form-data'),
          ),
        ),
      ).called(1);
    });

    test('should throw ServerException when response status code is not 201', () async {
      // arrange
      when(
        () => mockDio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/accounts/agents/register/'),
          response: Response(
            requestOptions: RequestOptions(path: '/accounts/agents/register/'),
            statusCode: 400,
          ),
        ),
      );
      // act
      final call = dataSource.signUp(tSignUpRequest);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('AuthRemoteDataSource - signIn', () {
    final tAuthResponse = AuthResponse(
      agent: AgentModel(
        id: BigInt.from(1),
        email: 'test@example.com',
        firstName: 'Test',
        lastName: 'User',
        phoneNumber: '1234567890',
        agencyName: 'Test Agency',
        fifaLicense: 'FIFA12345',
        licenseFilePath: '/path/to/license.pdf',
        country: 'Testland',
        city: 'Testville',
      ),
      tokens: const TokenModel(accessToken: 'access_toke_123', refreshToken: 'refresh_token_456'),
      message: 'Sign in successful',
    );

    test('should throw ServerException when response status code is 201', () async {
      // arrange
      when(
        () => mockDio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/accounts/auth/login/'),
          statusCode: 201,
        ),
      );
      // act & assert
      expect(
        () => dataSource.signIn(email: 'test@example.com', password: 'password123'),
        throwsA(isA<ServerException>()),
      );
    });

    test('should throw a ServerException when response status code is not 200', () async {
      // arrange
      when(
        () => mockDio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/accounts/auth/login/'),
          statusCode: 400,
        ),
      );
      // act & assert
      expect(
        () => dataSource.signIn(email: 'test@example.com', password: 'password123'),
        throwsA(isA<ServerException>()),
      );
    });

    test(
      "should throw a ServerException when response status is 403 and doesn't contain error details",
      () async {
        // arrange
        when(
          () => mockDio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/accounts/auth/login/'),
            statusCode: 403,
          ),
        );
        // act & assert
        expect(
          () => dataSource.signIn(email: 'test@example.com', password: 'password123'),
          throwsA(isA<ServerException>()),
        );
      },
    );

    test(
      'should throw an AgentStatusException when response status code is 403 and contains agent status details',
      () async {
        // arrange
        when(
          () => mockDio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/accounts/auth/login/'),
            response: Response(
              requestOptions: RequestOptions(path: '/accounts/auth/login/'),
              statusCode: 403,
              data: {
                'error': 'Your account is pending approval by the administrator.',
                'reason': 'pending_approval',
                'status': 'pending',
              },
            ),
          ),
        );
        // act & assert
        expect(
          () => dataSource.signIn(email: 'test@example.com', password: 'password123'),
          throwsA(
            isA<AgentStatusException>()
                .having((e) => e.message, 'error description', contains('pending approval'))
                .having((e) => e.status, 'current status', equals(Status.pending)),
          ),
        );
      },
    );

    test('should throw server exception when a network error occurs', () async {
      // arrange
      when(
        () => mockDio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: '/accounts/auth/login/')));
      // act & assert
      expect(
        () => dataSource.signIn(email: 'test@example.com', password: 'password123'),
        throwsA(
          isA<ServerException>().having(
            (e) => e.message,
            'error description',
            equals('Network error. Please try again.'),
          ),
        ),
      );
    });

    test('should return AuthResponse when signIn is successful', () async {
      // arrange
      when(
        () => mockDio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/accounts/auth/login/'),
          statusCode: 200,
          data: {
            'message': tAuthResponse.message,
            'user': tAuthResponse.agent.toJson(),
            'tokens': {
              'access': tAuthResponse.tokens.accessToken,
              'refresh': tAuthResponse.tokens.refreshToken,
            },
          },
        ),
      );
      // act
      final result = await dataSource.signIn(
        email: tAuthResponse.agent.email,
        password: 'password123',
      );
      // assert
      expect(result, equals(tAuthResponse));
    });
  });

  // Profile
  group('AuthRemoteDataSource - getAgentDetails', () {
    final tAgentModel = AgentModel(
      id: BigInt.from(1),
      email: 'test@example.com',
      firstName: 'John',
      lastName: 'Doe',
      phoneNumber: '1234567890',
      status: Status.pending,
      agencyName: 'Doe Agency',
      fifaLicense: 'FIFA12345',
      licenseFilePath: '/path/to/license.pdf',
      country: 'Testland',
      city: 'Testville',
    );
    test('should throw ServerException when response status code is not 200', () async {
      // arrange
      when(() => mockDio.get(any(), options: any(named: 'options'))).thenAnswer(
        (_) async =>
            Response(requestOptions: RequestOptions(path: '/accounts/agents/me/'), statusCode: 400),
      );
      // act & assert
      expect(
        () => dataSource.getAgentDetails(),
        throwsA(
          isA<ServerException>().having(
            (e) => e.message,
            'error description',
            equals("Failed to fetch agent details."),
          ),
        ),
      );
    });

    test('should return AgentModel when request is successful', () async {
      // arrange
      when(() => mockDio.get(any(), options: any(named: 'options'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/accounts/agents/me/'),
          statusCode: 200,
          data: tAgentModel.toJson(),
        ),
      );
      // act
      final result = await dataSource.getAgentDetails();
      // assert
      expect(result, equals(tAgentModel));
    });
  });

  // Token Refresh
  group('TokenRefresher - refreshAccessToken', () {
    const tRefreshToken = 'valid_refresh_token';
    test('should return new access token when refresh token is valid', () async {
      // arrange
      const tnewAccessToken = 'new_access_token_123';
      when(() => mockTokenStorage.getRefreshToken()).thenAnswer((_) async => tRefreshToken);
      when(() => mockTokenStorage.saveAccessToken(any())).thenAnswer((_) async {});
      when(() => mockRefreshDio.post(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/accounts/auth/refresh/'),
          statusCode: 200,
          data: {
            'message': 'Token refreshed successfully',
            'tokens': {'access': tnewAccessToken},
          },
        ),
      );
      // act
      final result = await dataSource.refreshAccessToken();
      // assert
      expect(result, tnewAccessToken);
      verify(() => mockTokenStorage.getRefreshToken()).called(1);
      verify(
        () => mockRefreshDio.post(
          any(),
          data: any(
            named: 'data',
            that: predicate((data) {
              if (data case {'refresh': tRefreshToken}) {
                return true;
              }
              return false;
            }),
          ),
        ),
      ).called(1);
      verify(() => mockTokenStorage.saveAccessToken(tnewAccessToken)).called(1);
    });

    test('should return null when refresh token is null', () async {
      // arrange
      when(() => mockTokenStorage.getRefreshToken()).thenAnswer((_) async => null);
      // act
      final result = await dataSource.refreshAccessToken();
      // assert
      expect(result, isNull);
      verify(() => mockTokenStorage.getRefreshToken()).called(1);
    });

    test('should return null when refresh request fails', () async {
      // arrange
      when(() => mockTokenStorage.getRefreshToken()).thenAnswer((_) async => tRefreshToken);
      when(() => mockRefreshDio.post(any(), data: any(named: 'data'))).thenThrow(Exception());
      // act
      final result = await dataSource.refreshAccessToken();
      // assert
      expect(result, isNull);
      verify(() => mockTokenStorage.getRefreshToken()).called(1);
      verify(() => mockRefreshDio.post(any(), data: any(named: 'data'))).called(1);
    });
  });

  // Forgot Password
  group('AuthRemoteDataSource - sendPasswordResetEmail', () {
    const tEmail = 'test@example.com';
    test('should complete without error when request is successful', () async {
      // arrange
      when(
        () => mockDio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/accounts/auth/forgot-password/'),
          statusCode: 200,
        ),
      );
      // act
      await dataSource.sendPasswordResetEmail(tEmail);
      // assert
      verify(
        () => mockDio.post(
          '/accounts/auth/forgot-password/',
          data: {'email': tEmail},
          options: any(
            named: 'options',
            that: predicate<Options>((options) => options.extra?['requireAuth'] == false),
          ),
        ),
      ).called(1);
    });

    test(
      'should throw ServerException with error message from response when request fails',
      () async {
        // arrange
        const tErrorMessage = 'Email not found';
        when(
          () => mockDio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/accounts/auth/forgot-password/'),
            response: Response(
              requestOptions: RequestOptions(path: '/accounts/auth/forgot-password/'),
              statusCode: 400,
              data: {'error': tErrorMessage},
            ),
          ),
        );
        // act & assert
        expect(
          () => dataSource.sendPasswordResetEmail(tEmail),
          throwsA(
            isA<ServerException>().having(
              (e) => e.message,
              'error description',
              equals(tErrorMessage),
            ),
          ),
        );
      },
    );

    test('should throw ServerException with generic message when network error occurs', () async {
      // arrange
      when(
        () => mockDio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/accounts/auth/forgot-password/')),
      );
      // act & assert
      expect(
        () => dataSource.sendPasswordResetEmail(tEmail),
        throwsA(
          isA<ServerException>().having(
            (e) => e.message,
            'error description',
            equals('Network error. Please try again.'),
          ),
        ),
      );
    });
  });

  group('AuthRemoteDataSource - verifyResetCode', () {
    const tEmail = 'test@example.com';
    const tCode = '123456';
    test('should return true and save refresh token when verification is successful', () async {
      // arrange
      const tRefreshToken = 'valid_refresh_token';
      when(
        () => mockDio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/accounts/auth/verify-otp/'),
          statusCode: 200,
          data: {'reset_token': tRefreshToken},
        ),
      );
      when(() => mockTokenStorage.saveRefreshToken(any())).thenAnswer((_) async {});
    });

    test("should return false when response doesn't have required fields", () async {
      // arrange
      when(
        () => mockDio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/accounts/auth/verify-otp/'),
          statusCode: 200,
        ),
      );
      // act
      final result = await dataSource.verifyResetCode(tEmail, tCode);
      // assert
      expect(result, isFalse);
      verifyNever(() => mockTokenStorage.saveRefreshToken(any()));
    });

    test('returns false when a network error occurs', () async {
      // arrange
      when(
        () => mockDio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: '/accounts/auth/verify-otp/')));
      // act
      final result = await dataSource.verifyResetCode(tEmail, tCode);
      // assert
      expect(result, isFalse);
    });
  });

  group('AuthRemoteDataSource - resetPassword', () {
    const tEmail = 'test@example.com';
    const tResetToken = 'valid_reset_token';
    const tNewPassword = 'new_password';
    const tConfirmPassword = 'new_password';
    test('should complete without error when request is successful', () async {
      // arrange
      when(
        () => mockDio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/accounts/auth/reset-password/'),
          statusCode: 200,
        ),
      );
      // act
      await dataSource.resetPassword(tEmail, tResetToken, tNewPassword, tConfirmPassword);
      // assert
      verify(
        () => mockDio.post(
          '/accounts/auth/reset-password/',
          data: {
            'email': tEmail,
            'otp': tResetToken,
            'new_password': tNewPassword,
            'confirm_password': tConfirmPassword,
          },
          options: any(
            named: 'options',
            that: predicate<Options>((options) => options.extra?['requireAuth'] == false),
          ),
        ),
      ).called(1);
    });

    test(
      'should throw ServerException with error message from response when request fails',
      () async {
        // arrange
        const tErrorMessage = 'Invalid reset token';
        when(
          () => mockDio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/accounts/auth/reset-password/'),
            response: Response(
              requestOptions: RequestOptions(path: '/accounts/auth/reset-password/'),
              statusCode: 400,
              data: {'error': tErrorMessage},
            ),
          ),
        );
        // act & assert
        expect(
          () => dataSource.resetPassword(tEmail, tResetToken, tNewPassword, tConfirmPassword),
          throwsA(
            isA<ServerException>().having(
              (e) => e.message,
              'error description',
              equals(tErrorMessage),
            ),
          ),
        );
      },
    );
  });

  group('AuthRemoteDataSource - resendOtp', () {
    const tEmail = 'test@example.com';
    test('should complete without error when request is successful', () async {
      // arrange
      when(
        () => mockDio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/accounts/auth/resend-otp/'),
          statusCode: 200,
        ),
      );
      // act
      await dataSource.resendOtp(tEmail);
      // assert
      verify(
        () => mockDio.post(
          '/accounts/auth/resend-otp/',
          data: {'email': tEmail},
          options: any(
            named: 'options',
            that: predicate<Options>((options) => options.extra?['requireAuth'] == false),
          ),
        ),
      ).called(1);
    });
    test(
      'should throw ServerException with error message from response when request fails',
      () async {
        // arrange
        const tErrorMessage = 'Email not found';
        when(
          () => mockDio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/accounts/auth/resend-otp/'),
            response: Response(
              requestOptions: RequestOptions(path: '/accounts/auth/resend-otp/'),
              statusCode: 400,
              data: {'error': tErrorMessage},
            ),
          ),
        );
        // act & assert
        expect(
          () => dataSource.resendOtp(tEmail),
          throwsA(
            isA<ServerException>().having(
              (e) => e.message,
              'error description',
              equals(tErrorMessage),
            ),
          ),
        );
      },
    );
    test(
      'should throw ServerException with cooldown seconds when request fails due to rate limiting',
      () async {
        // arrange
        const tCooldownSeconds = 60;
        when(
          () => mockDio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/accounts/auth/resend-otp/'),
            response: Response(
              requestOptions: RequestOptions(path: '/accounts/auth/resend-otp/'),
              statusCode: 429,
              data: {
                'error': 'Too many requests. Please try again later.',
                'cooldown': tCooldownSeconds,
              },
            ),
          ),
        );
        // act & assert
        expect(
          () => dataSource.resendOtp(tEmail),
          throwsA(
            isA<ServerException>().having(
              (e) => e.coolDownSeconds,
              'error description',
              equals(tCooldownSeconds),
            ),
          ),
        );
      },
    );
    test(
      'should throw ServerException with cooldwn seconds when Retry-Again header is set',
      () async {
        // arrange
        const tCooldownSeconds = 120;
        when(
          () => mockDio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/accounts/auth/resend-otp/'),
            response: Response(
              requestOptions: RequestOptions(path: '/accounts/auth/resend-otp/'),
              statusCode: 429,
              headers: Headers.fromMap({
                'Retry-After': [tCooldownSeconds.toString()],
              }),
              data: {'error': 'Too many requests. Please try again later.'},
            ),
          ),
        );
        // act & assert
        expect(
          () => dataSource.resendOtp(tEmail),
          throwsA(
            isA<ServerException>().having(
              (e) => e.coolDownSeconds,
              'error description',
              equals(tCooldownSeconds),
            ),
          ),
        );
      },
    );
  });
}
