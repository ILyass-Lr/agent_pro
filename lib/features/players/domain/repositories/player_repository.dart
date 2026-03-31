import 'package:agent_pro/core/error/failure.dart';
import 'package:agent_pro/features/players/domain/entities/player.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class PlayerRepository {
  Future<Either<Failure, List<Player>>> getAllPlayers();
  Future<Either<Failure, List<Player>>> getAgentPlayers();
  Future<Either<Failure, void>> addPlayer(Player player);
  Future<Either<Failure, void>> updatePlayer(Player player);
  Future<Either<Failure, void>> deletePlayer(String id);
}
