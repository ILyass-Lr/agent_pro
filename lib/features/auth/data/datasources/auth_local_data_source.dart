import 'dart:convert';

import 'package:agent_pro/core/storage/token_storage.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/storage/shared_preferences.dart';
import '../models/agent_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_local_data_source.g.dart';

abstract interface class AuthLocalDataSource {
  // Token Management
  Future<void> saveTokens(String accessToken, String refreshToken);
  Future<void> clearTokens();

  // Agent Cache Management
  Future<void> cacheAgent(AgentModel agent);
  Future<AgentModel?> getCachedAgent();
  Future<void> clearCachedAgent();

  // Remember Me Management
  Future<void> saveRememberedEmail(String email);
  String? getRememberedEmail();
  Future<void> clearRememberedEmail();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  final TokenStorage tokenStorage;
  static const cachedAgentKey = 'CACHED_AGENT';
  static const draftEmailKey = 'REMEMBERED_EMAIL';

  AuthLocalDataSourceImpl({required this.sharedPreferences, required this.tokenStorage});

  // Agent Cache Management
  @override
  Future<bool> cacheAgent(AgentModel agent) async {
    return sharedPreferences.setString(cachedAgentKey, jsonEncode(agent.toJson()));
  }

  @override
  Future<AgentModel?> getCachedAgent() async {
    final jsonString = sharedPreferences.getString(cachedAgentKey);
    if (jsonString != null) {
      return AgentModel.fromJson(jsonDecode(jsonString));
    }
    throw CacheException();
  }

  @override
  Future<bool> clearCachedAgent() async {
    return await sharedPreferences.remove(cachedAgentKey);
  }

  // Tokens Management
  @override
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await tokenStorage.saveTokens(accessToken, refreshToken);
  }

  @override
  Future<void> clearTokens() async {
    await tokenStorage.clearTokens();
  }

  // Remember Me Management
  @override
  Future<void> saveRememberedEmail(String email) async {
    await sharedPreferences.setString(draftEmailKey, email);
  }

  @override
  String? getRememberedEmail() {
    return sharedPreferences.getString(draftEmailKey);
  }

  @override
  Future<void> clearRememberedEmail() async {
    await sharedPreferences.remove(draftEmailKey);
  }
}

@riverpod
AuthLocalDataSource authLocalDataSource(Ref ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  final tokenStorage = ref.watch(tokenStorageProvider);
  if (sharedPreferences.hasValue) {
    return AuthLocalDataSourceImpl(
      sharedPreferences: sharedPreferences.value!,
      tokenStorage: tokenStorage,
    );
  } else {
    throw CacheException();
  }
}
