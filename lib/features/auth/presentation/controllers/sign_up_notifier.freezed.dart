// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignUpState {

 String get firstName; String get lastName; String get email; String get phoneNumber; String get password; String get confirmPassword; String get agencyName; String get licenseNumber; String get licenseFilePath; bool get acceptedTerms;// Validation errors for each field, the below fields are required
@JsonKey(includeFromJson: false, includeToJson: false) Map<SignUpField, Option<String>> get validationErrors;
/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpStateCopyWith<SignUpState> get copyWith => _$SignUpStateCopyWithImpl<SignUpState>(this as SignUpState, _$identity);

  /// Serializes this SignUpState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpState&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.agencyName, agencyName) || other.agencyName == agencyName)&&(identical(other.licenseNumber, licenseNumber) || other.licenseNumber == licenseNumber)&&(identical(other.licenseFilePath, licenseFilePath) || other.licenseFilePath == licenseFilePath)&&(identical(other.acceptedTerms, acceptedTerms) || other.acceptedTerms == acceptedTerms)&&const DeepCollectionEquality().equals(other.validationErrors, validationErrors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,email,phoneNumber,password,confirmPassword,agencyName,licenseNumber,licenseFilePath,acceptedTerms,const DeepCollectionEquality().hash(validationErrors));

@override
String toString() {
  return 'SignUpState(firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, password: $password, confirmPassword: $confirmPassword, agencyName: $agencyName, licenseNumber: $licenseNumber, licenseFilePath: $licenseFilePath, acceptedTerms: $acceptedTerms, validationErrors: $validationErrors)';
}


}

/// @nodoc
abstract mixin class $SignUpStateCopyWith<$Res>  {
  factory $SignUpStateCopyWith(SignUpState value, $Res Function(SignUpState) _then) = _$SignUpStateCopyWithImpl;
@useResult
$Res call({
 String firstName, String lastName, String email, String phoneNumber, String password, String confirmPassword, String agencyName, String licenseNumber, String licenseFilePath, bool acceptedTerms,@JsonKey(includeFromJson: false, includeToJson: false) Map<SignUpField, Option<String>> validationErrors
});




}
/// @nodoc
class _$SignUpStateCopyWithImpl<$Res>
    implements $SignUpStateCopyWith<$Res> {
  _$SignUpStateCopyWithImpl(this._self, this._then);

  final SignUpState _self;
  final $Res Function(SignUpState) _then;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = null,Object? lastName = null,Object? email = null,Object? phoneNumber = null,Object? password = null,Object? confirmPassword = null,Object? agencyName = null,Object? licenseNumber = null,Object? licenseFilePath = null,Object? acceptedTerms = null,Object? validationErrors = null,}) {
  return _then(_self.copyWith(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,agencyName: null == agencyName ? _self.agencyName : agencyName // ignore: cast_nullable_to_non_nullable
as String,licenseNumber: null == licenseNumber ? _self.licenseNumber : licenseNumber // ignore: cast_nullable_to_non_nullable
as String,licenseFilePath: null == licenseFilePath ? _self.licenseFilePath : licenseFilePath // ignore: cast_nullable_to_non_nullable
as String,acceptedTerms: null == acceptedTerms ? _self.acceptedTerms : acceptedTerms // ignore: cast_nullable_to_non_nullable
as bool,validationErrors: null == validationErrors ? _self.validationErrors : validationErrors // ignore: cast_nullable_to_non_nullable
as Map<SignUpField, Option<String>>,
  ));
}

}


