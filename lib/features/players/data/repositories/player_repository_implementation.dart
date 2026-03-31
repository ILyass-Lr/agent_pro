import 'package:agent_pro/core/error/failure.dart';
import 'package:agent_pro/features/players/domain/entities/player.dart';
import 'package:agent_pro/features/players/domain/repositories/player_repository.dart';
import 'package:fpdart/fpdart.dart';

class PlayerRepositoryImplementation implements PlayerRepository {
  @override
  Future<Either<Failure, List<Player>>> getAllPlayers() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Player>>> getAgentPlayers() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> addPlayer(Player player) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updatePlayer(Player player) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deletePlayer(String id) {
    throw UnimplementedError();
  }
}
