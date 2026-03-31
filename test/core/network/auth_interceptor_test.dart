import 'package:agent_pro/core/network/auth_interceptor.dart';
import 'package:agent_pro/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agent_pro/core/storage/token_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';

class MockAuthRemoteDataSourceImpl extends Mock implements AuthRemoteDataSourceImpl {}

class MockTokenStorage extends Mock implements TokenStorage {}

class MockDio extends Mock implements Dio {}

class MockRequestInterceptorHandler extends Mock implements RequestInterceptorHandler {}

class MockErrorInterceptorHandler extends Mock implements ErrorInterceptorHandler {}

void main() {
  late AuthInterceptor authInterceptor;
  late MockAuthRemoteDataSourceImpl mockDataSource;
  late MockTokenStorage mockTokenStorage;
  late MockDio mockMainDio;
  late MockRequestInterceptorHandler mockHandler;
  late MockErrorInterceptorHandler mockErrorHandler;
  late ProviderContainer container;

  setUp(() {
    mockDataSource = MockAuthRemoteDataSourceImpl();
    mockTokenStorage = MockTokenStorage();
    mockMainDio = MockDio();
    mockHandler = MockRequestInterceptorHandler();
    mockErrorHandler = MockErrorInterceptorHandler();
    container = ProviderContainer(
      overrides: [tokenRefresherProvider.overrideWithValue(mockDataSource)],
    );
    authInterceptor = AuthInterceptor(
      read: container.read,
      tokenStorage: mockTokenStorage,
      dio: mockMainDio,
      onLogout: () {},
    );

    registerFallbackValue(RequestOptions(path: '/test'));
  });

  group('AuthInterceptor', () {
    test('onRequest adds Authorization header when access token is available', () async {
      // arrange
      const tToken = 'valid_token_123';
      when(() => mockTokenStorage.getAccessToken()).thenAnswer((_) async => tToken);
      final options = RequestOptions(path: '/test');

      // act
      await authInterceptor.onRequest(options, mockHandler);

      // assert
      expect(options.headers['Authorization'], 'Bearer $tToken');
      verify(() => mockHandler.next(options)).called(1);
    });
    test('onRequest does not add Authorization header when access token is null', () async {
      // arrange
      when(() => mockTokenStorage.getAccessToken()).thenAnswer((_) async => null);
      final options = RequestOptions(path: '/test');

      // act
      await authInterceptor.onRequest(options, mockHandler);

      // assert
      expect(options.headers['Authorization'], isNull);
      verify(() => mockHandler.next(options)).called(1);
    });

    test('should retry request when 401 occurs and refreshAccessToken succeeds', () async {
      // arrange
      const tNewToken = 'new_access_token';
      final requestOptions = RequestOptions(path: '/protected');
      final dioError = DioException(
        requestOptions: requestOptions,
        response: Response(statusCode: 401, requestOptions: requestOptions),
      );
      final tResponse = Response(
        requestOptions: requestOptions,
        statusCode: 200,
        data: {
          'message': 'Token rafraîchi',
          'tokens': {'access': tNewToken},
        },
      );

      when(() => mockDataSource.refreshAccessToken()).thenAnswer((_) async => tNewToken);
      when(() => mockMainDio.fetch(any())).thenAnswer((_) async => tResponse);

      // act
      await authInterceptor.onError(dioError, mockErrorHandler);

      // assert
      expect(requestOptions.headers['Authorization'], 'Bearer $tNewToken');
      verify(() => mockDataSource.refreshAccessToken()).called(1);
      verify(() => mockMainDio.fetch(any())).called(1);
      verify(() => mockErrorHandler.resolve(tResponse)).called(1);
    });

    test('should logout and fail when refreshAccessToken fails', () async {
      // arrange
      bool logoutCalled = false;
      authInterceptor = AuthInterceptor(
        read: container.read,
        tokenStorage: mockTokenStorage,
        dio: mockMainDio,
        onLogout: () => logoutCalled = true,
      );
      final requestOptions = RequestOptions(path: '/protected');
      final dioError = DioException(
        requestOptions: requestOptions,
        response: Response(statusCode: 401, requestOptions: requestOptions),
      );

      when(() => mockDataSource.refreshAccessToken()).thenAnswer((_) async => null);
      when(() => mockTokenStorage.clearTokens()).thenAnswer((_) async {});

      // act
      await authInterceptor.onError(dioError, mockErrorHandler);

      // assert
      verify(() => mockDataSource.refreshAccessToken()).called(1);
      verify(() => mockTokenStorage.clearTokens()).called(1);
      verify(() => mockErrorHandler.next(dioError)).called(1);
      expect(logoutCalled, isTrue);
    });
  });
}
