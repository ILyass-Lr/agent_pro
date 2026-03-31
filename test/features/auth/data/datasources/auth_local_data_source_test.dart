import 'dart:convert';

import 'package:agent_pro/core/error/exceptions.dart';
import 'package:agent_pro/core/storage/token_storage.dart';
import 'package:agent_pro/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:agent_pro/features/auth/data/models/agent_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class TokenStorageMock extends Mock implements TokenStorage {}

void main() {
  late MockSharedPreferences mocksharedPreferences;
  late TokenStorageMock mockTokenStorage;
  late AuthLocalDataSourceImpl dataSource;

  setUp(() {
    mocksharedPreferences = MockSharedPreferences();
    mockTokenStorage = TokenStorageMock();
    dataSource = AuthLocalDataSourceImpl(
      sharedPreferences: mocksharedPreferences,
      tokenStorage: mockTokenStorage,
    );
  });

  group('Token Management', () {
    test('saveTokens should call tokenStorage.saveTokens with correct parameters', () async {
      // arrange
      const tAccessToken = 'access_token_123';
      const tRefreshToken = 'refresh_token_456';
      when(() => mockTokenStorage.saveTokens(any(), any())).thenAnswer((_) async {});
      // act
      await dataSource.saveTokens(tAccessToken, tRefreshToken);
      // assert
      verify(() => mockTokenStorage.saveTokens(tAccessToken, tRefreshToken)).called(1);
    });
    test('clearTokens should call tokenStorage.clearTokens', () async {
      // arrange
      when(() => mockTokenStorage.clearTokens()).thenAnswer((_) async {});
      // act
      await dataSource.clearTokens();
      // assert
      verify(() => mockTokenStorage.clearTokens()).called(1);
    });
  });

  group('Agent Management', () {
    final tAgentModel = AgentModel.fromJson(jsonDecode(fixture('agent/valid.json')));
    test('getCachedAgent should return AgentModel when there is a cached agent', () async {
      // arrange
      final jsonString = fixture('agent/valid.json');
      when(() => mocksharedPreferences.getString(any())).thenReturn(jsonString);
      // act
      final result = await dataSource.getCachedAgent();
      // assert
      expect(result, equals(tAgentModel));
      verify(
        () => mocksharedPreferences.getString(AuthLocalDataSourceImpl.cachedAgentKey),
      ).called(1);
    });

    test('getCachedAgent should throw CacheException when there is no cached agent', () async {
      // arrange
      when(() => mocksharedPreferences.getString(any())).thenReturn(null);
      // act & assert
      expect(() => dataSource.getCachedAgent(), throwsA(isA<CacheException>()));
      verify(
        () => mocksharedPreferences.getString(AuthLocalDataSourceImpl.cachedAgentKey),
      ).called(1);
    });
    test('cacheAgent should cache the agent successfully', () async {
      // arrange
      when(() => mocksharedPreferences.setString(any(), any())).thenAnswer((_) async => true);
      // act
      dataSource.cacheAgent(tAgentModel);
      // assert
      final expectedJsonString = jsonEncode(tAgentModel.toJson());
      verify(
        () => mocksharedPreferences.setString(
          AuthLocalDataSourceImpl.cachedAgentKey,
          expectedJsonString,
        ),
      ).called(1);
    });
    test('clearCachedAgent should clear the cached agent successfully', () async {
      // arrange
      when(() => mocksharedPreferences.remove(any())).thenAnswer((_) async => true);
      // act
      await dataSource.clearCachedAgent();
      // assert
      verify(() => mocksharedPreferences.remove(AuthLocalDataSourceImpl.cachedAgentKey)).called(1);
    });
  });

  group('Remember Me Management', () {
    test('saveRememberedEmail should save the email to shared preferences', () async {
      // arrange
      const tEmail = 'test@example.com';
      when(() => mocksharedPreferences.setString(any(), any())).thenAnswer((_) async => true);
      // act
      await dataSource.saveRememberedEmail(tEmail);
      // assert
      verify(() => mocksharedPreferences.setString(AuthLocalDataSourceImpl.draftEmailKey, tEmail));
    });
    test('getRememberedEmail should return the remembered email from shared preferences', () async {
      // arrange
      const tEmail = 'test@example.com';
      when(() => mocksharedPreferences.getString(any())).thenReturn(tEmail);
      // act
      final result = dataSource.getRememberedEmail();
      // assert
      expect(result, equals(tEmail));
      verify(
        () => mocksharedPreferences.getString(AuthLocalDataSourceImpl.draftEmailKey),
      ).called(1);
    });
    test(
      'clearRememberedEmail should clear the remembered email from shared preferences',
      () async {
        // arrange
        when(() => mocksharedPreferences.remove(any())).thenAnswer((_) async => true);
        // act
        await dataSource.clearRememberedEmail();
        // assert
        verify(() => mocksharedPreferences.remove(AuthLocalDataSourceImpl.draftEmailKey)).called(1);
      },
    );
  });
}
