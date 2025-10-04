// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direction_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DirectionResponseModelImpl _$$DirectionResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$DirectionResponseModelImpl(
  geocodedWaypoints: (json['geocoded_waypoints'] as List<dynamic>?)
      ?.map((e) => GeocodedWaypoint.fromJson(e as Map<String, dynamic>))
      .toList(),
  routes: (json['routes'] as List<dynamic>?)
      ?.map((e) => Route.fromJson(e as Map<String, dynamic>))
      .toList(),
  status: json['status'] as String?,
);

Map<String, dynamic> _$$DirectionResponseModelImplToJson(
  _$DirectionResponseModelImpl instance,
) => <String, dynamic>{
  'geocoded_waypoints': instance.geocodedWaypoints,
  'routes': instance.routes,
  'status': instance.status,
};

_$GeocodedWaypointImpl _$$GeocodedWaypointImplFromJson(
  Map<String, dynamic> json,
) => _$GeocodedWaypointImpl(
  geocoderStatus: json['geocoder_status'] as String?,
  placeId: json['place_id'] as String?,
  types: (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$$GeocodedWaypointImplToJson(
  _$GeocodedWaypointImpl instance,
) => <String, dynamic>{
  'geocoder_status': instance.geocoderStatus,
  'place_id': instance.placeId,
  'types': instance.types,
};

_$RouteImpl _$$RouteImplFromJson(Map<String, dynamic> json) => _$RouteImpl(
  bounds: json['bounds'] == null
      ? null
      : Bounds.fromJson(json['bounds'] as Map<String, dynamic>),
  copyrights: json['copyrights'] as String?,
  legs: (json['legs'] as List<dynamic>?)
      ?.map((e) => Leg.fromJson(e as Map<String, dynamic>))
      .toList(),
  overviewPolyline: json['overview_polyline'] == null
      ? null
      : OverviewPolyline.fromJson(
          json['overview_polyline'] as Map<String, dynamic>,
        ),
  summary: json['summary'] as String?,
  warnings: json['warnings'] as List<dynamic>?,
  waypointOrder: json['waypoint_order'] as List<dynamic>?,
);

Map<String, dynamic> _$$RouteImplToJson(_$RouteImpl instance) =>
    <String, dynamic>{
      'bounds': instance.bounds,
      'copyrights': instance.copyrights,
      'legs': instance.legs,
      'overview_polyline': instance.overviewPolyline,
      'summary': instance.summary,
      'warnings': instance.warnings,
      'waypoint_order': instance.waypointOrder,
    };

_$BoundsImpl _$$BoundsImplFromJson(Map<String, dynamic> json) => _$BoundsImpl(
  northeast: json['northeast'] == null
      ? null
      : LatLng.fromJson(json['northeast'] as Map<String, dynamic>),
  southwest: json['southwest'] == null
      ? null
      : LatLng.fromJson(json['southwest'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$BoundsImplToJson(_$BoundsImpl instance) =>
    <String, dynamic>{
      'northeast': instance.northeast,
      'southwest': instance.southwest,
    };

_$LatLngImpl _$$LatLngImplFromJson(Map<String, dynamic> json) => _$LatLngImpl(
  lat: (json['lat'] as num?)?.toDouble(),
  lng: (json['lng'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$LatLngImplToJson(_$LatLngImpl instance) =>
    <String, dynamic>{'lat': instance.lat, 'lng': instance.lng};

_$LegImpl _$$LegImplFromJson(Map<String, dynamic> json) => _$LegImpl(
  distance: json['distance'] == null
      ? null
      : Distance.fromJson(json['distance'] as Map<String, dynamic>),
  duration: json['duration'] == null
      ? null
      : DurationValue.fromJson(json['duration'] as Map<String, dynamic>),
  endAddress: json['end_address'] as String?,
  endLocation: json['end_location'] == null
      ? null
      : LatLng.fromJson(json['end_location'] as Map<String, dynamic>),
  startAddress: json['start_address'] as String?,
  startLocation: json['start_location'] == null
      ? null
      : LatLng.fromJson(json['start_location'] as Map<String, dynamic>),
  steps: (json['steps'] as List<dynamic>?)
      ?.map((e) => Step.fromJson(e as Map<String, dynamic>))
      .toList(),
  trafficSpeedEntry: json['traffic_speed_entry'] as List<dynamic>?,
  viaWaypoint: json['via_waypoint'] as List<dynamic>?,
);

Map<String, dynamic> _$$LegImplToJson(_$LegImpl instance) => <String, dynamic>{
  'distance': instance.distance,
  'duration': instance.duration,
  'end_address': instance.endAddress,
  'end_location': instance.endLocation,
  'start_address': instance.startAddress,
  'start_location': instance.startLocation,
  'steps': instance.steps,
  'traffic_speed_entry': instance.trafficSpeedEntry,
  'via_waypoint': instance.viaWaypoint,
};

_$DistanceImpl _$$DistanceImplFromJson(Map<String, dynamic> json) =>
    _$DistanceImpl(
      text: json['text'] as String?,
      value: (json['value'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$DistanceImplToJson(_$DistanceImpl instance) =>
    <String, dynamic>{'text': instance.text, 'value': instance.value};

_$DurationValueImpl _$$DurationValueImplFromJson(Map<String, dynamic> json) =>
    _$DurationValueImpl(
      text: json['text'] as String?,
      value: (json['value'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$DurationValueImplToJson(_$DurationValueImpl instance) =>
    <String, dynamic>{'text': instance.text, 'value': instance.value};

_$StepImpl _$$StepImplFromJson(Map<String, dynamic> json) => _$StepImpl(
  distance: json['distance'] == null
      ? null
      : Distance.fromJson(json['distance'] as Map<String, dynamic>),
  duration: json['duration'] == null
      ? null
      : DurationValue.fromJson(json['duration'] as Map<String, dynamic>),
  endLocation: json['end_location'] == null
      ? null
      : LatLng.fromJson(json['end_location'] as Map<String, dynamic>),
  htmlInstructions: json['html_instructions'] as String?,
  polyline: json['polyline'] == null
      ? null
      : Polyline.fromJson(json['polyline'] as Map<String, dynamic>),
  startLocation: json['start_location'] == null
      ? null
      : LatLng.fromJson(json['start_location'] as Map<String, dynamic>),
  travelMode: json['travel_mode'] as String?,
  maneuver: json['maneuver'] as String?,
);

Map<String, dynamic> _$$StepImplToJson(_$StepImpl instance) =>
    <String, dynamic>{
      'distance': instance.distance,
      'duration': instance.duration,
      'end_location': instance.endLocation,
      'html_instructions': instance.htmlInstructions,
      'polyline': instance.polyline,
      'start_location': instance.startLocation,
      'travel_mode': instance.travelMode,
      'maneuver': instance.maneuver,
    };

_$PolylineImpl _$$PolylineImplFromJson(Map<String, dynamic> json) =>
    _$PolylineImpl(points: json['points'] as String?);

Map<String, dynamic> _$$PolylineImplToJson(_$PolylineImpl instance) =>
    <String, dynamic>{'points': instance.points};

_$OverviewPolylineImpl _$$OverviewPolylineImplFromJson(
  Map<String, dynamic> json,
) => _$OverviewPolylineImpl(points: json['points'] as String?);

Map<String, dynamic> _$$OverviewPolylineImplToJson(
  _$OverviewPolylineImpl instance,
) => <String, dynamic>{'points': instance.points};
