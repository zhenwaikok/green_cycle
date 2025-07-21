// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_redemption_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RewardRedemptionModelImpl _$$RewardRedemptionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RewardRedemptionModelImpl(
      rewardRedemptionID: (json['rewardRedemptionID'] as num?)?.toInt(),
      userID: json['userID'] as String?,
      rewardID: (json['rewardID'] as num?)?.toInt(),
      isUsed: json['isUsed'] as bool?,
      redeemedDate: json['redeemedDate'] == null
          ? null
          : DateTime.parse(json['redeemedDate'] as String),
      reward: json['reward'] == null
          ? null
          : RewardModel.fromJson(json['reward'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RewardRedemptionModelImplToJson(
        _$RewardRedemptionModelImpl instance) =>
    <String, dynamic>{
      'rewardRedemptionID': instance.rewardRedemptionID,
      'userID': instance.userID,
      'rewardID': instance.rewardID,
      'isUsed': instance.isUsed,
      'redeemedDate': instance.redeemedDate?.toIso8601String(),
      'reward': instance.reward,
    };
