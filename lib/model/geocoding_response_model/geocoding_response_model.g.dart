// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geocoding_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GeocodingResponseModelImpl _$$GeocodingResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$GeocodingResponseModelImpl(
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => GeocodingResult.fromJson(e as Map<String, dynamic>))
      .toList(),
  status: json['status'] as String?,
);

Map<String, dynamic> _$$GeocodingResponseModelImplToJson(
  _$GeocodingResponseModelImpl instance,
) => <String, dynamic>{'results': instance.results, 'status': instance.status};

_$GeocodingResultImpl _$$GeocodingResultImplFromJson(
  Map<String, dynamic> json,
) => _$GeocodingResultImpl(
  formattedAddress: json['formatted_address'] as String?,
);

Map<String, dynamic> _$$GeocodingResultImplToJson(
  _$GeocodingResultImpl instance,
) => <String, dynamic>{'formatted_address': instance.formattedAddress};
