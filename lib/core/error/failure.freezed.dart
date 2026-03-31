// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Failure {

 String get message;
/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureCopyWith<Failure> get copyWith => _$FailureCopyWithImpl<Failure>(this as Failure, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $FailureCopyWith<$Res>  {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) _then) = _$FailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$FailureCopyWithImpl<$Res>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._self, this._then);

  final Failure _self;
  final $Res Function(Failure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Failure].
extension FailurePatterns on Failure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ServerFailure value)?  serverFailure,TResult Function( UnauthorizedFailure value)?  unauthorizedFailure,TResult Function( CacheFailure value)?  cacheFailure,TResult Function( NetworkFailure value)?  networkFailure,TResult Function( PlatformFailure value)?  platformFailure,TResult Function( InvalidInputFailure value)?  invalidInputFailure,TResult Function( RateLimitFailure value)?  rateLimitFailure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ServerFailure() when serverFailure != null:
return serverFailure(_that);case UnauthorizedFailure() when unauthorizedFailure != null:
return unauthorizedFailure(_that);case CacheFailure() when cacheFailure != null:
return cacheFailure(_that);case NetworkFailure() when networkFailure != null:
return networkFailure(_that);case PlatformFailure() when platformFailure != null:
return platformFailure(_that);case InvalidInputFailure() when invalidInputFailure != null:
return invalidInputFailure(_that);case RateLimitFailure() when rateLimitFailure != null:
return rateLimitFailure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ServerFailure value)  serverFailure,required TResult Function( UnauthorizedFailure value)  unauthorizedFailure,required TResult Function( CacheFailure value)  cacheFailure,required TResult Function( NetworkFailure value)  networkFailure,required TResult Function( PlatformFailure value)  platformFailure,required TResult Function( InvalidInputFailure value)  invalidInputFailure,required TResult Function( RateLimitFailure value)  rateLimitFailure,}){
final _that = this;
switch (_that) {
case ServerFailure():
return serverFailure(_that);case UnauthorizedFailure():
return unauthorizedFailure(_that);case CacheFailure():
return cacheFailure(_that);case NetworkFailure():
return networkFailure(_that);case PlatformFailure():
return platformFailure(_that);case InvalidInputFailure():
return invalidInputFailure(_that);case RateLimitFailure():
return rateLimitFailure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ServerFailure value)?  serverFailure,TResult? Function( UnauthorizedFailure value)?  unauthorizedFailure,TResult? Function( CacheFailure value)?  cacheFailure,TResult? Function( NetworkFailure value)?  networkFailure,TResult? Function( PlatformFailure value)?  platformFailure,TResult? Function( InvalidInputFailure value)?  invalidInputFailure,TResult? Function( RateLimitFailure value)?  rateLimitFailure,}){
final _that = this;
switch (_that) {
case ServerFailure() when serverFailure != null:
return serverFailure(_that);case UnauthorizedFailure() when unauthorizedFailure != null:
return unauthorizedFailure(_that);case CacheFailure() when cacheFailure != null:
return cacheFailure(_that);case NetworkFailure() when networkFailure != null:
return networkFailure(_that);case PlatformFailure() when platformFailure != null:
return platformFailure(_that);case InvalidInputFailure() when invalidInputFailure != null:
return invalidInputFailure(_that);case RateLimitFailure() when rateLimitFailure != null:
return rateLimitFailure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message,  SignUpField? field)?  serverFailure,TResult Function( String message,  String reason,  Status status)?  unauthorizedFailure,TResult Function( String message)?  cacheFailure,TResult Function( String message)?  networkFailure,TResult Function( String message)?  platformFailure,TResult Function( String message)?  invalidInputFailure,TResult Function( String message,  int coolDownSeconds)?  rateLimitFailure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ServerFailure() when serverFailure != null:
return serverFailure(_that.message,_that.field);case UnauthorizedFailure() when unauthorizedFailure != null:
return unauthorizedFailure(_that.message,_that.reason,_that.status);case CacheFailure() when cacheFailure != null:
return cacheFailure(_that.message);case NetworkFailure() when networkFailure != null:
return networkFailure(_that.message);case PlatformFailure() when platformFailure != null:
return platformFailure(_that.message);case InvalidInputFailure() when invalidInputFailure != null:
return invalidInputFailure(_that.message);case RateLimitFailure() when rateLimitFailure != null:
return rateLimitFailure(_that.message,_that.coolDownSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message,  SignUpField? field)  serverFailure,required TResult Function( String message,  String reason,  Status status)  unauthorizedFailure,required TResult Function( String message)  cacheFailure,required TResult Function( String message)  networkFailure,required TResult Function( String message)  platformFailure,required TResult Function( String message)  invalidInputFailure,required TResult Function( String message,  int coolDownSeconds)  rateLimitFailure,}) {final _that = this;
switch (_that) {
case ServerFailure():
return serverFailure(_that.message,_that.field);case UnauthorizedFailure():
return unauthorizedFailure(_that.message,_that.reason,_that.status);case CacheFailure():
return cacheFailure(_that.message);case NetworkFailure():
return networkFailure(_that.message);case PlatformFailure():
return platformFailure(_that.message);case InvalidInputFailure():
return invalidInputFailure(_that.message);case RateLimitFailure():
return rateLimitFailure(_that.message,_that.coolDownSeconds);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message,  SignUpField? field)?  serverFailure,TResult? Function( String message,  String reason,  Status status)?  unauthorizedFailure,TResult? Function( String message)?  cacheFailure,TResult? Function( String message)?  networkFailure,TResult? Function( String message)?  platformFailure,TResult? Function( String message)?  invalidInputFailure,TResult? Function( String message,  int coolDownSeconds)?  rateLimitFailure,}) {final _that = this;
switch (_that) {
case ServerFailure() when serverFailure != null:
return serverFailure(_that.message,_that.field);case UnauthorizedFailure() when unauthorizedFailure != null:
return unauthorizedFailure(_that.message,_that.reason,_that.status);case CacheFailure() when cacheFailure != null:
return cacheFailure(_that.message);case NetworkFailure() when networkFailure != null:
return networkFailure(_that.message);case PlatformFailure() when platformFailure != null:
return platformFailure(_that.message);case InvalidInputFailure() when invalidInputFailure != null:
return invalidInputFailure(_that.message);case RateLimitFailure() when rateLimitFailure != null:
return rateLimitFailure(_that.message,_that.coolDownSeconds);case _:
  return null;

}
}

}

