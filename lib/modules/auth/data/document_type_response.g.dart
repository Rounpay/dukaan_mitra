// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_type_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DocumentTypeResponse _$DocumentTypeResponseFromJson(
  Map<String, dynamic> json,
) => _DocumentTypeResponse(
  documentTypeId: (json['documentTypeId'] as num?)?.toInt(),
  documentName: json['documentName'] as String?,
  isMandatory: json['isMandatory'] as bool?,
  isActive: json['isActive'] as bool?,
);

Map<String, dynamic> _$DocumentTypeResponseToJson(
  _DocumentTypeResponse instance,
) => <String, dynamic>{
  'documentTypeId': instance.documentTypeId,
  'documentName': instance.documentName,
  'isMandatory': instance.isMandatory,
  'isActive': instance.isActive,
};
