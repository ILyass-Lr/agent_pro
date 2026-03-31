import 'package:agent_pro/core/types/agent_status.dart';
import 'package:agent_pro/features/auth/data/models/auth_response.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/token_refresher.dart';
import '../../../../core/storage/token_storage.dart';
import '../../../../core/types/sign_up_field.dart';
import '../models/agent_model.dart';
import '../models/sign_up_request.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_data_source.g.dart';

abstract interface class AuthRemoteDataSource {
  // Authentication
  Future<AuthResponse> signIn({required String email, required String password});
  Future<void> signUp(SignUpRequest request);
  // Future<void> signOut();

  // Forgot password
  Future<void> sendPasswordResetEmail(String email);
  Future<bool> verifyResetCode(String email, String code);
  Future<void> resendOtp(String email);
  Future<void> resetPassword(String email, String otp, String newPassword, String confirmPassword);

  // Profile
  Future<AgentModel> getAgentDetails();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource, TokenRefresher {
  static const Duration _resendOtpCooldown = Duration(seconds: 60);

  final Dio client;
  final Dio refreshDio;
  final TokenStorage tokenStorage;

  AuthRemoteDataSourceImpl({
    required this.client,
    required this.refreshDio,
    required this.tokenStorage,
  });

  // Authentication
  @override
  Future<void> signUp(SignUpRequest request) async {
    FormData formData = await request.toFormData();
    try {
      await client.post(
        '/accounts/agents/register/',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          validateStatus: (statusCode) => statusCode == 201,
          extra: {'requireAuth': false},
        ),
      );
    } on DioException catch (e) {
      if (e.response != null) {
        final response = e.response;
        switch (response?.data) {
          case {'email': String message || [String message, ...]}:
            throw ServerException(message: message, field: SignUpField.email);
          case {'confirm_password': String message || [String message, ...]}:
            throw ServerException(message: message, field: SignUpField.confirmPassword);
          case {'license_number': String message || [String message, ...]}:
            throw ServerException(message: message, field: SignUpField.licenseNumber);
          case {'password': String message || [String message, ...]}:
            throw ServerException(message: message, field: SignUpField.password);
          default:
            throw ServerException();
        }
      } else {
        throw ServerException(message: "Network error. Please try again.");
      }
    }
  }

  @override
  Future<AuthResponse> signIn({required String email, required String password}) async {
    try {
      final response = await client.post(
        '/accounts/auth/login/',
        data: {'email': email, 'password': password},
        options: Options(
          contentType: 'application/json',
          extra: {'requireAuth': false},
          validateStatus: (status) => status == 200,
        ),
      );
      // We parse the whole envelope, which includes the user AND tokens
      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      final response = e.response;
      if (response != null) {
        if (response.statusCode == 403) {
          if (response.data case {
            'error': String message,
            'reason': String reason,
            'status': String status,
          }) {
            throw AgentStatusException(
              message: message,
              reason: reason,
              status: statusFromJson(status),
            );
          }
        }
        // Handle 401 or other errors
        throw ServerException(
          message: response.data['error'] ?? "Invalid credentials. Please try again.",
        );
      } else {
        throw ServerException(message: "Network error. Please try again.");
      }
    }
  }

  // Refresh ddoken logic is handled in the interceptor, but we implement the actual refresh call here
  @override
  Future<String?> refreshAccessToken() async {
    final refreshToken = await tokenStorage.getRefreshToken();
    if (refreshToken == null) return null;

    try {
      final response = await refreshDio.post(
        '/accounts/auth/refresh',
        data: {'refresh': refreshToken},
        options: Options(
          contentType: 'application/json',
          validateStatus: (status) => status == 200,
        ),
      );
      if (response.data case {'message': String _, 'tokens': {'access': String newAccessToken}}) {
        await tokenStorage.saveAccessToken(newAccessToken);
        return newAccessToken;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Profile
  @override
  Future<AgentModel> getAgentDetails() async {
    try {
      final response = await client.get(
        '/accounts/agents/me/',
        options: Options(
          contentType: 'application/json',
          validateStatus: (status) => status == 200,
        ),
      );
      return AgentModel.fromJson(response.data);
    } catch (e) {
      throw ServerException(message: "Failed to fetch agent details.");
    }
  }

  // Forgot password
  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await client.post(
        '/accounts/auth/forgot-password/',
        data: {'email': email},
        options: Options(
          contentType: 'application/json',
          extra: {'requireAuth': false},
          validateStatus: (status) => status == 200,
        ),
      );
    } on DioException catch (e) {
      final response = e.response;
      if (response != null) {
        throw ServerException(
          message: response.data['error'] ?? "Failed to send password reset email.",
        );
      } else {
        throw ServerException(message: "Network error. Please try again.");
      }
    }
  }

  @override
  Future<bool> verifyResetCode(String email, String code) async {
    try {
      final response = await client.post(
        '/accounts/auth/verify-otp/',
        data: {'email': email, 'otp': code},
        options: Options(
          contentType: 'application/json',
          extra: {'requireAuth': false},
          validateStatus: (status) => status == 200,
        ),
      );
      if (response.data case {'reset_token': String refreshToken}) {
        await tokenStorage.saveRefreshToken(refreshToken);
        return true;
      }
      return false;
    } catch (e) {
      return Future.value(false);
    }
  }

  @override
  Future<void> resetPassword(
    String email,
    String otp,
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      await client.post(
        '/accounts/auth/reset-password/',
        data: {
          'email': email,
          'otp': otp,
          'new_password': newPassword,
          'confirm_password': confirmPassword,
        },
        options: Options(
          contentType: 'application/json',
          extra: {'requireAuth': false},
          validateStatus: (status) => status == 200,
        ),
      );
    } on DioException catch (e) {
      final response = e.response;
      if (response != null) {
        throw ServerException(message: response.data['error'] ?? "Failed to reset password.");
      } else {
        throw ServerException(message: "Network error. Please try again.");
      }
    }
  }

  @override
  Future<void> resendOtp(String email) async {
    try {
      await client.post(
        '/accounts/auth/resend-otp/',
        data: {'email': email},
        options: Options(
          contentType: 'application/json',
          extra: {'requireAuth': false},
          validateStatus: (status) => status == 200,
        ),
      );
    } on DioException catch (e) {
      final response = e.response;
      if (response != null) {
        if (response.statusCode == 429) {
          // check if the server provided a Retry-After header or a cooldown in the response body
          final retryAfterRaw = response.headers.value('Retry-After');
          final retryAfter = int.tryParse(retryAfterRaw ?? '') ?? response.data['cooldown'] as int?;
          final waitSeconds = retryAfter ?? _resendOtpCooldown.inSeconds;
          throw ServerException(
            message: 'Please wait $waitSeconds seconds before requesting a new OTP.',
            coolDownSeconds: waitSeconds,
          );
        }
        throw ServerException(message: response.data['error'] ?? "Failed to resend OTP.");
      } else {
        throw ServerException(message: "Network error. Please try again.");
      }
    }
  }
}

@riverpod
AuthRemoteDataSourceImpl authRemoteDataSourceImpl(Ref ref) {
  return AuthRemoteDataSourceImpl(
    client: ref.watch(dioProvider),
    refreshDio: ref.watch(refreshDioProvider),
    tokenStorage: ref.watch(tokenStorageProvider),
  );
}

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  return ref.watch(authRemoteDataSourceImplProvider);
}

@riverpod
TokenRefresher tokenRefresher(Ref ref) {
  return ref.watch(authRemoteDataSourceImplProvider);
}
