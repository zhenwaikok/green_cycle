import 'package:freezed_annotation/freezed_annotation.dart';

part 'fcm_token_model.freezed.dart';
part 'fcm_token_model.g.dart';

@freezed
class FcmTokenModel with _$FcmTokenModel {
  const factory FcmTokenModel({String? userID, String? token}) = _FcmTokenModel;

  factory FcmTokenModel.fromJson(Map<String, dynamic> json) =>
      _$FcmTokenModelFromJson(json);
}
