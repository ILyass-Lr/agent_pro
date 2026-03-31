import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/agent_model.dart';

part 'auth_response.freezed.dart';
part 'auth_response.g.dart';

@freezed
abstract class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required String message,
    @JsonKey(name: 'user')
    required AgentModel agent,
    required TokenModel tokens,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
}

@freezed
abstract class TokenModel with _$TokenModel {
  const factory TokenModel({
    @JsonKey(name: 'access') required String accessToken,
    @JsonKey(name: 'refresh') required String refreshToken,
  }) = _TokenModel;

  factory TokenModel.fromJson(Map<String, dynamic> json) => _$TokenModelFromJson(json);
}
