import 'package:agent_pro/features/players/domain/entities/player.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_model.freezed.dart';
part 'player_model.g.dart';

// Note: The first_name, last_name and date_of_birth fields are not included from the API response, because full_name and age are sufficient for our use case, created_at is also not included.
@freezed
abstract class PlayerModel with _$PlayerModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PlayerModel({
    @JsonKey(fromJson: _idFromJson, toJson: _idToJson) required BigInt id,
    required String fullName,
    @JsonKey(unknownEnumValue: Position.forward) required Position position,
    required String nationalityCode,
    required String nationalityName,
    required String clubName,
    required String clubLogo,
    required double marketValue,
    required double overallRating,
    @JsonKey(name: 'photo') required String photoUrl,
    required int age,
    String? agentName,
    int? agentId,
  }) = _PlayerModel;

  factory PlayerModel.fromJson(Map<String, dynamic> json) => _$PlayerModelFromJson(json);
}

BigInt _idFromJson(Object? value) {
  if (value is int) return BigInt.from(value);
  if (value is String) return BigInt.parse(value);
  throw FormatException('Invalid id value: $value');
}

Object _idToJson(BigInt value) => value.toString();

extension PlayerModelX on PlayerModel {
  Player toEntity() {
    return Player(
      id: id,
      fullName: fullName,
      position: position,
      clubName: clubName,
      clubLogoUrl: clubLogo,
      marketValue: marketValue.toInt(),
      photoUrl: photoUrl,
    );
  }
}
