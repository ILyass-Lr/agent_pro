import 'package:agent_pro/core/error/failure.dart';
import 'package:agent_pro/core/usecase/usecase.dart';
import 'package:agent_pro/features/players/domain/repositories/player_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeletePlayer extends UseCase<void, String> {
  final PlayerRepository repository;

  DeletePlayer(this.repository);

  @override
  Future<Either<Failure, void>> call(String id) async {
    return await repository.deletePlayer(id);
  }
}


// TODO: Implement the Riverpod Provider for this use case