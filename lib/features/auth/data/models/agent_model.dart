import '../../../../core/types/agent_status.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/agent.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'agent_model.freezed.dart';
part 'agent_model.g.dart';

@freezed
abstract class AgentModel with _$AgentModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AgentModel({
    @JsonKey(fromJson: _idFromJson, toJson: _idToJson) required BigInt id,
    required String firstName,
    required String lastName,
    required String email,
    @JsonKey(name: 'phone', fromJson: _nullableStringToEmpty) required String phoneNumber,
    required String agencyName,
    @JsonKey(name: 'license_number') required String fifaLicense,
    @JsonKey(name: 'avatar') String? avatarUrl,
    @Default(false) bool fifaCertified,
    DateTime? certificationDate,
    @JsonKey(name: 'certification_document_url', fromJson: _nullableStringToEmpty)
    required String licenseFilePath,
    required String country,
    required String city,
    @Default(Status.pending) @JsonKey(unknownEnumValue: Status.pending) Status status,
    // @JsonKey(name: 'status_display') String? statusDisplayMessage,
    // @Default(false) bool isActive,
  }) = _AgentModel;

  factory AgentModel.fromJson(Map<String, dynamic> json) => _$AgentModelFromJson(json);
}

BigInt _idFromJson(Object? value) {
  if (value is int) return BigInt.from(value);
  if (value is String) return BigInt.parse(value);
  throw FormatException('Invalid id value: $value');
}

Object _idToJson(BigInt value) => value.toString();

String _nullableStringToEmpty(Object? value) => (value as String?) ?? '';

extension AgentModelX on AgentModel {
  Agent toEntity() {
    try {
      return Agent(
        id: Id.fromBackend(id),
        firstName: Name.fromBackend(firstName),
        lastName: Name.fromBackend(lastName),
        email: Email.fromBackend(email),
        phoneNumber: PhoneNumber.fromBackend(phoneNumber),
        agencyName: Name.fromBackend(agencyName),
        fifaLicense: FifaLicense.fromBackend(fifaLicense),
        licenseFilePath: FilePath.fromBackend(licenseFilePath),
        country: country,
        city: city,
      );
    } catch (e) {
      throw DataSerializationException(e.toString());
    }
  }
}
