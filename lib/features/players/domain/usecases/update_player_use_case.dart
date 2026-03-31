import 'package:agent_pro/core/error/failure.dart';
import 'package:agent_pro/core/usecase/usecase.dart';
import 'package:agent_pro/features/players/domain/entities/player.dart';
import 'package:agent_pro/features/players/domain/repositories/player_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdatePlayer extends UseCase<void, Player> {
  final PlayerRepository repository;

  UpdatePlayer(this.repository);

  @override
  Future<Either<Failure, void>> call(Player player) async {
    return await repository.updatePlayer(player);
  }
}


// TODO: Implement the Riverpod Provider for this use case