/// @nodoc


class ServerFailure implements Failure {
  const ServerFailure({this.message = 'A server error occured', this.field});
  

@override@JsonKey() final  String message;
 final  SignUpField? field;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerFailureCopyWith<ServerFailure> get copyWith => _$ServerFailureCopyWithImpl<ServerFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.field, field) || other.field == field));
}


@override
int get hashCode => Object.hash(runtimeType,message,field);

@override
String toString() {
  return 'Failure.serverFailure(message: $message, field: $field)';
}


}

/// @nodoc
abstract mixin class $ServerFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ServerFailureCopyWith(ServerFailure value, $Res Function(ServerFailure) _then) = _$ServerFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, SignUpField? field
});




}
/// @nodoc
class _$ServerFailureCopyWithImpl<$Res>
    implements $ServerFailureCopyWith<$Res> {
  _$ServerFailureCopyWithImpl(this._self, this._then);

  final ServerFailure _self;
  final $Res Function(ServerFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? field = freezed,}) {
  return _then(ServerFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,field: freezed == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as SignUpField?,
  ));
}


}

/// @nodoc


class UnauthorizedFailure implements Failure {
  const UnauthorizedFailure({this.message = 'Unauthorized access', required this.reason, this.status = Status.pending});
  

@override@JsonKey() final  String message;
 final  String reason;
@JsonKey() final  Status status;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnauthorizedFailureCopyWith<UnauthorizedFailure> get copyWith => _$UnauthorizedFailureCopyWithImpl<UnauthorizedFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnauthorizedFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,message,reason,status);

@override
String toString() {
  return 'Failure.unauthorizedFailure(message: $message, reason: $reason, status: $status)';
}


}

/// @nodoc
abstract mixin class $UnauthorizedFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $UnauthorizedFailureCopyWith(UnauthorizedFailure value, $Res Function(UnauthorizedFailure) _then) = _$UnauthorizedFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, String reason, Status status
});




}
/// @nodoc
class _$UnauthorizedFailureCopyWithImpl<$Res>
    implements $UnauthorizedFailureCopyWith<$Res> {
  _$UnauthorizedFailureCopyWithImpl(this._self, this._then);

  final UnauthorizedFailure _self;
  final $Res Function(UnauthorizedFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? reason = null,Object? status = null,}) {
  return _then(UnauthorizedFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,
  ));
}


}

/// @nodoc