/// Adds pattern-matching-related methods to [SignUpState].
extension SignUpStatePatterns on SignUpState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignUpState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignUpState value)  $default,){
final _that = this;
switch (_that) {
case _SignUpState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignUpState value)?  $default,){
final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String firstName,  String lastName,  String email,  String phoneNumber,  String password,  String confirmPassword,  String agencyName,  String licenseNumber,  String licenseFilePath,  bool acceptedTerms, @JsonKey(includeFromJson: false, includeToJson: false)  Map<SignUpField, Option<String>> validationErrors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
return $default(_that.firstName,_that.lastName,_that.email,_that.phoneNumber,_that.password,_that.confirmPassword,_that.agencyName,_that.licenseNumber,_that.licenseFilePath,_that.acceptedTerms,_that.validationErrors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String firstName,  String lastName,  String email,  String phoneNumber,  String password,  String confirmPassword,  String agencyName,  String licenseNumber,  String licenseFilePath,  bool acceptedTerms, @JsonKey(includeFromJson: false, includeToJson: false)  Map<SignUpField, Option<String>> validationErrors)  $default,) {final _that = this;
switch (_that) {
case _SignUpState():
return $default(_that.firstName,_that.lastName,_that.email,_that.phoneNumber,_that.password,_that.confirmPassword,_that.agencyName,_that.licenseNumber,_that.licenseFilePath,_that.acceptedTerms,_that.validationErrors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String firstName,  String lastName,  String email,  String phoneNumber,  String password,  String confirmPassword,  String agencyName,  String licenseNumber,  String licenseFilePath,  bool acceptedTerms, @JsonKey(includeFromJson: false, includeToJson: false)  Map<SignUpField, Option<String>> validationErrors)?  $default,) {final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
return $default(_that.firstName,_that.lastName,_that.email,_that.phoneNumber,_that.password,_that.confirmPassword,_that.agencyName,_that.licenseNumber,_that.licenseFilePath,_that.acceptedTerms,_that.validationErrors);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignUpState implements SignUpState {
  const _SignUpState({this.firstName = '', this.lastName = '', this.email = '', this.phoneNumber = '', this.password = '', this.confirmPassword = '', this.agencyName = '', this.licenseNumber = '', this.licenseFilePath = '', this.acceptedTerms = false, @JsonKey(includeFromJson: false, includeToJson: false) final  Map<SignUpField, Option<String>> validationErrors = const {SignUpField.firstName : None(), SignUpField.lastName : None(), SignUpField.email : None(), SignUpField.phoneNumber : None(), SignUpField.password : None(), SignUpField.confirmPassword : None(), SignUpField.agencyName : None()}}): _validationErrors = validationErrors;
  factory _SignUpState.fromJson(Map<String, dynamic> json) => _$SignUpStateFromJson(json);

@override@JsonKey() final  String firstName;
@override@JsonKey() final  String lastName;
@override@JsonKey() final  String email;
@override@JsonKey() final  String phoneNumber;
@override@JsonKey() final  String password;
@override@JsonKey() final  String confirmPassword;
@override@JsonKey() final  String agencyName;
@override@JsonKey() final  String licenseNumber;
@override@JsonKey() final  String licenseFilePath;
@override@JsonKey() final  bool acceptedTerms;
// Validation errors for each field, the below fields are required
 final  Map<SignUpField, Option<String>> _validationErrors;
// Validation errors for each field, the below fields are required
@override@JsonKey(includeFromJson: false, includeToJson: false) Map<SignUpField, Option<String>> get validationErrors {
  if (_validationErrors is EqualUnmodifiableMapView) return _validationErrors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_validationErrors);
}


/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignUpStateCopyWith<_SignUpState> get copyWith => __$SignUpStateCopyWithImpl<_SignUpState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignUpStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignUpState&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.agencyName, agencyName) || other.agencyName == agencyName)&&(identical(other.licenseNumber, licenseNumber) || other.licenseNumber == licenseNumber)&&(identical(other.licenseFilePath, licenseFilePath) || other.licenseFilePath == licenseFilePath)&&(identical(other.acceptedTerms, acceptedTerms) || other.acceptedTerms == acceptedTerms)&&const DeepCollectionEquality().equals(other._validationErrors, _validationErrors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,email,phoneNumber,password,confirmPassword,agencyName,licenseNumber,licenseFilePath,acceptedTerms,const DeepCollectionEquality().hash(_validationErrors));

@override
String toString() {
  return 'SignUpState(firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, password: $password, confirmPassword: $confirmPassword, agencyName: $agencyName, licenseNumber: $licenseNumber, licenseFilePath: $licenseFilePath, acceptedTerms: $acceptedTerms, validationErrors: $validationErrors)';
}


}

/// @nodoc
abstract mixin class _$SignUpStateCopyWith<$Res> implements $SignUpStateCopyWith<$Res> {
  factory _$SignUpStateCopyWith(_SignUpState value, $Res Function(_SignUpState) _then) = __$SignUpStateCopyWithImpl;
@override @useResult
$Res call({
 String firstName, String lastName, String email, String phoneNumber, String password, String confirmPassword, String agencyName, String licenseNumber, String licenseFilePath, bool acceptedTerms,@JsonKey(includeFromJson: false, includeToJson: false) Map<SignUpField, Option<String>> validationErrors
});




}
/// @nodoc
class __$SignUpStateCopyWithImpl<$Res>
    implements _$SignUpStateCopyWith<$Res> {
  __$SignUpStateCopyWithImpl(this._self, this._then);

  final _SignUpState _self;
  final $Res Function(_SignUpState) _then;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? lastName = null,Object? email = null,Object? phoneNumber = null,Object? password = null,Object? confirmPassword = null,Object? agencyName = null,Object? licenseNumber = null,Object? licenseFilePath = null,Object? acceptedTerms = null,Object? validationErrors = null,}) {
  return _then(_SignUpState(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,agencyName: null == agencyName ? _self.agencyName : agencyName // ignore: cast_nullable_to_non_nullable
as String,licenseNumber: null == licenseNumber ? _self.licenseNumber : licenseNumber // ignore: cast_nullable_to_non_nullable
as String,licenseFilePath: null == licenseFilePath ? _self.licenseFilePath : licenseFilePath // ignore: cast_nullable_to_non_nullable
as String,acceptedTerms: null == acceptedTerms ? _self.acceptedTerms : acceptedTerms // ignore: cast_nullable_to_non_nullable
as bool,validationErrors: null == validationErrors ? _self._validationErrors : validationErrors // ignore: cast_nullable_to_non_nullable
as Map<SignUpField, Option<String>>,
  ));
}


}

// dart format on
