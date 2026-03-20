// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BaseDataRes<T> _$BaseDataResFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _BaseDataRes<T>(
  success: json['success'] as bool?,
  message: json['message'] as String?,
  data: _$nullableGenericFromJson(json['data'], fromJsonT),
);

Map<String, dynamic> _$BaseDataResToJson<T>(
  _BaseDataRes<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': _$nullableGenericToJson(instance.data, toJsonT),
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);

_BaseRes _$BaseResFromJson(Map<String, dynamic> json) => _BaseRes(
  success: json['success'] as bool?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$BaseResToJson(_BaseRes instance) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
};
