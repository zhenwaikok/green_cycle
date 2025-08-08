// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'direction_response_model.freezed.dart';
part 'direction_response_model.g.dart';

@freezed
class DirectionResponseModel with _$DirectionResponseModel {
  const factory DirectionResponseModel({
    @JsonKey(name: 'geocoded_waypoints')
    List<GeocodedWaypoint>? geocodedWaypoints,
    List<Route>? routes,
    String? status,
  }) = _DirectionResponseModel;

  factory DirectionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DirectionResponseModelFromJson(json);
}

@freezed
class GeocodedWaypoint with _$GeocodedWaypoint {
  const factory GeocodedWaypoint({
    @JsonKey(name: 'geocoder_status') String? geocoderStatus,
    @JsonKey(name: 'place_id') String? placeId,
    List<String>? types,
  }) = _GeocodedWaypoint;

  factory GeocodedWaypoint.fromJson(Map<String, dynamic> json) =>
      _$GeocodedWaypointFromJson(json);
}

@freezed
class Route with _$Route {
  const factory Route({
    Bounds? bounds,
    String? copyrights,
    List<Leg>? legs,
    @JsonKey(name: 'overview_polyline') OverviewPolyline? overviewPolyline,
    String? summary,
    List<dynamic>? warnings,
    @JsonKey(name: 'waypoint_order') List<dynamic>? waypointOrder,
  }) = _Route;

  factory Route.fromJson(Map<String, dynamic> json) => _$RouteFromJson(json);
}

@freezed
class Bounds with _$Bounds {
  const factory Bounds({LatLng? northeast, LatLng? southwest}) = _Bounds;

  factory Bounds.fromJson(Map<String, dynamic> json) => _$BoundsFromJson(json);
}

@freezed
class LatLng with _$LatLng {
  const factory LatLng({double? lat, double? lng}) = _LatLng;

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
}

@freezed
class Leg with _$Leg {
  const factory Leg({
    Distance? distance,
    DurationValue? duration,
    @JsonKey(name: 'end_address') String? endAddress,
    @JsonKey(name: 'end_location') LatLng? endLocation,
    @JsonKey(name: 'start_address') String? startAddress,
    @JsonKey(name: 'start_location') LatLng? startLocation,
    List<Step>? steps,
    @JsonKey(name: 'traffic_speed_entry') List<dynamic>? trafficSpeedEntry,
    @JsonKey(name: 'via_waypoint') List<dynamic>? viaWaypoint,
  }) = _Leg;

  factory Leg.fromJson(Map<String, dynamic> json) => _$LegFromJson(json);
}

@freezed
class Distance with _$Distance {
  const factory Distance({String? text, int? value}) = _Distance;

  factory Distance.fromJson(Map<String, dynamic> json) =>
      _$DistanceFromJson(json);
}

@freezed
class DurationValue with _$DurationValue {
  const factory DurationValue({String? text, int? value}) = _DurationValue;

  factory DurationValue.fromJson(Map<String, dynamic> json) =>
      _$DurationValueFromJson(json);
}

@freezed
class Step with _$Step {
  const factory Step({
    Distance? distance,
    DurationValue? duration,
    @JsonKey(name: 'end_location') LatLng? endLocation,
    @JsonKey(name: 'html_instructions') String? htmlInstructions,
    Polyline? polyline,
    @JsonKey(name: 'start_location') LatLng? startLocation,
    @JsonKey(name: 'travel_mode') String? travelMode,
    String? maneuver,
  }) = _Step;

  factory Step.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);
}

@freezed
class Polyline with _$Polyline {
  const factory Polyline({String? points}) = _Polyline;

  factory Polyline.fromJson(Map<String, dynamic> json) =>
      _$PolylineFromJson(json);
}

@freezed
class OverviewPolyline with _$OverviewPolyline {
  const factory OverviewPolyline({String? points}) = _OverviewPolyline;

  factory OverviewPolyline.fromJson(Map<String, dynamic> json) =>
      _$OverviewPolylineFromJson(json);
}
