import '../services/auth_status_notifier.dart';

import 'auth_interceptor.dart';
import '../storage/token_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_client.g.dart';

String _defaultApiHost() {
  if (kIsWeb) return 'localhost';

  return switch (defaultTargetPlatform) {
    TargetPlatform.android => '10.0.2.2', // Android emulator host loopback
    TargetPlatform.iOS => '127.0.0.1',
    TargetPlatform.macOS => 'localhost',
    TargetPlatform.windows => 'localhost',
    TargetPlatform.linux => 'localhost',
    TargetPlatform.fuchsia => 'localhost',
  };
}

String _normalizeHost(String host) {
  final trimmed = host.trim();
  return trimmed.replaceFirst(RegExp(r'^https?://'), '');
}

@riverpod
String baseUrl(Ref ref) {
  const explicitBaseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: '');
  if (explicitBaseUrl.isNotEmpty) {
    return explicitBaseUrl.endsWith('/')
        ? explicitBaseUrl.substring(0, explicitBaseUrl.length - 1)
        : explicitBaseUrl;
  }

  final host = _normalizeHost(
    const String.fromEnvironment('API_HOST', defaultValue: '') != ''
        ? const String.fromEnvironment('API_HOST')
        : _defaultApiHost(),
  );
  const port = String.fromEnvironment('API_PORT', defaultValue: '8000');

  return 'http://$host:$port/api/v1/fr';
}

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final tokenStorage = ref.watch(tokenStorageProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: ref.watch(baseUrlProvider),
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  dio.interceptors.add(
    AuthInterceptor(
      dio: dio,
      read: ref.read,
      tokenStorage: tokenStorage,
      onLogout: () {
        ref.read(authStatusProvider.notifier).logout();
      },
    ),
  );

  // Only add logging in Dev mode
  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
        logPrint: (obj) => debugPrint(obj.toString()),
      ),
    );
  }

  return dio;
}

@Riverpod(keepAlive: true)
Dio refreshDio(Ref ref) {
  final dio = Dio(ref.watch(dioProvider).options);

  // Only add logging in Dev mode
  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
        logPrint: (obj) => debugPrint(obj.toString()),
      ),
    );
  }

  return dio;
}
