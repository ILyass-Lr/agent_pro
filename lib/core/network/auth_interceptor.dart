import 'dart:ui';

import 'package:agent_pro/core/storage/session_provider.dart';

import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../storage/token_storage.dart';
import 'package:dio/dio.dart';

typedef ProviderReader = T Function<T>(ProviderListenable<T> provider);

class AuthInterceptor extends QueuedInterceptor {
  final Dio dio;
  final ProviderReader read;
  final TokenStorage tokenStorage;
  final VoidCallback onLogout;
  // To prevent multiple simultaneous refresh attempts
  Future<String?>? _refreshFuture;

  AuthInterceptor({
    required this.dio,
    required this.read,
    required this.tokenStorage,
    required this.onLogout,
  });

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // 1. Check RAM (SessionProvider)
    String? accessToken = read(sessionProvider);
    // 2. If RAM is empty, try to "Hydrate" from Disk
    if (accessToken == null) {
      accessToken = await tokenStorage.getAccessToken();
      // 3. Update RAM with the hydrated token
      if (accessToken != null) {
        read(sessionProvider.notifier).setToken(accessToken);
      }
    }
    // [requireAuth] will be mainly null if Auth is indeed required
    if (accessToken != null && options.extra['requireAuth'] != false) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    // 1. Check if the error is due to an unauthorized access (401)
    if (err.response?.statusCode == 401 && !err.requestOptions.path.contains('/refresh')) {
      // 2. Attempt to refresh the token
      try {
        // If a refresh is ALREADY in progress, wait for it instead of starting a new one
        final newAccessToken = await (_refreshFuture ??= _performRefresh());
        if (newAccessToken != null) {
          // 3. Update the original request with the new token and retry
          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer $newAccessToken';

          try {
            final response = await dio.fetch(options);
            return handler.resolve(response);
          } on DioException catch (e) {
            // If the retry also fails with a 401, clear tokens and logout
            if (e.response?.statusCode == 401) {
              _handleLogout();
            }
            return handler.next(e);
          }
        } else {
          // If token refresh fails, clear tokens and pass the error
          _handleLogout();
        }
      } catch (e) {
        // Refresh failed (e.g., refresh token expired)
        _handleLogout();
      } finally {
        // Reset the refresh future so that future 401s can trigger a new refresh attempt
        _refreshFuture = null;
      }
    }
    return handler.next(err);
  }

  Future<String?> _performRefresh() async {
    final tokenRefresher = read(tokenRefresherProvider);
    final newAccessToken = await tokenRefresher.refreshAccessToken();
    if (newAccessToken != null) {
      // Update the RAM state
      read(sessionProvider.notifier).setToken(newAccessToken);
    }
    return newAccessToken;
  }

  Future<void> _handleLogout() async {
    await tokenStorage.clearTokens();
    read(sessionProvider.notifier).setToken(null);
    onLogout();
  }
}
