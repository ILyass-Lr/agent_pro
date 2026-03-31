// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AgentModel {

@JsonKey(fromJson: _idFromJson, toJson: _idToJson) BigInt get id; String get firstName; String get lastName; String get email;@JsonKey(name: 'phone', fromJson: _nullableStringToEmpty) String get phoneNumber; String get agencyName;@JsonKey(name: 'license_number') String get fifaLicense;@JsonKey(name: 'avatar') String? get avatarUrl; bool get fifaCertified; DateTime? get certificationDate;@JsonKey(name: 'certification_document_url', fromJson: _nullableStringToEmpty) String get licenseFilePath; String get country; String get city;@JsonKey(unknownEnumValue: Status.pending) Status get status;
/// Create a copy of AgentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgentModelCopyWith<AgentModel> get copyWith => _$AgentModelCopyWithImpl<AgentModel>(this as AgentModel, _$identity);

  /// Serializes this AgentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.agencyName, agencyName) || other.agencyName == agencyName)&&(identical(other.fifaLicense, fifaLicense) || other.fifaLicense == fifaLicense)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.fifaCertified, fifaCertified) || other.fifaCertified == fifaCertified)&&(identical(other.certificationDate, certificationDate) || other.certificationDate == certificationDate)&&(identical(other.licenseFilePath, licenseFilePath) || other.licenseFilePath == licenseFilePath)&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,email,phoneNumber,agencyName,fifaLicense,avatarUrl,fifaCertified,certificationDate,licenseFilePath,country,city,status);

@override
String toString() {
  return 'AgentModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, agencyName: $agencyName, fifaLicense: $fifaLicense, avatarUrl: $avatarUrl, fifaCertified: $fifaCertified, certificationDate: $certificationDate, licenseFilePath: $licenseFilePath, country: $country, city: $city, status: $status)';
}


}

/// @nodoc
abstract mixin class $AgentModelCopyWith<$Res>  {
  factory $AgentModelCopyWith(AgentModel value, $Res Function(AgentModel) _then) = _$AgentModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _idFromJson, toJson: _idToJson) BigInt id, String firstName, String lastName, String email,@JsonKey(name: 'phone', fromJson: _nullableStringToEmpty) String phoneNumber, String agencyName,@JsonKey(name: 'license_number') String fifaLicense,@JsonKey(name: 'avatar') String? avatarUrl, bool fifaCertified, DateTime? certificationDate,@JsonKey(name: 'certification_document_url', fromJson: _nullableStringToEmpty) String licenseFilePath, String country, String city,@JsonKey(unknownEnumValue: Status.pending) Status status
});




}
/// @nodoc
class _$AgentModelCopyWithImpl<$Res>
    implements $AgentModelCopyWith<$Res> {
  _$AgentModelCopyWithImpl(this._self, this._then);

  final AgentModel _self;
  final $Res Function(AgentModel) _then;

/// Create a copy of AgentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? firstName = null,Object? lastName = null,Object? email = null,Object? phoneNumber = null,Object? agencyName = null,Object? fifaLicense = null,Object? avatarUrl = freezed,Object? fifaCertified = null,Object? certificationDate = freezed,Object? licenseFilePath = null,Object? country = null,Object? city = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as BigInt,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,agencyName: null == agencyName ? _self.agencyName : agencyName // ignore: cast_nullable_to_non_nullable
as String,fifaLicense: null == fifaLicense ? _self.fifaLicense : fifaLicense // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,fifaCertified: null == fifaCertified ? _self.fifaCertified : fifaCertified // ignore: cast_nullable_to_non_nullable
as bool,certificationDate: freezed == certificationDate ? _self.certificationDate : certificationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,licenseFilePath: null == licenseFilePath ? _self.licenseFilePath : licenseFilePath // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,
  ));
}

}


