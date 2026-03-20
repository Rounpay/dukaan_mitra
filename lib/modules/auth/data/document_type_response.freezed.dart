// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_type_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DocumentTypeResponse {

@JsonKey(name: 'documentTypeId') int? get documentTypeId;@JsonKey(name: 'documentName') String? get documentName;@JsonKey(name: 'isMandatory') bool? get isMandatory;@JsonKey(name: 'isActive') bool? get isActive;
/// Create a copy of DocumentTypeResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentTypeResponseCopyWith<DocumentTypeResponse> get copyWith => _$DocumentTypeResponseCopyWithImpl<DocumentTypeResponse>(this as DocumentTypeResponse, _$identity);

  /// Serializes this DocumentTypeResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentTypeResponse&&(identical(other.documentTypeId, documentTypeId) || other.documentTypeId == documentTypeId)&&(identical(other.documentName, documentName) || other.documentName == documentName)&&(identical(other.isMandatory, isMandatory) || other.isMandatory == isMandatory)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,documentTypeId,documentName,isMandatory,isActive);

@override
String toString() {
  return 'DocumentTypeResponse(documentTypeId: $documentTypeId, documentName: $documentName, isMandatory: $isMandatory, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $DocumentTypeResponseCopyWith<$Res>  {
  factory $DocumentTypeResponseCopyWith(DocumentTypeResponse value, $Res Function(DocumentTypeResponse) _then) = _$DocumentTypeResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'documentTypeId') int? documentTypeId,@JsonKey(name: 'documentName') String? documentName,@JsonKey(name: 'isMandatory') bool? isMandatory,@JsonKey(name: 'isActive') bool? isActive
});




}
/// @nodoc
class _$DocumentTypeResponseCopyWithImpl<$Res>
    implements $DocumentTypeResponseCopyWith<$Res> {
  _$DocumentTypeResponseCopyWithImpl(this._self, this._then);

  final DocumentTypeResponse _self;
  final $Res Function(DocumentTypeResponse) _then;

/// Create a copy of DocumentTypeResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? documentTypeId = freezed,Object? documentName = freezed,Object? isMandatory = freezed,Object? isActive = freezed,}) {
  return _then(_self.copyWith(
documentTypeId: freezed == documentTypeId ? _self.documentTypeId : documentTypeId // ignore: cast_nullable_to_non_nullable
as int?,documentName: freezed == documentName ? _self.documentName : documentName // ignore: cast_nullable_to_non_nullable
as String?,isMandatory: freezed == isMandatory ? _self.isMandatory : isMandatory // ignore: cast_nullable_to_non_nullable
as bool?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [DocumentTypeResponse].
extension DocumentTypeResponsePatterns on DocumentTypeResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DocumentTypeResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DocumentTypeResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DocumentTypeResponse value)  $default,){
final _that = this;
switch (_that) {
case _DocumentTypeResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DocumentTypeResponse value)?  $default,){
final _that = this;
switch (_that) {
case _DocumentTypeResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'documentTypeId')  int? documentTypeId, @JsonKey(name: 'documentName')  String? documentName, @JsonKey(name: 'isMandatory')  bool? isMandatory, @JsonKey(name: 'isActive')  bool? isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DocumentTypeResponse() when $default != null:
return $default(_that.documentTypeId,_that.documentName,_that.isMandatory,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'documentTypeId')  int? documentTypeId, @JsonKey(name: 'documentName')  String? documentName, @JsonKey(name: 'isMandatory')  bool? isMandatory, @JsonKey(name: 'isActive')  bool? isActive)  $default,) {final _that = this;
switch (_that) {
case _DocumentTypeResponse():
return $default(_that.documentTypeId,_that.documentName,_that.isMandatory,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'documentTypeId')  int? documentTypeId, @JsonKey(name: 'documentName')  String? documentName, @JsonKey(name: 'isMandatory')  bool? isMandatory, @JsonKey(name: 'isActive')  bool? isActive)?  $default,) {final _that = this;
switch (_that) {
case _DocumentTypeResponse() when $default != null:
return $default(_that.documentTypeId,_that.documentName,_that.isMandatory,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DocumentTypeResponse implements DocumentTypeResponse {
  const _DocumentTypeResponse({@JsonKey(name: 'documentTypeId') this.documentTypeId, @JsonKey(name: 'documentName') this.documentName, @JsonKey(name: 'isMandatory') this.isMandatory, @JsonKey(name: 'isActive') this.isActive});
  factory _DocumentTypeResponse.fromJson(Map<String, dynamic> json) => _$DocumentTypeResponseFromJson(json);

@override@JsonKey(name: 'documentTypeId') final  int? documentTypeId;
@override@JsonKey(name: 'documentName') final  String? documentName;
@override@JsonKey(name: 'isMandatory') final  bool? isMandatory;
@override@JsonKey(name: 'isActive') final  bool? isActive;

/// Create a copy of DocumentTypeResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentTypeResponseCopyWith<_DocumentTypeResponse> get copyWith => __$DocumentTypeResponseCopyWithImpl<_DocumentTypeResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentTypeResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentTypeResponse&&(identical(other.documentTypeId, documentTypeId) || other.documentTypeId == documentTypeId)&&(identical(other.documentName, documentName) || other.documentName == documentName)&&(identical(other.isMandatory, isMandatory) || other.isMandatory == isMandatory)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,documentTypeId,documentName,isMandatory,isActive);

@override
String toString() {
  return 'DocumentTypeResponse(documentTypeId: $documentTypeId, documentName: $documentName, isMandatory: $isMandatory, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$DocumentTypeResponseCopyWith<$Res> implements $DocumentTypeResponseCopyWith<$Res> {
  factory _$DocumentTypeResponseCopyWith(_DocumentTypeResponse value, $Res Function(_DocumentTypeResponse) _then) = __$DocumentTypeResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'documentTypeId') int? documentTypeId,@JsonKey(name: 'documentName') String? documentName,@JsonKey(name: 'isMandatory') bool? isMandatory,@JsonKey(name: 'isActive') bool? isActive
});




}
/// @nodoc
class __$DocumentTypeResponseCopyWithImpl<$Res>
    implements _$DocumentTypeResponseCopyWith<$Res> {
  __$DocumentTypeResponseCopyWithImpl(this._self, this._then);

  final _DocumentTypeResponse _self;
  final $Res Function(_DocumentTypeResponse) _then;

/// Create a copy of DocumentTypeResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? documentTypeId = freezed,Object? documentName = freezed,Object? isMandatory = freezed,Object? isActive = freezed,}) {
  return _then(_DocumentTypeResponse(
documentTypeId: freezed == documentTypeId ? _self.documentTypeId : documentTypeId // ignore: cast_nullable_to_non_nullable
as int?,documentName: freezed == documentName ? _self.documentName : documentName // ignore: cast_nullable_to_non_nullable
as String?,isMandatory: freezed == isMandatory ? _self.isMandatory : isMandatory // ignore: cast_nullable_to_non_nullable
as bool?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
