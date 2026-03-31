import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'token_storage.g.dart';

class TokenStorage {
  static const _iosOptions = IOSOptions(accessibility: KeychainAccessibility.first_unlock);
  final FlutterSecureStorage _secureStorage;

  TokenStorage(this._secureStorage);

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _secureStorage.write(key: _accessTokenKey, value: accessToken, iOptions: _iosOptions);
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken, iOptions: _iosOptions);
  }

  Future<void> saveAccessToken(String accessToken) async {
    await _secureStorage.write(key: _accessTokenKey, value: accessToken, iOptions: _iosOptions);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken, iOptions: _iosOptions);
  }

  Future<String?> getAccessToken() =>
      _secureStorage.read(key: _accessTokenKey, iOptions: _iosOptions);
  Future<String?> getRefreshToken() =>
      _secureStorage.read(key: _refreshTokenKey, iOptions: _iosOptions);

  Future<void> clearTokens() async {
    await _secureStorage.delete(key: _accessTokenKey, iOptions: _iosOptions);
    await _secureStorage.delete(key: _refreshTokenKey, iOptions: _iosOptions);
  }
}

@riverpod
TokenStorage tokenStorage(Ref ref) {
  return TokenStorage(const FlutterSecureStorage());
}
