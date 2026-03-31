import 'package:agent_pro/core/error/failure.dart';
import 'package:agent_pro/core/usecase/usecase.dart';
import 'package:agent_pro/features/players/domain/entities/player.dart';
import 'package:agent_pro/features/players/domain/repositories/player_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllPlayers extends UseCase<List<Player>, NoParams> {
  final PlayerRepository repository;

  GetAllPlayers(this.repository);

  @override
  Future<Either<Failure, List<Player>>> call(NoParams params) async {
    return await repository.getAllPlayers();
  }
}


// TODO: Implement the Riverpod Provider for this use case