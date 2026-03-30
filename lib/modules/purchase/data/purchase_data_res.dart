import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_data_res.freezed.dart';
part 'purchase_data_res.g.dart';

@freezed
abstract class PurchaseDataRes with _$PurchaseDataRes {
  const factory PurchaseDataRes({
    @JsonKey(name: 'info') Info? info,
    @JsonKey(name: 'snapshot') Snapshot? snapshot,
    @JsonKey(name: 'emiSchedule') List<EmiSchedule>? emiSchedule,
  }) = _PurchaseDataRes;

  factory PurchaseDataRes.fromJson(Map<String, Object?> json) => _$PurchaseDataResFromJson(json);
}

@freezed
abstract class EmiSchedule with _$EmiSchedule {
  const factory EmiSchedule({
    @JsonKey(name: 'emiId') int? emiId,
    @JsonKey(name: 'emiAmount') double? emiAmount,
    @JsonKey(name: 'dueDate') String? dueDate,
    @JsonKey(name: 'paidAmount') dynamic paidAmount,
    @JsonKey(name: 'paidDate') dynamic paidDate,
    @JsonKey(name: 'emiStatus') int? emiStatus,
    @JsonKey(name: 'statusName') String? statusName,
    @JsonKey(name: 'penaltyAmount') int? penaltyAmount,
  }) = _EmiSchedule;

  factory EmiSchedule.fromJson(Map<String, Object?> json) => _$EmiScheduleFromJson(json);
}

@freezed
abstract class Snapshot with _$Snapshot {
  const factory Snapshot({
    @JsonKey(name: 'loanId') int? loanId,
    @JsonKey(name: 'loanAmount') int? loanAmount,
    @JsonKey(name: 'totalEMI') dynamic totalEMI,
    @JsonKey(name: 'totalPaid') dynamic totalPaid,
    @JsonKey(name: 'totalPenalty') dynamic totalPenalty,
    @JsonKey(name: 'outstandingAmount') dynamic outstandingAmount,
    @JsonKey(name: 'nextDueDate') dynamic nextDueDate,
    @JsonKey(name: 'lastPaymentDate') dynamic lastPaymentDate,
  }) = _Snapshot;

  factory Snapshot.fromJson(Map<String, Object?> json) => _$SnapshotFromJson(json);
}

@freezed
abstract class Info with _$Info {
  const factory Info({
    @JsonKey(name: 'loanId') int? loanId,
    @JsonKey(name: 'productName') String? productName,
    @JsonKey(name: 'productImage') List<ProductImage>? productImage,
    @JsonKey(name: 'brandName') String? brandName,
    @JsonKey(name: 'categoryName') String? categoryName,
    @JsonKey(name: 'loanAmount') int? loanAmount,
    @JsonKey(name: 'duration') int? duration,
    @JsonKey(name: 'durationType') String? durationType,
    @JsonKey(name: 'interestRate') int? interestRate,
    @JsonKey(name: 'numberOfInstallment') int? numberOfInstallment,
    @JsonKey(name: 'appliedDate') String? appliedDate,
    @JsonKey(name: 'loanStatus') String? loanStatus,
    @JsonKey(name: 'loanStatusId') int? loanStatusId,
  }) = _Info;

  factory Info.fromJson(Map<String, Object?> json) => _$InfoFromJson(json);
}

@freezed
abstract class ProductImage with _$ProductImage {
  const factory ProductImage({
    @JsonKey(name: 'productImageId') int? productImageId,
    @JsonKey(name: 'productId') int? productId,
    @JsonKey(name: 'imagePath') String? imagePath,
  }) = _ProductImage;

  factory ProductImage.fromJson(Map<String, Object?> json) => _$ProductImageFromJson(json);
}

