// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PointsModelImpl _$$PointsModelImplFromJson(Map<String, dynamic> json) =>
    _$PointsModelImpl(
      pointID: (json['pointID'] as num?)?.toInt(),
      userID: json['userID'] as String?,
      point: (json['point'] as num?)?.toInt(),
      type: json['type'] as String?,
      description: json['description'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$PointsModelImplToJson(_$PointsModelImpl instance) =>
    <String, dynamic>{
      'pointID': instance.pointID,
      'userID': instance.userID,
      'point': instance.point,
      'type': instance.type,
      'description': instance.description,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
