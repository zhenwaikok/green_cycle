import 'package:freezed_annotation/freezed_annotation.dart';

part 'stripe_request_model.freezed.dart';
part 'stripe_request_model.g.dart';

@freezed
class StripeRequestModel with _$StripeRequestModel {
  const factory StripeRequestModel({int? amount, String? currency}) =
      _StripeRequestModel;

  factory StripeRequestModel.fromJson(Map<String, dynamic> json) =>
      _$StripeRequestModelFromJson(json);
}
