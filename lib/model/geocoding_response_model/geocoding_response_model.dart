import 'package:freezed_annotation/freezed_annotation.dart';

part 'geocoding_response_model.freezed.dart';
part 'geocoding_response_model.g.dart';

@freezed
class GeocodingResponseModel with _$GeocodingResponseModel {
  const factory GeocodingResponseModel({
    List<GeocodingResult>? results,
    String? status,
  }) = _GeocodingResponseModel;

  factory GeocodingResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GeocodingResponseModelFromJson(json);
}

@freezed
class GeocodingResult with _$GeocodingResult {
  const factory GeocodingResult({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'formatted_address') String? formattedAddress,
  }) = _GeocodingResult;

  factory GeocodingResult.fromJson(Map<String, dynamic> json) =>
      _$GeocodingResultFromJson(json);
}
