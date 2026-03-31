import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/types/sign_up_params.dart';
import '../../data/datasources/auth_local_data_source.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_implementation.dart';
import '../entities/agent.dart';

part 'auth_repository.g.dart';

abstract interface class AuthRepository {
  // Authentication
  Future<Either<Failure, Agent>> signIn({
    required String email,
    required String password,
    required bool rememberMe,
  });
  Future<Either<Failure, Unit>> signUp(SignUpParams params);
  Future<Either<Failure, Unit>> signOut();
  String? getRememberedEmail();
  // Forgot password
  Future<Either<Failure, Unit>> sendPasswordResetEmail(String email);
  Future<Either<Failure, Unit>> verifyResetCode(String email, String code);
  Future<Either<Failure, Unit>> resendOtp(String email);
  Future<Either<Failure, Unit>> resetPassword(
    String email,
    String code,
    String newPassword,
    String confirmPassword,
  );
  // Profile
  Future<Either<Failure, Agent>> getCurrentAgent({bool fromServerOnly = true});
}

@riverpod
AuthRepository authRepository(Ref ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  final localDataSource = ref.watch(authLocalDataSourceProvider);
  final networkInfo = ref.watch(networkInfoProvider);
  return AuthRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
    networkInfo: networkInfo,
    ref: ref,
  );
}