class CacheFailure implements Failure {
  const CacheFailure({this.message = 'No cached data found'});
  

@override@JsonKey() final  String message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CacheFailureCopyWith<CacheFailure> get copyWith => _$CacheFailureCopyWithImpl<CacheFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CacheFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.cacheFailure(message: $message)';
}


}

/// @nodoc
abstract mixin class $CacheFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $CacheFailureCopyWith(CacheFailure value, $Res Function(CacheFailure) _then) = _$CacheFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CacheFailureCopyWithImpl<$Res>
    implements $CacheFailureCopyWith<$Res> {
  _$CacheFailureCopyWithImpl(this._self, this._then);

  final CacheFailure _self;
  final $Res Function(CacheFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CacheFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class NetworkFailure implements Failure {
  const NetworkFailure({this.message = 'Please check your internet connection'});
  

@override@JsonKey() final  String message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkFailureCopyWith<NetworkFailure> get copyWith => _$NetworkFailureCopyWithImpl<NetworkFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.networkFailure(message: $message)';
}


}

/// @nodoc
abstract mixin class $NetworkFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $NetworkFailureCopyWith(NetworkFailure value, $Res Function(NetworkFailure) _then) = _$NetworkFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$NetworkFailureCopyWithImpl<$Res>
    implements $NetworkFailureCopyWith<$Res> {
  _$NetworkFailureCopyWithImpl(this._self, this._then);

  final NetworkFailure _self;
  final $Res Function(NetworkFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(NetworkFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PlatformFailure implements Failure {
  const PlatformFailure({this.message = 'A platform related error occurred'});
  

@override@JsonKey() final  String message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlatformFailureCopyWith<PlatformFailure> get copyWith => _$PlatformFailureCopyWithImpl<PlatformFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlatformFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.platformFailure(message: $message)';
}


}

/// @nodoc
abstract mixin class $PlatformFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $PlatformFailureCopyWith(PlatformFailure value, $Res Function(PlatformFailure) _then) = _$PlatformFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$PlatformFailureCopyWithImpl<$Res>
    implements $PlatformFailureCopyWith<$Res> {
  _$PlatformFailureCopyWithImpl(this._self, this._then);

  final PlatformFailure _self;
  final $Res Function(PlatformFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(PlatformFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class InvalidInputFailure implements Failure {
  const InvalidInputFailure({this.message = 'Invalid input - the number must be a positive integer or zero'});
  

@override@JsonKey() final  String message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvalidInputFailureCopyWith<InvalidInputFailure> get copyWith => _$InvalidInputFailureCopyWithImpl<InvalidInputFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidInputFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.invalidInputFailure(message: $message)';
}


}

/// @nodoc
abstract mixin class $InvalidInputFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $InvalidInputFailureCopyWith(InvalidInputFailure value, $Res Function(InvalidInputFailure) _then) = _$InvalidInputFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$InvalidInputFailureCopyWithImpl<$Res>
    implements $InvalidInputFailureCopyWith<$Res> {
  _$InvalidInputFailureCopyWithImpl(this._self, this._then);

  final InvalidInputFailure _self;
  final $Res Function(InvalidInputFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(InvalidInputFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RateLimitFailure implements Failure {
  const RateLimitFailure({this.message = 'Too many requests - please try again later', this.coolDownSeconds = 60});
  

@override@JsonKey() final  String message;
@JsonKey() final  int coolDownSeconds;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RateLimitFailureCopyWith<RateLimitFailure> get copyWith => _$RateLimitFailureCopyWithImpl<RateLimitFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RateLimitFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.coolDownSeconds, coolDownSeconds) || other.coolDownSeconds == coolDownSeconds));
}


@override
int get hashCode => Object.hash(runtimeType,message,coolDownSeconds);

@override
String toString() {
  return 'Failure.rateLimitFailure(message: $message, coolDownSeconds: $coolDownSeconds)';
}


}

/// @nodoc
abstract mixin class $RateLimitFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $RateLimitFailureCopyWith(RateLimitFailure value, $Res Function(RateLimitFailure) _then) = _$RateLimitFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, int coolDownSeconds
});




}
/// @nodoc
class _$RateLimitFailureCopyWithImpl<$Res>
    implements $RateLimitFailureCopyWith<$Res> {
  _$RateLimitFailureCopyWithImpl(this._self, this._then);

  final RateLimitFailure _self;
  final $Res Function(RateLimitFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? coolDownSeconds = null,}) {
  return _then(RateLimitFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,coolDownSeconds: null == coolDownSeconds ? _self.coolDownSeconds : coolDownSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
