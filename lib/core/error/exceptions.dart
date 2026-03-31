import 'package:agent_pro/core/types/agent_status.dart';
import 'package:agent_pro/core/types/sign_up_field.dart';

class ServerException implements Exception {
  final String message;

  /// In case of a SignUp: indicate which sign-up field caused the error, if applicable
  final SignUpField? field;
  final int? coolDownSeconds;
  ServerException({
    this.message = 'An error occurred while communicating with the server.',
    this.field,
    this.coolDownSeconds,
  });
}

class AgentStatusException implements Exception {
  final String message;
  final String reason;
  final Status status;

  AgentStatusException({required this.message, required this.reason, required this.status});
}

class CacheException implements Exception {}

class DataSerializationException implements Exception {
  final String message;
  DataSerializationException(this.message);
}
