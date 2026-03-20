// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_res.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BaseDataRes<T> {

@JsonKey(name: 'success') bool? get success;@JsonKey(name: 'message') String? get message;@JsonKey(name: 'data') T? get data;
/// Create a copy of BaseDataRes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BaseDataResCopyWith<T, BaseDataRes<T>> get copyWith => _$BaseDataResCopyWithImpl<T, BaseDataRes<T>>(this as BaseDataRes<T>, _$identity);

  /// Serializes this BaseDataRes to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseDataRes<T>&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'BaseDataRes<$T>(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $BaseDataResCopyWith<T,$Res>  {
  factory $BaseDataResCopyWith(BaseDataRes<T> value, $Res Function(BaseDataRes<T>) _then) = _$BaseDataResCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'success') bool? success,@JsonKey(name: 'message') String? message,@JsonKey(name: 'data') T? data
});




}
/// @nodoc
class _$BaseDataResCopyWithImpl<T,$Res>
    implements $BaseDataResCopyWith<T, $Res> {
  _$BaseDataResCopyWithImpl(this._self, this._then);

  final BaseDataRes<T> _self;
  final $Res Function(BaseDataRes<T>) _then;

/// Create a copy of BaseDataRes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,
  ));
}

}


/// Adds pattern-matching-related methods to [BaseDataRes].
extension BaseDataResPatterns<T> on BaseDataRes<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BaseDataRes<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BaseDataRes() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BaseDataRes<T> value)  $default,){
final _that = this;
switch (_that) {
case _BaseDataRes():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BaseDataRes<T> value)?  $default,){
final _that = this;
switch (_that) {
case _BaseDataRes() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'success')  bool? success, @JsonKey(name: 'message')  String? message, @JsonKey(name: 'data')  T? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BaseDataRes() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'success')  bool? success, @JsonKey(name: 'message')  String? message, @JsonKey(name: 'data')  T? data)  $default,) {final _that = this;
switch (_that) {
case _BaseDataRes():
return $default(_that.success,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'success')  bool? success, @JsonKey(name: 'message')  String? message, @JsonKey(name: 'data')  T? data)?  $default,) {final _that = this;
switch (_that) {
case _BaseDataRes() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _BaseDataRes<T> implements BaseDataRes<T> {
  const _BaseDataRes({@JsonKey(name: 'success') this.success, @JsonKey(name: 'message') this.message, @JsonKey(name: 'data') this.data});
  factory _BaseDataRes.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$BaseDataResFromJson(json,fromJsonT);

@override@JsonKey(name: 'success') final  bool? success;
@override@JsonKey(name: 'message') final  String? message;
@override@JsonKey(name: 'data') final  T? data;

/// Create a copy of BaseDataRes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BaseDataResCopyWith<T, _BaseDataRes<T>> get copyWith => __$BaseDataResCopyWithImpl<T, _BaseDataRes<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$BaseDataResToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BaseDataRes<T>&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'BaseDataRes<$T>(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$BaseDataResCopyWith<T,$Res> implements $BaseDataResCopyWith<T, $Res> {
  factory _$BaseDataResCopyWith(_BaseDataRes<T> value, $Res Function(_BaseDataRes<T>) _then) = __$BaseDataResCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'success') bool? success,@JsonKey(name: 'message') String? message,@JsonKey(name: 'data') T? data
});




}
/// @nodoc
class __$BaseDataResCopyWithImpl<T,$Res>
    implements _$BaseDataResCopyWith<T, $Res> {
  __$BaseDataResCopyWithImpl(this._self, this._then);

  final _BaseDataRes<T> _self;
  final $Res Function(_BaseDataRes<T>) _then;

/// Create a copy of BaseDataRes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_BaseDataRes<T>(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,
  ));
}


}


/// @nodoc
mixin _$BaseRes {

@JsonKey(name: 'success') bool? get success;@JsonKey(name: 'message') String? get message;
/// Create a copy of BaseRes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BaseResCopyWith<BaseRes> get copyWith => _$BaseResCopyWithImpl<BaseRes>(this as BaseRes, _$identity);

  /// Serializes this BaseRes to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseRes&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message);

@override
String toString() {
  return 'BaseRes(success: $success, message: $message)';
}


}

/// @nodoc
abstract mixin class $BaseResCopyWith<$Res>  {
  factory $BaseResCopyWith(BaseRes value, $Res Function(BaseRes) _then) = _$BaseResCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'success') bool? success,@JsonKey(name: 'message') String? message
});




}
/// @nodoc
class _$BaseResCopyWithImpl<$Res>
    implements $BaseResCopyWith<$Res> {
  _$BaseResCopyWithImpl(this._self, this._then);

  final BaseRes _self;
  final $Res Function(BaseRes) _then;

/// Create a copy of BaseRes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BaseRes].
extension BaseResPatterns on BaseRes {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BaseRes value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BaseRes() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BaseRes value)  $default,){
final _that = this;
switch (_that) {
case _BaseRes():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BaseRes value)?  $default,){
final _that = this;
switch (_that) {
case _BaseRes() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'success')  bool? success, @JsonKey(name: 'message')  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BaseRes() when $default != null:
return $default(_that.success,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'success')  bool? success, @JsonKey(name: 'message')  String? message)  $default,) {final _that = this;
switch (_that) {
case _BaseRes():
return $default(_that.success,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'success')  bool? success, @JsonKey(name: 'message')  String? message)?  $default,) {final _that = this;
switch (_that) {
case _BaseRes() when $default != null:
return $default(_that.success,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BaseRes implements BaseRes {
  const _BaseRes({@JsonKey(name: 'success') this.success, @JsonKey(name: 'message') this.message});
  factory _BaseRes.fromJson(Map<String, dynamic> json) => _$BaseResFromJson(json);

@override@JsonKey(name: 'success') final  bool? success;
@override@JsonKey(name: 'message') final  String? message;

/// Create a copy of BaseRes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BaseResCopyWith<_BaseRes> get copyWith => __$BaseResCopyWithImpl<_BaseRes>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BaseResToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BaseRes&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message);

@override
String toString() {
  return 'BaseRes(success: $success, message: $message)';
}


}

/// @nodoc
abstract mixin class _$BaseResCopyWith<$Res> implements $BaseResCopyWith<$Res> {
  factory _$BaseResCopyWith(_BaseRes value, $Res Function(_BaseRes) _then) = __$BaseResCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'success') bool? success,@JsonKey(name: 'message') String? message
});




}
/// @nodoc
class __$BaseResCopyWithImpl<$Res>
    implements _$BaseResCopyWith<$Res> {
  __$BaseResCopyWithImpl(this._self, this._then);

  final _BaseRes _self;
  final $Res Function(_BaseRes) _then;

/// Create a copy of BaseRes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = freezed,Object? message = freezed,}) {
  return _then(_BaseRes(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
