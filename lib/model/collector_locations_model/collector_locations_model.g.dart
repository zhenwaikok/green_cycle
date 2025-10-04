// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collector_locations_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CollectorLocationsModelImpl _$$CollectorLocationsModelImplFromJson(
  Map<String, dynamic> json,
) => _$CollectorLocationsModelImpl(
  collectorUserID: json['collectorUserID'] as String?,
  collectorLatitude: (json['collectorLatitude'] as num?)?.toDouble(),
  collectorLongtitude: (json['collectorLongtitude'] as num?)?.toDouble(),
  lastUpdated: json['lastUpdated'] == null
      ? null
      : DateTime.parse(json['lastUpdated'] as String),
);

Map<String, dynamic> _$$CollectorLocationsModelImplToJson(
  _$CollectorLocationsModelImpl instance,
) => <String, dynamic>{
  'collectorUserID': instance.collectorUserID,
  'collectorLatitude': instance.collectorLatitude,
  'collectorLongtitude': instance.collectorLongtitude,
  'lastUpdated': instance.lastUpdated?.toIso8601String(),
};
