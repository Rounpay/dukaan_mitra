// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserData {

@JsonKey(name: 'accessToken') String? get accessToken;@JsonKey(name: 'refreshToken') String? get refreshToken;@JsonKey(name: 'expiresAt') String? get expiresAt;@JsonKey(name: 'resetRequired') bool? get resetRequired;@JsonKey(name: 'role') String? get role;@JsonKey(name: 'roleId') int? get roleId;
/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserDataCopyWith<UserData> get copyWith => _$UserDataCopyWithImpl<UserData>(this as UserData, _$identity);

  /// Serializes this UserData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserData&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.resetRequired, resetRequired) || other.resetRequired == resetRequired)&&(identical(other.role, role) || other.role == role)&&(identical(other.roleId, roleId) || other.roleId == roleId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken,expiresAt,resetRequired,role,roleId);

@override
String toString() {
  return 'UserData(accessToken: $accessToken, refreshToken: $refreshToken, expiresAt: $expiresAt, resetRequired: $resetRequired, role: $role, roleId: $roleId)';
}


}

/// @nodoc
abstract mixin class $UserDataCopyWith<$Res>  {
  factory $UserDataCopyWith(UserData value, $Res Function(UserData) _then) = _$UserDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'accessToken') String? accessToken,@JsonKey(name: 'refreshToken') String? refreshToken,@JsonKey(name: 'expiresAt') String? expiresAt,@JsonKey(name: 'resetRequired') bool? resetRequired,@JsonKey(name: 'role') String? role,@JsonKey(name: 'roleId') int? roleId
});




}
/// @nodoc
class _$UserDataCopyWithImpl<$Res>
    implements $UserDataCopyWith<$Res> {
  _$UserDataCopyWithImpl(this._self, this._then);

  final UserData _self;
  final $Res Function(UserData) _then;

/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = freezed,Object? refreshToken = freezed,Object? expiresAt = freezed,Object? resetRequired = freezed,Object? role = freezed,Object? roleId = freezed,}) {
  return _then(_self.copyWith(
accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,resetRequired: freezed == resetRequired ? _self.resetRequired : resetRequired // ignore: cast_nullable_to_non_nullable
as bool?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,roleId: freezed == roleId ? _self.roleId : roleId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserData].
extension UserDataPatterns on UserData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserData value)  $default,){
final _that = this;
switch (_that) {
case _UserData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserData value)?  $default,){
final _that = this;
switch (_that) {
case _UserData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'accessToken')  String? accessToken, @JsonKey(name: 'refreshToken')  String? refreshToken, @JsonKey(name: 'expiresAt')  String? expiresAt, @JsonKey(name: 'resetRequired')  bool? resetRequired, @JsonKey(name: 'role')  String? role, @JsonKey(name: 'roleId')  int? roleId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserData() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.expiresAt,_that.resetRequired,_that.role,_that.roleId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'accessToken')  String? accessToken, @JsonKey(name: 'refreshToken')  String? refreshToken, @JsonKey(name: 'expiresAt')  String? expiresAt, @JsonKey(name: 'resetRequired')  bool? resetRequired, @JsonKey(name: 'role')  String? role, @JsonKey(name: 'roleId')  int? roleId)  $default,) {final _that = this;
switch (_that) {
case _UserData():
return $default(_that.accessToken,_that.refreshToken,_that.expiresAt,_that.resetRequired,_that.role,_that.roleId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'accessToken')  String? accessToken, @JsonKey(name: 'refreshToken')  String? refreshToken, @JsonKey(name: 'expiresAt')  String? expiresAt, @JsonKey(name: 'resetRequired')  bool? resetRequired, @JsonKey(name: 'role')  String? role, @JsonKey(name: 'roleId')  int? roleId)?  $default,) {final _that = this;
switch (_that) {
case _UserData() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.expiresAt,_that.resetRequired,_that.role,_that.roleId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserData implements UserData {
  const _UserData({@JsonKey(name: 'accessToken') this.accessToken, @JsonKey(name: 'refreshToken') this.refreshToken, @JsonKey(name: 'expiresAt') this.expiresAt, @JsonKey(name: 'resetRequired') this.resetRequired, @JsonKey(name: 'role') this.role, @JsonKey(name: 'roleId') this.roleId});
  factory _UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);

@override@JsonKey(name: 'accessToken') final  String? accessToken;
@override@JsonKey(name: 'refreshToken') final  String? refreshToken;
@override@JsonKey(name: 'expiresAt') final  String? expiresAt;
@override@JsonKey(name: 'resetRequired') final  bool? resetRequired;
@override@JsonKey(name: 'role') final  String? role;
@override@JsonKey(name: 'roleId') final  int? roleId;

/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserDataCopyWith<_UserData> get copyWith => __$UserDataCopyWithImpl<_UserData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserData&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.resetRequired, resetRequired) || other.resetRequired == resetRequired)&&(identical(other.role, role) || other.role == role)&&(identical(other.roleId, roleId) || other.roleId == roleId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken,expiresAt,resetRequired,role,roleId);

@override
String toString() {
  return 'UserData(accessToken: $accessToken, refreshToken: $refreshToken, expiresAt: $expiresAt, resetRequired: $resetRequired, role: $role, roleId: $roleId)';
}


}

/// @nodoc
abstract mixin class _$UserDataCopyWith<$Res> implements $UserDataCopyWith<$Res> {
  factory _$UserDataCopyWith(_UserData value, $Res Function(_UserData) _then) = __$UserDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'accessToken') String? accessToken,@JsonKey(name: 'refreshToken') String? refreshToken,@JsonKey(name: 'expiresAt') String? expiresAt,@JsonKey(name: 'resetRequired') bool? resetRequired,@JsonKey(name: 'role') String? role,@JsonKey(name: 'roleId') int? roleId
});




}
/// @nodoc
class __$UserDataCopyWithImpl<$Res>
    implements _$UserDataCopyWith<$Res> {
  __$UserDataCopyWithImpl(this._self, this._then);

  final _UserData _self;
  final $Res Function(_UserData) _then;

/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = freezed,Object? refreshToken = freezed,Object? expiresAt = freezed,Object? resetRequired = freezed,Object? role = freezed,Object? roleId = freezed,}) {
  return _then(_UserData(
accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,resetRequired: freezed == resetRequired ? _self.resetRequired : resetRequired // ignore: cast_nullable_to_non_nullable
as bool?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,roleId: freezed == roleId ? _self.roleId : roleId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
