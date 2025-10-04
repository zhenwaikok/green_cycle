// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'stripe_response_model.freezed.dart';
part 'stripe_response_model.g.dart';

@freezed
class StripeResponseModel with _$StripeResponseModel {
  const factory StripeResponseModel({
    @JsonKey(name: 'client_secret') String? clientSecret,
  }) = _StripeResponseModel;

  factory StripeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$StripeResponseModelFromJson(json);
}
