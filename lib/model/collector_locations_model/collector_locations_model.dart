import 'package:freezed_annotation/freezed_annotation.dart';

part 'collector_locations_model.freezed.dart';
part 'collector_locations_model.g.dart';

@freezed
class CollectorLocationsModel with _$CollectorLocationsModel {
  const factory CollectorLocationsModel({
    String? collectorUserID,
    double? collectorLatitude,
    double? collectorLongtitude,
    DateTime? lastUpdated,
  }) = _CollectorLocationsModel;

  factory CollectorLocationsModel.fromJson(Map<String, dynamic> json) =>
      _$CollectorLocationsModelFromJson(json);
}
