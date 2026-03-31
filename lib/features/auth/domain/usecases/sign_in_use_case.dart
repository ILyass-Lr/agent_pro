import 'package:agent_pro/core/error/failure.dart';
import 'package:agent_pro/core/usecase/usecase.dart';
import 'package:agent_pro/features/auth/domain/entities/agent.dart';
import 'package:agent_pro/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_use_case.g.dart';

class SignIn extends UseCase<Agent, ({String email, String password, bool rememberMe})> {
  final AuthRepository authRepository;

  SignIn(this.authRepository);

  @override
  Future<Either<Failure, Agent>> call(({String email, String password, bool rememberMe}) params) {
    return authRepository.signIn(
      email: params.email,
      password: params.password,
      rememberMe: params.rememberMe,
    );
  }
}

@riverpod
SignIn signInUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignIn(repository);
}
