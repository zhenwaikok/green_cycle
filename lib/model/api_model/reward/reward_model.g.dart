// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RewardModelImpl _$$RewardModelImplFromJson(Map<String, dynamic> json) =>
    _$RewardModelImpl(
      rewardID: (json['rewardID'] as num?)?.toInt(),
      rewardName: json['rewardName'] as String?,
      rewardDescription: json['rewardDescription'] as String?,
      pointsRequired: (json['pointsRequired'] as num?)?.toInt(),
      rewardImageURL: json['rewardImageURL'] as String?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      expiryDate: json['expiryDate'] == null
          ? null
          : DateTime.parse(json['expiryDate'] as String),
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$$RewardModelImplToJson(_$RewardModelImpl instance) =>
    <String, dynamic>{
      'rewardID': instance.rewardID,
      'rewardName': instance.rewardName,
      'rewardDescription': instance.rewardDescription,
      'pointsRequired': instance.pointsRequired,
      'rewardImageURL': instance.rewardImageURL,
      'createdDate': instance.createdDate?.toIso8601String(),
      'expiryDate': instance.expiryDate?.toIso8601String(),
      'isActive': instance.isActive,
    };
