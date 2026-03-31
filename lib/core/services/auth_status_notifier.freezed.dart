// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_status_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Unauthenticated value)?  unauthenticated,TResult Function( _Authenticated value)?  authenticated,TResult Function( _Blocked value)?  blocked,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Unauthenticated() when unauthenticated != null:
return unauthenticated(_that);case _Authenticated() when authenticated != null:
return authenticated(_that);case _Blocked() when blocked != null:
return blocked(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Unauthenticated value)  unauthenticated,required TResult Function( _Authenticated value)  authenticated,required TResult Function( _Blocked value)  blocked,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Unauthenticated():
return unauthenticated(_that);case _Authenticated():
return authenticated(_that);case _Blocked():
return blocked(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Unauthenticated value)?  unauthenticated,TResult? Function( _Authenticated value)?  authenticated,TResult? Function( _Blocked value)?  blocked,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Unauthenticated() when unauthenticated != null:
return unauthenticated(_that);case _Authenticated() when authenticated != null:
return authenticated(_that);case _Blocked() when blocked != null:
return blocked(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( String? message)?  unauthenticated,TResult Function( Agent agent)?  authenticated,TResult Function( String message,  String reason)?  blocked,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Unauthenticated() when unauthenticated != null:
return unauthenticated(_that.message);case _Authenticated() when authenticated != null:
return authenticated(_that.agent);case _Blocked() when blocked != null:
return blocked(_that.message,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( String? message)  unauthenticated,required TResult Function( Agent agent)  authenticated,required TResult Function( String message,  String reason)  blocked,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Unauthenticated():
return unauthenticated(_that.message);case _Authenticated():
return authenticated(_that.agent);case _Blocked():
return blocked(_that.message,_that.reason);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( String? message)?  unauthenticated,TResult? Function( Agent agent)?  authenticated,TResult? Function( String message,  String reason)?  blocked,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Unauthenticated() when unauthenticated != null:
return unauthenticated(_that.message);case _Authenticated() when authenticated != null:
return authenticated(_that.agent);case _Blocked() when blocked != null:
return blocked(_that.message,_that.reason);case _:
  return null;

}
}

}

/// @nodoc


class _Initial with DiagnosticableTreeMixin implements AuthState {
  const _Initial();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthState.initial'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthState.initial()';
}


}




/// @nodoc


class _Unauthenticated with DiagnosticableTreeMixin implements AuthState {
  const _Unauthenticated({this.message});
  

 final  String? message;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnauthenticatedCopyWith<_Unauthenticated> get copyWith => __$UnauthenticatedCopyWithImpl<_Unauthenticated>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthState.unauthenticated'))
    ..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Unauthenticated&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthState.unauthenticated(message: $message)';
}


}

/// @nodoc
abstract mixin class _$UnauthenticatedCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$UnauthenticatedCopyWith(_Unauthenticated value, $Res Function(_Unauthenticated) _then) = __$UnauthenticatedCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class __$UnauthenticatedCopyWithImpl<$Res>
    implements _$UnauthenticatedCopyWith<$Res> {
  __$UnauthenticatedCopyWithImpl(this._self, this._then);

  final _Unauthenticated _self;
  final $Res Function(_Unauthenticated) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(_Unauthenticated(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Authenticated with DiagnosticableTreeMixin implements AuthState {
  const _Authenticated(this.agent);
  

 final  Agent agent;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthenticatedCopyWith<_Authenticated> get copyWith => __$AuthenticatedCopyWithImpl<_Authenticated>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthState.authenticated'))
    ..add(DiagnosticsProperty('agent', agent));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Authenticated&&(identical(other.agent, agent) || other.agent == agent));
}


@override
int get hashCode => Object.hash(runtimeType,agent);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthState.authenticated(agent: $agent)';
}


}

/// @nodoc
abstract mixin class _$AuthenticatedCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthenticatedCopyWith(_Authenticated value, $Res Function(_Authenticated) _then) = __$AuthenticatedCopyWithImpl;
@useResult
$Res call({
 Agent agent
});




}
/// @nodoc
class __$AuthenticatedCopyWithImpl<$Res>
    implements _$AuthenticatedCopyWith<$Res> {
  __$AuthenticatedCopyWithImpl(this._self, this._then);

  final _Authenticated _self;
  final $Res Function(_Authenticated) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? agent = null,}) {
  return _then(_Authenticated(
null == agent ? _self.agent : agent // ignore: cast_nullable_to_non_nullable
as Agent,
  ));
}


}

/// @nodoc


class _Blocked with DiagnosticableTreeMixin implements AuthState {
  const _Blocked(this.message, this.reason);
  

 final  String message;
 final  String reason;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlockedCopyWith<_Blocked> get copyWith => __$BlockedCopyWithImpl<_Blocked>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthState.blocked'))
    ..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('reason', reason));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Blocked&&(identical(other.message, message) || other.message == message)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,message,reason);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthState.blocked(message: $message, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$BlockedCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$BlockedCopyWith(_Blocked value, $Res Function(_Blocked) _then) = __$BlockedCopyWithImpl;
@useResult
$Res call({
 String message, String reason
});




}
/// @nodoc
class __$BlockedCopyWithImpl<$Res>
    implements _$BlockedCopyWith<$Res> {
  __$BlockedCopyWithImpl(this._self, this._then);

  final _Blocked _self;
  final $Res Function(_Blocked) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? reason = null,}) {
  return _then(_Blocked(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
