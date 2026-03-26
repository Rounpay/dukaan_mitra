import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand_response.freezed.dart';
part 'brand_response.g.dart';

@freezed
abstract class BrandResponse with _$BrandResponse {
  const factory BrandResponse({
    @JsonKey(name: 'brandId') int? brandId,
    @JsonKey(name: 'brandName') String? brandName,
    @JsonKey(name: 'logoPath') String? logoPath,
    @JsonKey(name: 'isActive') bool? isActive,
  }) = _BrandResponse;

  factory BrandResponse.fromJson(Map<String, Object?> json) => _$BrandResponseFromJson(json);
}

