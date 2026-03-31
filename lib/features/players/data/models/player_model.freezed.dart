// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlayerModel {

@JsonKey(fromJson: _idFromJson, toJson: _idToJson) BigInt get id; String get fullName;@JsonKey(unknownEnumValue: Position.forward) Position get position; String get nationalityCode; String get nationalityName; String get clubName; String get clubLogo; double get marketValue; double get overallRating;@JsonKey(name: 'photo') String get photoUrl; int get age; String? get agentName; int? get agentId;
/// Create a copy of PlayerModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerModelCopyWith<PlayerModel> get copyWith => _$PlayerModelCopyWithImpl<PlayerModel>(this as PlayerModel, _$identity);

  /// Serializes this PlayerModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerModel&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.position, position) || other.position == position)&&(identical(other.nationalityCode, nationalityCode) || other.nationalityCode == nationalityCode)&&(identical(other.nationalityName, nationalityName) || other.nationalityName == nationalityName)&&(identical(other.clubName, clubName) || other.clubName == clubName)&&(identical(other.clubLogo, clubLogo) || other.clubLogo == clubLogo)&&(identical(other.marketValue, marketValue) || other.marketValue == marketValue)&&(identical(other.overallRating, overallRating) || other.overallRating == overallRating)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.age, age) || other.age == age)&&(identical(other.agentName, agentName) || other.agentName == agentName)&&(identical(other.agentId, agentId) || other.agentId == agentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,position,nationalityCode,nationalityName,clubName,clubLogo,marketValue,overallRating,photoUrl,age,agentName,agentId);

@override
String toString() {
  return 'PlayerModel(id: $id, fullName: $fullName, position: $position, nationalityCode: $nationalityCode, nationalityName: $nationalityName, clubName: $clubName, clubLogo: $clubLogo, marketValue: $marketValue, overallRating: $overallRating, photoUrl: $photoUrl, age: $age, agentName: $agentName, agentId: $agentId)';
}


}