/// Adds pattern-matching-related methods to [AgentModel].
extension AgentModelPatterns on AgentModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AgentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AgentModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AgentModel value)  $default,){
final _that = this;
switch (_that) {
case _AgentModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AgentModel value)?  $default,){
final _that = this;
switch (_that) {
case _AgentModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _idFromJson, toJson: _idToJson)  BigInt id,  String firstName,  String lastName,  String email, @JsonKey(name: 'phone', fromJson: _nullableStringToEmpty)  String phoneNumber,  String agencyName, @JsonKey(name: 'license_number')  String fifaLicense, @JsonKey(name: 'avatar')  String? avatarUrl,  bool fifaCertified,  DateTime? certificationDate, @JsonKey(name: 'certification_document_url', fromJson: _nullableStringToEmpty)  String licenseFilePath,  String country,  String city, @JsonKey(unknownEnumValue: Status.pending)  Status status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AgentModel() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.email,_that.phoneNumber,_that.agencyName,_that.fifaLicense,_that.avatarUrl,_that.fifaCertified,_that.certificationDate,_that.licenseFilePath,_that.country,_that.city,_that.status);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _idFromJson, toJson: _idToJson)  BigInt id,  String firstName,  String lastName,  String email, @JsonKey(name: 'phone', fromJson: _nullableStringToEmpty)  String phoneNumber,  String agencyName, @JsonKey(name: 'license_number')  String fifaLicense, @JsonKey(name: 'avatar')  String? avatarUrl,  bool fifaCertified,  DateTime? certificationDate, @JsonKey(name: 'certification_document_url', fromJson: _nullableStringToEmpty)  String licenseFilePath,  String country,  String city, @JsonKey(unknownEnumValue: Status.pending)  Status status)  $default,) {final _that = this;
switch (_that) {
case _AgentModel():
return $default(_that.id,_that.firstName,_that.lastName,_that.email,_that.phoneNumber,_that.agencyName,_that.fifaLicense,_that.avatarUrl,_that.fifaCertified,_that.certificationDate,_that.licenseFilePath,_that.country,_that.city,_that.status);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _idFromJson, toJson: _idToJson)  BigInt id,  String firstName,  String lastName,  String email, @JsonKey(name: 'phone', fromJson: _nullableStringToEmpty)  String phoneNumber,  String agencyName, @JsonKey(name: 'license_number')  String fifaLicense, @JsonKey(name: 'avatar')  String? avatarUrl,  bool fifaCertified,  DateTime? certificationDate, @JsonKey(name: 'certification_document_url', fromJson: _nullableStringToEmpty)  String licenseFilePath,  String country,  String city, @JsonKey(unknownEnumValue: Status.pending)  Status status)?  $default,) {final _that = this;
switch (_that) {
case _AgentModel() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.email,_that.phoneNumber,_that.agencyName,_that.fifaLicense,_that.avatarUrl,_that.fifaCertified,_that.certificationDate,_that.licenseFilePath,_that.country,_that.city,_that.status);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _AgentModel implements AgentModel {
  const _AgentModel({@JsonKey(fromJson: _idFromJson, toJson: _idToJson) required this.id, required this.firstName, required this.lastName, required this.email, @JsonKey(name: 'phone', fromJson: _nullableStringToEmpty) required this.phoneNumber, required this.agencyName, @JsonKey(name: 'license_number') required this.fifaLicense, @JsonKey(name: 'avatar') this.avatarUrl, this.fifaCertified = false, this.certificationDate, @JsonKey(name: 'certification_document_url', fromJson: _nullableStringToEmpty) required this.licenseFilePath, required this.country, required this.city, @JsonKey(unknownEnumValue: Status.pending) this.status = Status.pending});
  factory _AgentModel.fromJson(Map<String, dynamic> json) => _$AgentModelFromJson(json);

@override@JsonKey(fromJson: _idFromJson, toJson: _idToJson) final  BigInt id;
@override final  String firstName;
@override final  String lastName;
@override final  String email;
@override@JsonKey(name: 'phone', fromJson: _nullableStringToEmpty) final  String phoneNumber;
@override final  String agencyName;
@override@JsonKey(name: 'license_number') final  String fifaLicense;
@override@JsonKey(name: 'avatar') final  String? avatarUrl;
@override@JsonKey() final  bool fifaCertified;
@override final  DateTime? certificationDate;
@override@JsonKey(name: 'certification_document_url', fromJson: _nullableStringToEmpty) final  String licenseFilePath;
@override final  String country;
@override final  String city;
@override@JsonKey(unknownEnumValue: Status.pending) final  Status status;

/// Create a copy of AgentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AgentModelCopyWith<_AgentModel> get copyWith => __$AgentModelCopyWithImpl<_AgentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AgentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AgentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.agencyName, agencyName) || other.agencyName == agencyName)&&(identical(other.fifaLicense, fifaLicense) || other.fifaLicense == fifaLicense)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.fifaCertified, fifaCertified) || other.fifaCertified == fifaCertified)&&(identical(other.certificationDate, certificationDate) || other.certificationDate == certificationDate)&&(identical(other.licenseFilePath, licenseFilePath) || other.licenseFilePath == licenseFilePath)&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,email,phoneNumber,agencyName,fifaLicense,avatarUrl,fifaCertified,certificationDate,licenseFilePath,country,city,status);

@override
String toString() {
  return 'AgentModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, agencyName: $agencyName, fifaLicense: $fifaLicense, avatarUrl: $avatarUrl, fifaCertified: $fifaCertified, certificationDate: $certificationDate, licenseFilePath: $licenseFilePath, country: $country, city: $city, status: $status)';
}


}

/// @nodoc
abstract mixin class _$AgentModelCopyWith<$Res> implements $AgentModelCopyWith<$Res> {
  factory _$AgentModelCopyWith(_AgentModel value, $Res Function(_AgentModel) _then) = __$AgentModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _idFromJson, toJson: _idToJson) BigInt id, String firstName, String lastName, String email,@JsonKey(name: 'phone', fromJson: _nullableStringToEmpty) String phoneNumber, String agencyName,@JsonKey(name: 'license_number') String fifaLicense,@JsonKey(name: 'avatar') String? avatarUrl, bool fifaCertified, DateTime? certificationDate,@JsonKey(name: 'certification_document_url', fromJson: _nullableStringToEmpty) String licenseFilePath, String country, String city,@JsonKey(unknownEnumValue: Status.pending) Status status
});




}
/// @nodoc
class __$AgentModelCopyWithImpl<$Res>
    implements _$AgentModelCopyWith<$Res> {
  __$AgentModelCopyWithImpl(this._self, this._then);

  final _AgentModel _self;
  final $Res Function(_AgentModel) _then;

/// Create a copy of AgentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? firstName = null,Object? lastName = null,Object? email = null,Object? phoneNumber = null,Object? agencyName = null,Object? fifaLicense = null,Object? avatarUrl = freezed,Object? fifaCertified = null,Object? certificationDate = freezed,Object? licenseFilePath = null,Object? country = null,Object? city = null,Object? status = null,}) {
  return _then(_AgentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as BigInt,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,agencyName: null == agencyName ? _self.agencyName : agencyName // ignore: cast_nullable_to_non_nullable
as String,fifaLicense: null == fifaLicense ? _self.fifaLicense : fifaLicense // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,fifaCertified: null == fifaCertified ? _self.fifaCertified : fifaCertified // ignore: cast_nullable_to_non_nullable
as bool,certificationDate: freezed == certificationDate ? _self.certificationDate : certificationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,licenseFilePath: null == licenseFilePath ? _self.licenseFilePath : licenseFilePath // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,
  ));
}


}

// dart format on
