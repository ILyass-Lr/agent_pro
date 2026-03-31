import 'package:agent_pro/core/storage/session_provider.dart';
import 'package:agent_pro/features/auth/data/models/agent_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/types/sign_up_params.dart';
import '../../domain/entities/agent.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/sign_up_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final Ref ref;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
    required this.ref,
  });

  DateTime? _nextAllowedResend;

  @visibleForTesting
  void setNextAllowedResendForTest(DateTime? value) {
    _nextAllowedResend = value;
  }

  // Authentication
  @override
  Future<Either<Failure, Unit>> signUp(SignUpParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final request = SignUpRequest(
          firstName: params.personal.firstName,
          lastName: params.personal.lastName,
          email: params.personal.email,
          phoneNumber: params.personal.phoneNumber,
          password: params.security.password,
          confirmPassword: params.security.confirmPassword,
          agencyName: params.professional.agencyName,
          fifaLicense: params.professional.fifaLicense,
          licenseFilePath: params.professional.licenseFilePath,
        );
        await remoteDataSource.signUp(request);
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message, field: e.field));
      } catch (e) {
        return const Left(ServerFailure(message: "An unexpected error occurred."));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Agent>> signIn({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        // 1. Get the full response
        final authResponse = await remoteDataSource.signIn(email: email, password: password);

        // 2. Save tokens if Remember Me is enabled
        final accessToken = authResponse.tokens.accessToken;
        if (rememberMe) {
          await localDataSource.saveTokens(accessToken, authResponse.tokens.refreshToken);
          localDataSource.saveRememberedEmail(email);
        } else {
          await localDataSource.clearTokens();
          await localDataSource.clearRememberedEmail();
        }

        // 3. Update RAM (Session)
        ref.read(sessionProvider.notifier).setToken(accessToken);

        // 4. Cache the agent model and Return the agent entity
        final agentModel = authResponse.agent;
        localDataSource.cacheAgent(agentModel);
        return Right(agentModel.toEntity());
      } on AgentStatusException catch (e) {
        return Left(UnauthorizedFailure(message: e.message, reason: e.reason, status: e.status));
      } on DataSerializationException catch (e) {
        return Left(ServerFailure(message: "Server Data error: ${e.message}"));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } on PlatformException catch (e) {
        return Left(PlatformFailure(message: e.message!));
      } catch (e) {
        return const Left(ServerFailure(message: "An unexpected error occurred."));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await localDataSource.clearTokens();
      ref.read(sessionProvider.notifier).clearToken();
      return const Right(unit);
    } catch (e) {
      return const Left(CacheFailure(message: "Failed to sign out."));
    }
  }

  @override
  String? getRememberedEmail() {
    return localDataSource.getRememberedEmail();
  }

  // Profile
  @override
  Future<Either<Failure, Agent>> getCurrentAgent({bool fromServerOnly = true}) async {
    if (await networkInfo.isConnected) {
      try {
        final agent = await remoteDataSource.getAgentDetails();
        return Right(agent.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } on DataSerializationException catch (e) {
        return Left(ServerFailure(message: "Server Data error: ${e.message}"));
      } catch (e) {
        return const Left(ServerFailure(message: "An unexpected error occurred."));
      }
    } else if (!fromServerOnly) {
      try {
        final agent = await localDataSource.getCachedAgent();
        if (agent != null) {
          return Right(agent.toEntity());
        } else {
          return const Left(CacheFailure(message: "No cached agent found."));
        }
      } on DataSerializationException catch (e) {
        localDataSource.clearCachedAgent(); // Clear corrupted cache
        return Left(CacheFailure(message: "Cached Data error: ${e.message}"));
      } catch (e) {
        return const Left(CacheFailure(message: "An unexpected error occurred."));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  // Forgot password
  @override
  Future<Either<Failure, Unit>> sendPasswordResetEmail(String email) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.sendPasswordResetEmail(email);
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return const Left(ServerFailure(message: "An unexpected error occurred."));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyResetCode(String email, String code) async {
    if (await networkInfo.isConnected) {
      try {
        final isValid = await remoteDataSource.verifyResetCode(email, code);
        if (isValid) {
          return const Right(unit);
        } else {
          return const Left(ServerFailure(message: "Invalid OTP reset code."));
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return const Left(ServerFailure(message: "An unexpected error occurred."));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> resendOtp(String email) async {
    if (await networkInfo.isConnected) {
      final now = DateTime.now();
      if (_nextAllowedResend != null && now.isBefore(_nextAllowedResend!)) {
        final remainingSeconds = _nextAllowedResend!.difference(now).inSeconds + 1;
        return Left(
          RateLimitFailure(
            message: 'Please wait $remainingSeconds seconds before requesting a new OTP.',
            coolDownSeconds: remainingSeconds,
          ),
        );
      }
      // Call Remote Data (which only handles the API and 429)
      try {
        await remoteDataSource.resendOtp(email);
        return const Right(unit);
      } on ServerException catch (e) {
        final coolDown = e.coolDownSeconds;
        if (coolDown != null) {
          _nextAllowedResend = DateTime.now().add(Duration(seconds: coolDown));
          return Left(RateLimitFailure(message: e.message, coolDownSeconds: coolDown));
        }
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return const Left(ServerFailure(message: "An unexpected error occurred."));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> resetPassword(
    String email,
    String code,
    String newPassword,
    String confirmPassword,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.resetPassword(email, code, newPassword, confirmPassword);
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return const Left(ServerFailure(message: "An unexpected error occurred."));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }
}
