// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignInState {

 String get email; String get password; bool get rememberMe;@JsonKey(includeFromJson: false, includeToJson: false) Map<SignInField, Option<String>> get validationErrors;
/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignInStateCopyWith<SignInState> get copyWith => _$SignInStateCopyWithImpl<SignInState>(this as SignInState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInState&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.rememberMe, rememberMe) || other.rememberMe == rememberMe)&&const DeepCollectionEquality().equals(other.validationErrors, validationErrors));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,rememberMe,const DeepCollectionEquality().hash(validationErrors));

@override
String toString() {
  return 'SignInState(email: $email, password: $password, rememberMe: $rememberMe, validationErrors: $validationErrors)';
}


}

/// @nodoc
abstract mixin class $SignInStateCopyWith<$Res>  {
  factory $SignInStateCopyWith(SignInState value, $Res Function(SignInState) _then) = _$SignInStateCopyWithImpl;
@useResult
$Res call({
 String email, String password, bool rememberMe,@JsonKey(includeFromJson: false, includeToJson: false) Map<SignInField, Option<String>> validationErrors
});




}
/// @nodoc
class _$SignInStateCopyWithImpl<$Res>
    implements $SignInStateCopyWith<$Res> {
  _$SignInStateCopyWithImpl(this._self, this._then);

  final SignInState _self;
  final $Res Function(SignInState) _then;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,Object? rememberMe = null,Object? validationErrors = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,rememberMe: null == rememberMe ? _self.rememberMe : rememberMe // ignore: cast_nullable_to_non_nullable
as bool,validationErrors: null == validationErrors ? _self.validationErrors : validationErrors // ignore: cast_nullable_to_non_nullable
as Map<SignInField, Option<String>>,
  ));
}

}


/// Adds pattern-matching-related methods to [SignInState].
extension SignInStatePatterns on SignInState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignInState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignInState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignInState value)  $default,){
final _that = this;
switch (_that) {
case _SignInState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignInState value)?  $default,){
final _that = this;
switch (_that) {
case _SignInState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String password,  bool rememberMe, @JsonKey(includeFromJson: false, includeToJson: false)  Map<SignInField, Option<String>> validationErrors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignInState() when $default != null:
return $default(_that.email,_that.password,_that.rememberMe,_that.validationErrors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String password,  bool rememberMe, @JsonKey(includeFromJson: false, includeToJson: false)  Map<SignInField, Option<String>> validationErrors)  $default,) {final _that = this;
switch (_that) {
case _SignInState():
return $default(_that.email,_that.password,_that.rememberMe,_that.validationErrors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String password,  bool rememberMe, @JsonKey(includeFromJson: false, includeToJson: false)  Map<SignInField, Option<String>> validationErrors)?  $default,) {final _that = this;
switch (_that) {
case _SignInState() when $default != null:
return $default(_that.email,_that.password,_that.rememberMe,_that.validationErrors);case _:
  return null;

}
}

}

/// @nodoc


class _SignInState implements SignInState {
  const _SignInState({this.email = '', this.password = '', this.rememberMe = false, @JsonKey(includeFromJson: false, includeToJson: false) final  Map<SignInField, Option<String>> validationErrors = const {SignInField.email : None(), SignInField.password : None()}}): _validationErrors = validationErrors;
  

@override@JsonKey() final  String email;
@override@JsonKey() final  String password;
@override@JsonKey() final  bool rememberMe;
 final  Map<SignInField, Option<String>> _validationErrors;
@override@JsonKey(includeFromJson: false, includeToJson: false) Map<SignInField, Option<String>> get validationErrors {
  if (_validationErrors is EqualUnmodifiableMapView) return _validationErrors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_validationErrors);
}


/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignInStateCopyWith<_SignInState> get copyWith => __$SignInStateCopyWithImpl<_SignInState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignInState&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.rememberMe, rememberMe) || other.rememberMe == rememberMe)&&const DeepCollectionEquality().equals(other._validationErrors, _validationErrors));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,rememberMe,const DeepCollectionEquality().hash(_validationErrors));

@override
String toString() {
  return 'SignInState(email: $email, password: $password, rememberMe: $rememberMe, validationErrors: $validationErrors)';
}


}

/// @nodoc
abstract mixin class _$SignInStateCopyWith<$Res> implements $SignInStateCopyWith<$Res> {
  factory _$SignInStateCopyWith(_SignInState value, $Res Function(_SignInState) _then) = __$SignInStateCopyWithImpl;
@override @useResult
$Res call({
 String email, String password, bool rememberMe,@JsonKey(includeFromJson: false, includeToJson: false) Map<SignInField, Option<String>> validationErrors
});




}
/// @nodoc
class __$SignInStateCopyWithImpl<$Res>
    implements _$SignInStateCopyWith<$Res> {
  __$SignInStateCopyWithImpl(this._self, this._then);

  final _SignInState _self;
  final $Res Function(_SignInState) _then;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? rememberMe = null,Object? validationErrors = null,}) {
  return _then(_SignInState(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,rememberMe: null == rememberMe ? _self.rememberMe : rememberMe // ignore: cast_nullable_to_non_nullable
as bool,validationErrors: null == validationErrors ? _self._validationErrors : validationErrors // ignore: cast_nullable_to_non_nullable
as Map<SignInField, Option<String>>,
  ));
}


}

// dart format on
