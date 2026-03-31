import 'package:agent_pro/core/error/failure.dart';
import 'package:agent_pro/core/usecase/usecase.dart';
import 'package:agent_pro/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fpdart/fpdart.dart';

part 'sign_out_use_case.g.dart';

class SignOut extends UseCase<Unit, NoParams> {
  final AuthRepository authRepository;
  SignOut(this.authRepository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await authRepository.signOut();
  }
}

@riverpod
SignOut signOutUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignOut(repository);
}
