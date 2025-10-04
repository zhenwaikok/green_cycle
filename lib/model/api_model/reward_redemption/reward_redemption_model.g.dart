// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_redemption_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RewardRedemptionModelImpl _$$RewardRedemptionModelImplFromJson(
  Map<String, dynamic> json,
) => _$RewardRedemptionModelImpl(
  rewardRedemptionID: (json['rewardRedemptionID'] as num?)?.toInt(),
  userID: json['userID'] as String?,
  rewardID: (json['rewardID'] as num?)?.toInt(),
  isUsed: json['isUsed'] as bool?,
  redeemedDate: json['redeemedDate'] == null
      ? null
      : DateTime.parse(json['redeemedDate'] as String),
  rewardName: json['rewardName'] as String?,
  rewardDescription: json['rewardDescription'] as String?,
  pointsRequired: (json['pointsRequired'] as num?)?.toInt(),
  rewardImageURL: json['rewardImageURL'] as String?,
  expiryDate: json['expiryDate'] == null
      ? null
      : DateTime.parse(json['expiryDate'] as String),
);

Map<String, dynamic> _$$RewardRedemptionModelImplToJson(
  _$RewardRedemptionModelImpl instance,
) => <String, dynamic>{
  'rewardRedemptionID': instance.rewardRedemptionID,
  'userID': instance.userID,
  'rewardID': instance.rewardID,
  'isUsed': instance.isUsed,
  'redeemedDate': instance.redeemedDate?.toIso8601String(),
  'rewardName': instance.rewardName,
  'rewardDescription': instance.rewardDescription,
  'pointsRequired': instance.pointsRequired,
  'rewardImageURL': instance.rewardImageURL,
  'expiryDate': instance.expiryDate?.toIso8601String(),
};
