import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data.freezed.dart';
part 'user_data.g.dart';

@freezed
abstract class UserData with _$UserData {
  const factory UserData({
    @JsonKey(name: 'accessToken') String? accessToken,
    @JsonKey(name: 'refreshToken') String? refreshToken,
    @JsonKey(name: 'expiresAt') String? expiresAt,
    @JsonKey(name: 'resetRequired') bool? resetRequired,
    @JsonKey(name: 'role') String? role,
  }) = _UserData;

  factory UserData.fromJson(Map<String, Object?> json) => _$UserDataFromJson(json);
}

