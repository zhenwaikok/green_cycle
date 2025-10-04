// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'awareness_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AwarenessModelImpl _$$AwarenessModelImplFromJson(Map<String, dynamic> json) =>
    _$AwarenessModelImpl(
      awarenessID: (json['awarenessID'] as num?)?.toInt(),
      awarenessImageURL: json['awarenessImageURL'] as String?,
      awarenessTitle: json['awarenessTitle'] as String?,
      awarenessContent: json['awarenessContent'] as String?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
    );

Map<String, dynamic> _$$AwarenessModelImplToJson(
  _$AwarenessModelImpl instance,
) => <String, dynamic>{
  'awarenessID': instance.awarenessID,
  'awarenessImageURL': instance.awarenessImageURL,
  'awarenessTitle': instance.awarenessTitle,
  'awarenessContent': instance.awarenessContent,
  'createdDate': instance.createdDate?.toIso8601String(),
};
