// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pickup_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PickupRequestModelImpl _$$PickupRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PickupRequestModelImpl(
      pickupRequestID: json['pickupRequestID'] as String?,
      userID: json['userID'] as String?,
      collectorUserID: json['collectorUserID'] as String?,
      pickupLocation: json['pickupLocation'] as String?,
      remarks: json['remarks'] as String?,
      pickupDate: json['pickupDate'] == null
          ? null
          : DateTime.parse(json['pickupDate'] as String),
      pickupTimeRange: json['pickupTimeRange'] as String?,
      pickupItemImageURL: (json['pickupItemImageURL'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      pickupItemDescription: json['pickupItemDescription'] as String?,
      pickupItemCategory: json['pickupItemCategory'] as String?,
      pickupItemQuantity: (json['pickupItemQuantity'] as num?)?.toInt(),
      pickupItemCondition: json['pickupItemCondition'] as String?,
      pickupRequestStatus: json['pickupRequestStatus'] as String?,
      collectionProofImageURL: json['collectionProofImageURL'] as String?,
      requestedDate: json['requestedDate'] == null
          ? null
          : DateTime.parse(json['requestedDate'] as String),
      completedDate: json['completedDate'] == null
          ? null
          : DateTime.parse(json['completedDate'] as String),
    );

Map<String, dynamic> _$$PickupRequestModelImplToJson(
        _$PickupRequestModelImpl instance) =>
    <String, dynamic>{
      'pickupRequestID': instance.pickupRequestID,
      'userID': instance.userID,
      'collectorUserID': instance.collectorUserID,
      'pickupLocation': instance.pickupLocation,
      'remarks': instance.remarks,
      'pickupDate': instance.pickupDate?.toIso8601String(),
      'pickupTimeRange': instance.pickupTimeRange,
      'pickupItemImageURL': instance.pickupItemImageURL,
      'pickupItemDescription': instance.pickupItemDescription,
      'pickupItemCategory': instance.pickupItemCategory,
      'pickupItemQuantity': instance.pickupItemQuantity,
      'pickupItemCondition': instance.pickupItemCondition,
      'pickupRequestStatus': instance.pickupRequestStatus,
      'collectionProofImageURL': instance.collectionProofImageURL,
      'requestedDate': instance.requestedDate?.toIso8601String(),
      'completedDate': instance.completedDate?.toIso8601String(),
    };
