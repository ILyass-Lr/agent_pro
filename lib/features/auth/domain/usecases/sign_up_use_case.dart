import '../../../../core/error/failure.dart';
import '../../../../core/types/sign_up_params.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_up_use_case.g.dart';

class SignUp extends UseCase<Unit, SignUpParams> {
  final AuthRepository repository;

  SignUp(this.repository);

  @override
  FutureOr<Either<Failure, Unit>> call(SignUpParams params) {
    return repository.signUp(params);
  }
}

@riverpod
SignUp signUpUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignUp(repository);
}