/// @nodoc
abstract mixin class $PlayerModelCopyWith<$Res>  {
  factory $PlayerModelCopyWith(PlayerModel value, $Res Function(PlayerModel) _then) = _$PlayerModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _idFromJson, toJson: _idToJson) BigInt id, String fullName,@JsonKey(unknownEnumValue: Position.forward) Position position, String nationalityCode, String nationalityName, String clubName, String clubLogo, double marketValue, double overallRating,@JsonKey(name: 'photo') String photoUrl, int age, String? agentName, int? agentId
});




}
/// @nodoc
class _$PlayerModelCopyWithImpl<$Res>
    implements $PlayerModelCopyWith<$Res> {
  _$PlayerModelCopyWithImpl(this._self, this._then);

  final PlayerModel _self;
  final $Res Function(PlayerModel) _then;

/// Create a copy of PlayerModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? position = null,Object? nationalityCode = null,Object? nationalityName = null,Object? clubName = null,Object? clubLogo = null,Object? marketValue = null,Object? overallRating = null,Object? photoUrl = null,Object? age = null,Object? agentName = freezed,Object? agentId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as BigInt,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Position,nationalityCode: null == nationalityCode ? _self.nationalityCode : nationalityCode // ignore: cast_nullable_to_non_nullable
as String,nationalityName: null == nationalityName ? _self.nationalityName : nationalityName // ignore: cast_nullable_to_non_nullable
as String,clubName: null == clubName ? _self.clubName : clubName // ignore: cast_nullable_to_non_nullable
as String,clubLogo: null == clubLogo ? _self.clubLogo : clubLogo // ignore: cast_nullable_to_non_nullable
as String,marketValue: null == marketValue ? _self.marketValue : marketValue // ignore: cast_nullable_to_non_nullable
as double,overallRating: null == overallRating ? _self.overallRating : overallRating // ignore: cast_nullable_to_non_nullable
as double,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,agentName: freezed == agentName ? _self.agentName : agentName // ignore: cast_nullable_to_non_nullable
as String?,agentId: freezed == agentId ? _self.agentId : agentId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerModel].
extension PlayerModelPatterns on PlayerModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerModel value)  $default,){
final _that = this;
switch (_that) {
case _PlayerModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerModel value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _idFromJson, toJson: _idToJson)  BigInt id,  String fullName, @JsonKey(unknownEnumValue: Position.forward)  Position position,  String nationalityCode,  String nationalityName,  String clubName,  String clubLogo,  double marketValue,  double overallRating, @JsonKey(name: 'photo')  String photoUrl,  int age,  String? agentName,  int? agentId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerModel() when $default != null:
return $default(_that.id,_that.fullName,_that.position,_that.nationalityCode,_that.nationalityName,_that.clubName,_that.clubLogo,_that.marketValue,_that.overallRating,_that.photoUrl,_that.age,_that.agentName,_that.agentId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _idFromJson, toJson: _idToJson)  BigInt id,  String fullName, @JsonKey(unknownEnumValue: Position.forward)  Position position,  String nationalityCode,  String nationalityName,  String clubName,  String clubLogo,  double marketValue,  double overallRating, @JsonKey(name: 'photo')  String photoUrl,  int age,  String? agentName,  int? agentId)  $default,) {final _that = this;
switch (_that) {
case _PlayerModel():
return $default(_that.id,_that.fullName,_that.position,_that.nationalityCode,_that.nationalityName,_that.clubName,_that.clubLogo,_that.marketValue,_that.overallRating,_that.photoUrl,_that.age,_that.agentName,_that.agentId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _idFromJson, toJson: _idToJson)  BigInt id,  String fullName, @JsonKey(unknownEnumValue: Position.forward)  Position position,  String nationalityCode,  String nationalityName,  String clubName,  String clubLogo,  double marketValue,  double overallRating, @JsonKey(name: 'photo')  String photoUrl,  int age,  String? agentName,  int? agentId)?  $default,) {final _that = this;
switch (_that) {
case _PlayerModel() when $default != null:
return $default(_that.id,_that.fullName,_that.position,_that.nationalityCode,_that.nationalityName,_that.clubName,_that.clubLogo,_that.marketValue,_that.overallRating,_that.photoUrl,_that.age,_that.agentName,_that.agentId);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _PlayerModel implements PlayerModel {
  const _PlayerModel({@JsonKey(fromJson: _idFromJson, toJson: _idToJson) required this.id, required this.fullName, @JsonKey(unknownEnumValue: Position.forward) required this.position, required this.nationalityCode, required this.nationalityName, required this.clubName, required this.clubLogo, required this.marketValue, required this.overallRating, @JsonKey(name: 'photo') required this.photoUrl, required this.age, this.agentName, this.agentId});
  factory _PlayerModel.fromJson(Map<String, dynamic> json) => _$PlayerModelFromJson(json);

@override@JsonKey(fromJson: _idFromJson, toJson: _idToJson) final  BigInt id;
@override final  String fullName;
@override@JsonKey(unknownEnumValue: Position.forward) final  Position position;
@override final  String nationalityCode;
@override final  String nationalityName;
@override final  String clubName;
@override final  String clubLogo;
@override final  double marketValue;
@override final  double overallRating;
@override@JsonKey(name: 'photo') final  String photoUrl;
@override final  int age;
@override final  String? agentName;
@override final  int? agentId;

/// Create a copy of PlayerModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerModelCopyWith<_PlayerModel> get copyWith => __$PlayerModelCopyWithImpl<_PlayerModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerModel&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.position, position) || other.position == position)&&(identical(other.nationalityCode, nationalityCode) || other.nationalityCode == nationalityCode)&&(identical(other.nationalityName, nationalityName) || other.nationalityName == nationalityName)&&(identical(other.clubName, clubName) || other.clubName == clubName)&&(identical(other.clubLogo, clubLogo) || other.clubLogo == clubLogo)&&(identical(other.marketValue, marketValue) || other.marketValue == marketValue)&&(identical(other.overallRating, overallRating) || other.overallRating == overallRating)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.age, age) || other.age == age)&&(identical(other.agentName, agentName) || other.agentName == agentName)&&(identical(other.agentId, agentId) || other.agentId == agentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,position,nationalityCode,nationalityName,clubName,clubLogo,marketValue,overallRating,photoUrl,age,agentName,agentId);

@override
String toString() {
  return 'PlayerModel(id: $id, fullName: $fullName, position: $position, nationalityCode: $nationalityCode, nationalityName: $nationalityName, clubName: $clubName, clubLogo: $clubLogo, marketValue: $marketValue, overallRating: $overallRating, photoUrl: $photoUrl, age: $age, agentName: $agentName, agentId: $agentId)';
}


}

/// @nodoc
abstract mixin class _$PlayerModelCopyWith<$Res> implements $PlayerModelCopyWith<$Res> {
  factory _$PlayerModelCopyWith(_PlayerModel value, $Res Function(_PlayerModel) _then) = __$PlayerModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _idFromJson, toJson: _idToJson) BigInt id, String fullName,@JsonKey(unknownEnumValue: Position.forward) Position position, String nationalityCode, String nationalityName, String clubName, String clubLogo, double marketValue, double overallRating,@JsonKey(name: 'photo') String photoUrl, int age, String? agentName, int? agentId
});




}
/// @nodoc
class __$PlayerModelCopyWithImpl<$Res>
    implements _$PlayerModelCopyWith<$Res> {
  __$PlayerModelCopyWithImpl(this._self, this._then);

  final _PlayerModel _self;
  final $Res Function(_PlayerModel) _then;

/// Create a copy of PlayerModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? position = null,Object? nationalityCode = null,Object? nationalityName = null,Object? clubName = null,Object? clubLogo = null,Object? marketValue = null,Object? overallRating = null,Object? photoUrl = null,Object? age = null,Object? agentName = freezed,Object? agentId = freezed,}) {
  return _then(_PlayerModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as BigInt,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Position,nationalityCode: null == nationalityCode ? _self.nationalityCode : nationalityCode // ignore: cast_nullable_to_non_nullable
as String,nationalityName: null == nationalityName ? _self.nationalityName : nationalityName // ignore: cast_nullable_to_non_nullable
as String,clubName: null == clubName ? _self.clubName : clubName // ignore: cast_nullable_to_non_nullable
as String,clubLogo: null == clubLogo ? _self.clubLogo : clubLogo // ignore: cast_nullable_to_non_nullable
as String,marketValue: null == marketValue ? _self.marketValue : marketValue // ignore: cast_nullable_to_non_nullable
as double,overallRating: null == overallRating ? _self.overallRating : overallRating // ignore: cast_nullable_to_non_nullable
as double,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,agentName: freezed == agentName ? _self.agentName : agentName // ignore: cast_nullable_to_non_nullable
as String?,agentId: freezed == agentId ? _self.agentId : agentId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
