// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) =>
    _AuthResponse(
      message: json['message'] as String,
      agent: AgentModel.fromJson(json['user'] as Map<String, dynamic>),
      tokens: TokenModel.fromJson(json['tokens'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseToJson(_AuthResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'user': instance.agent,
      'tokens': instance.tokens,
    };

_TokenModel _$TokenModelFromJson(Map<String, dynamic> json) => _TokenModel(
  accessToken: json['access'] as String,
  refreshToken: json['refresh'] as String,
);

Map<String, dynamic> _$TokenModelToJson(_TokenModel instance) =>
    <String, dynamic>{
      'access': instance.accessToken,
      'refresh': instance.refreshToken,
    };
