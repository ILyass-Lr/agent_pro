// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AgentModel _$AgentModelFromJson(Map<String, dynamic> json) => _AgentModel(
  id: _idFromJson(json['id']),
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  email: json['email'] as String,
  phoneNumber: _nullableStringToEmpty(json['phone']),
  agencyName: json['agency_name'] as String,
  fifaLicense: json['license_number'] as String,
  avatarUrl: json['avatar'] as String?,
  fifaCertified: json['fifa_certified'] as bool? ?? false,
  certificationDate: json['certification_date'] == null
      ? null
      : DateTime.parse(json['certification_date'] as String),
  licenseFilePath: _nullableStringToEmpty(json['certification_document_url']),
  country: json['country'] as String,
  city: json['city'] as String,
  status:
      $enumDecodeNullable(
        _$StatusEnumMap,
        json['status'],
        unknownValue: Status.pending,
      ) ??
      Status.pending,
);

Map<String, dynamic> _$AgentModelToJson(_AgentModel instance) =>
    <String, dynamic>{
      'id': _idToJson(instance.id),
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone': instance.phoneNumber,
      'agency_name': instance.agencyName,
      'license_number': instance.fifaLicense,
      'avatar': instance.avatarUrl,
      'fifa_certified': instance.fifaCertified,
      'certification_date': instance.certificationDate?.toIso8601String(),
      'certification_document_url': instance.licenseFilePath,
      'country': instance.country,
      'city': instance.city,
      'status': _$StatusEnumMap[instance.status]!,
    };

const _$StatusEnumMap = {
  Status.pending: 'pending',
  Status.approved: 'approved',
  Status.suspended: 'suspended',
  Status.rejected: 'rejected',
};
