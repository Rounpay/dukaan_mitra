import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_type_response.freezed.dart';
part 'document_type_response.g.dart';

@freezed
abstract class DocumentTypeResponse with _$DocumentTypeResponse {
  const factory DocumentTypeResponse({
    @JsonKey(name: 'documentTypeId') int? documentTypeId,
    @JsonKey(name: 'documentName') String? documentName,
    @JsonKey(name: 'isMandatory') bool? isMandatory,
    @JsonKey(name: 'isActive') bool? isActive,
  }) = _DocumentTypeResponse;

  factory DocumentTypeResponse.fromJson(Map<String, Object?> json) => _$DocumentTypeResponseFromJson(json);
}

