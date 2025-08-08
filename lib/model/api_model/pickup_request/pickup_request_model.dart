import 'package:freezed_annotation/freezed_annotation.dart';

part 'pickup_request_model.freezed.dart';
part 'pickup_request_model.g.dart';

@freezed
class PickupRequestModel with _$PickupRequestModel {
  const factory PickupRequestModel({
    String? pickupRequestID,
    String? userID,
    String? collectorUserID,
    String? pickupLocation,
    double? pickupLatitude,
    double? pickupLongtitude,
    String? remarks,
    DateTime? pickupDate,
    String? pickupTimeRange,
    List<String>? pickupItemImageURL,
    String? pickupItemDescription,
    String? pickupItemCategory,
    int? pickupItemQuantity,
    String? pickupItemCondition,
    String? pickupRequestStatus,
    String? collectionProofImageURL,
    DateTime? requestedDate,
    DateTime? completedDate,
  }) = _PickupRequestModel;

  factory PickupRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PickupRequestModelFromJson(json);
}
