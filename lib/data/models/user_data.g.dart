// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserData _$UserDataFromJson(Map<String, dynamic> json) => _UserData(
  accessToken: json['accessToken'] as String?,
  refreshToken: json['refreshToken'] as String?,
  expiresAt: json['expiresAt'] as String?,
  resetRequired: json['resetRequired'] as bool?,
  role: json['role'] as String?,
  roleId: (json['roleId'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserDataToJson(_UserData instance) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'expiresAt': instance.expiresAt,
  'resetRequired': instance.resetRequired,
  'role': instance.role,
  'roleId': instance.roleId,
};
