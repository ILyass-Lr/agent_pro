// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlayerModel _$PlayerModelFromJson(Map<String, dynamic> json) => _PlayerModel(
  id: _idFromJson(json['id']),
  fullName: json['full_name'] as String,
  position: $enumDecode(
    _$PositionEnumMap,
    json['position'],
    unknownValue: Position.forward,
  ),
  nationalityCode: json['nationality_code'] as String,
  nationalityName: json['nationality_name'] as String,
  clubName: json['club_name'] as String,
  clubLogo: json['club_logo'] as String,
  marketValue: (json['market_value'] as num).toDouble(),
  overallRating: (json['overall_rating'] as num).toDouble(),
  photoUrl: json['photo'] as String,
  age: (json['age'] as num).toInt(),
  agentName: json['agent_name'] as String?,
  agentId: (json['agent_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$PlayerModelToJson(_PlayerModel instance) =>
    <String, dynamic>{
      'id': _idToJson(instance.id),
      'full_name': instance.fullName,
      'position': _$PositionEnumMap[instance.position]!,
      'nationality_code': instance.nationalityCode,
      'nationality_name': instance.nationalityName,
      'club_name': instance.clubName,
      'club_logo': instance.clubLogo,
      'market_value': instance.marketValue,
      'overall_rating': instance.overallRating,
      'photo': instance.photoUrl,
      'age': instance.age,
      'agent_name': instance.agentName,
      'agent_id': instance.agentId,
    };

const _$PositionEnumMap = {
  Position.goalkeeper: 'goalkeeper',
  Position.defender: 'defender',
  Position.midfielder: 'midfielder',
  Position.forward: 'forward',
};
