import 'package:agent_pro/core/error/failure.dart';
import 'package:agent_pro/core/usecase/usecase.dart';
import 'package:agent_pro/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fpdart/fpdart.dart';

part 'forgot_password_use_cases.g.dart';

class SendPasswordResetEmail extends UseCase<Unit, String> {
  final AuthRepository repository;

  SendPasswordResetEmail(this.repository);

  @override
  Future<Either<Failure, Unit>> call(String email) async {
    return await repository.sendPasswordResetEmail(email);
  }
}

class VerifyResetCode extends UseCase<Unit, ({String email, String code})> {
  final AuthRepository repository;

  VerifyResetCode(this.repository);

  @override
  Future<Either<Failure, Unit>> call(({String email, String code}) params) async {
    return await repository.verifyResetCode(params.email, params.code);
  }
}

class ResendOtp extends UseCase<Unit, String> {
  final AuthRepository repository;

  ResendOtp(this.repository);

  @override
  Future<Either<Failure, Unit>> call(String email) async {
    return await repository.resendOtp(email);
  }
}

class ResetPassword
    extends
        UseCase<Unit, ({String email, String code, String newPassword, String confirmPassword})> {
  final AuthRepository repository;

  ResetPassword(this.repository);

  @override
  Future<Either<Failure, Unit>> call(
    ({String email, String code, String newPassword, String confirmPassword}) params,
  ) async {
    return await repository.resetPassword(
      params.email,
      params.code,
      params.newPassword,
      params.confirmPassword,
    );
  }
}

@riverpod
SendPasswordResetEmail sendPasswordResetEmail(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SendPasswordResetEmail(repository);
}

@riverpod
VerifyResetCode verifyResetCode(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return VerifyResetCode(repository);
}

@riverpod
ResetPassword resetPassword(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return ResetPassword(repository);
}

@riverpod
ResendOtp resendOtp(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return ResendOtp(repository);
}
