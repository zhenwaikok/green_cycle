// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'direction_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DirectionResponseModel _$DirectionResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _DirectionResponseModel.fromJson(json);
}

/// @nodoc
mixin _$DirectionResponseModel {
  @JsonKey(name: 'geocoded_waypoints')
  List<GeocodedWaypoint>? get geocodedWaypoints =>
      throw _privateConstructorUsedError;
  List<Route>? get routes => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  /// Serializes this DirectionResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DirectionResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DirectionResponseModelCopyWith<DirectionResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DirectionResponseModelCopyWith<$Res> {
  factory $DirectionResponseModelCopyWith(
    DirectionResponseModel value,
    $Res Function(DirectionResponseModel) then,
  ) = _$DirectionResponseModelCopyWithImpl<$Res, DirectionResponseModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'geocoded_waypoints')
    List<GeocodedWaypoint>? geocodedWaypoints,
    List<Route>? routes,
    String? status,
  });
}

/// @nodoc
class _$DirectionResponseModelCopyWithImpl<
  $Res,
  $Val extends DirectionResponseModel
>
    implements $DirectionResponseModelCopyWith<$Res> {
  _$DirectionResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DirectionResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geocodedWaypoints = freezed,
    Object? routes = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _value.copyWith(
            geocodedWaypoints: freezed == geocodedWaypoints
                ? _value.geocodedWaypoints
                : geocodedWaypoints // ignore: cast_nullable_to_non_nullable
                      as List<GeocodedWaypoint>?,
            routes: freezed == routes
                ? _value.routes
                : routes // ignore: cast_nullable_to_non_nullable
                      as List<Route>?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DirectionResponseModelImplCopyWith<$Res>
    implements $DirectionResponseModelCopyWith<$Res> {
  factory _$$DirectionResponseModelImplCopyWith(
    _$DirectionResponseModelImpl value,
    $Res Function(_$DirectionResponseModelImpl) then,
  ) = __$$DirectionResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'geocoded_waypoints')
    List<GeocodedWaypoint>? geocodedWaypoints,
    List<Route>? routes,
    String? status,
  });
}

/// @nodoc
class __$$DirectionResponseModelImplCopyWithImpl<$Res>
    extends
        _$DirectionResponseModelCopyWithImpl<$Res, _$DirectionResponseModelImpl>
    implements _$$DirectionResponseModelImplCopyWith<$Res> {
  __$$DirectionResponseModelImplCopyWithImpl(
    _$DirectionResponseModelImpl _value,
    $Res Function(_$DirectionResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DirectionResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geocodedWaypoints = freezed,
    Object? routes = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _$DirectionResponseModelImpl(
        geocodedWaypoints: freezed == geocodedWaypoints
            ? _value._geocodedWaypoints
            : geocodedWaypoints // ignore: cast_nullable_to_non_nullable
                  as List<GeocodedWaypoint>?,
        routes: freezed == routes
            ? _value._routes
            : routes // ignore: cast_nullable_to_non_nullable
                  as List<Route>?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DirectionResponseModelImpl implements _DirectionResponseModel {
  const _$DirectionResponseModelImpl({
    @JsonKey(name: 'geocoded_waypoints')
    final List<GeocodedWaypoint>? geocodedWaypoints,
    final List<Route>? routes,
    this.status,
  }) : _geocodedWaypoints = geocodedWaypoints,
       _routes = routes;

  factory _$DirectionResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DirectionResponseModelImplFromJson(json);

  final List<GeocodedWaypoint>? _geocodedWaypoints;
  @override
  @JsonKey(name: 'geocoded_waypoints')
  List<GeocodedWaypoint>? get geocodedWaypoints {
    final value = _geocodedWaypoints;
    if (value == null) return null;
    if (_geocodedWaypoints is EqualUnmodifiableListView)
      return _geocodedWaypoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Route>? _routes;
  @override
  List<Route>? get routes {
    final value = _routes;
    if (value == null) return null;
    if (_routes is EqualUnmodifiableListView) return _routes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? status;

  @override
  String toString() {
    return 'DirectionResponseModel(geocodedWaypoints: $geocodedWaypoints, routes: $routes, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DirectionResponseModelImpl &&
            const DeepCollectionEquality().equals(
              other._geocodedWaypoints,
              _geocodedWaypoints,
            ) &&
            const DeepCollectionEquality().equals(other._routes, _routes) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_geocodedWaypoints),
    const DeepCollectionEquality().hash(_routes),
    status,
  );

  /// Create a copy of DirectionResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DirectionResponseModelImplCopyWith<_$DirectionResponseModelImpl>
  get copyWith =>
      __$$DirectionResponseModelImplCopyWithImpl<_$DirectionResponseModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DirectionResponseModelImplToJson(this);
  }
}

abstract class _DirectionResponseModel implements DirectionResponseModel {
  const factory _DirectionResponseModel({
    @JsonKey(name: 'geocoded_waypoints')
    final List<GeocodedWaypoint>? geocodedWaypoints,
    final List<Route>? routes,
    final String? status,
  }) = _$DirectionResponseModelImpl;

  factory _DirectionResponseModel.fromJson(Map<String, dynamic> json) =
      _$DirectionResponseModelImpl.fromJson;

  @override
  @JsonKey(name: 'geocoded_waypoints')
  List<GeocodedWaypoint>? get geocodedWaypoints;
  @override
  List<Route>? get routes;
  @override
  String? get status;

  /// Create a copy of DirectionResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DirectionResponseModelImplCopyWith<_$DirectionResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

GeocodedWaypoint _$GeocodedWaypointFromJson(Map<String, dynamic> json) {
  return _GeocodedWaypoint.fromJson(json);
}

/// @nodoc
mixin _$GeocodedWaypoint {
  @JsonKey(name: 'geocoder_status')
  String? get geocoderStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'place_id')
  String? get placeId => throw _privateConstructorUsedError;
  List<String>? get types => throw _privateConstructorUsedError;

  /// Serializes this GeocodedWaypoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GeocodedWaypoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GeocodedWaypointCopyWith<GeocodedWaypoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeocodedWaypointCopyWith<$Res> {
  factory $GeocodedWaypointCopyWith(
    GeocodedWaypoint value,
    $Res Function(GeocodedWaypoint) then,
  ) = _$GeocodedWaypointCopyWithImpl<$Res, GeocodedWaypoint>;
  @useResult
  $Res call({
    @JsonKey(name: 'geocoder_status') String? geocoderStatus,
    @JsonKey(name: 'place_id') String? placeId,
    List<String>? types,
  });
}

/// @nodoc
class _$GeocodedWaypointCopyWithImpl<$Res, $Val extends GeocodedWaypoint>
    implements $GeocodedWaypointCopyWith<$Res> {
  _$GeocodedWaypointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GeocodedWaypoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geocoderStatus = freezed,
    Object? placeId = freezed,
    Object? types = freezed,
  }) {
    return _then(
      _value.copyWith(
            geocoderStatus: freezed == geocoderStatus
                ? _value.geocoderStatus
                : geocoderStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
            placeId: freezed == placeId
                ? _value.placeId
                : placeId // ignore: cast_nullable_to_non_nullable
                      as String?,
            types: freezed == types
                ? _value.types
                : types // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GeocodedWaypointImplCopyWith<$Res>
    implements $GeocodedWaypointCopyWith<$Res> {
  factory _$$GeocodedWaypointImplCopyWith(
    _$GeocodedWaypointImpl value,
    $Res Function(_$GeocodedWaypointImpl) then,
  ) = __$$GeocodedWaypointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'geocoder_status') String? geocoderStatus,
    @JsonKey(name: 'place_id') String? placeId,
    List<String>? types,
  });
}

/// @nodoc
class __$$GeocodedWaypointImplCopyWithImpl<$Res>
    extends _$GeocodedWaypointCopyWithImpl<$Res, _$GeocodedWaypointImpl>
    implements _$$GeocodedWaypointImplCopyWith<$Res> {
  __$$GeocodedWaypointImplCopyWithImpl(
    _$GeocodedWaypointImpl _value,
    $Res Function(_$GeocodedWaypointImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GeocodedWaypoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geocoderStatus = freezed,
    Object? placeId = freezed,
    Object? types = freezed,
  }) {
    return _then(
      _$GeocodedWaypointImpl(
        geocoderStatus: freezed == geocoderStatus
            ? _value.geocoderStatus
            : geocoderStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
        placeId: freezed == placeId
            ? _value.placeId
            : placeId // ignore: cast_nullable_to_non_nullable
                  as String?,
        types: freezed == types
            ? _value._types
            : types // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GeocodedWaypointImpl implements _GeocodedWaypoint {
  const _$GeocodedWaypointImpl({
    @JsonKey(name: 'geocoder_status') this.geocoderStatus,
    @JsonKey(name: 'place_id') this.placeId,
    final List<String>? types,
  }) : _types = types;

  factory _$GeocodedWaypointImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeocodedWaypointImplFromJson(json);

  @override
  @JsonKey(name: 'geocoder_status')
  final String? geocoderStatus;
  @override
  @JsonKey(name: 'place_id')
  final String? placeId;
  final List<String>? _types;
  @override
  List<String>? get types {
    final value = _types;
    if (value == null) return null;
    if (_types is EqualUnmodifiableListView) return _types;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'GeocodedWaypoint(geocoderStatus: $geocoderStatus, placeId: $placeId, types: $types)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeocodedWaypointImpl &&
            (identical(other.geocoderStatus, geocoderStatus) ||
                other.geocoderStatus == geocoderStatus) &&
            (identical(other.placeId, placeId) || other.placeId == placeId) &&
            const DeepCollectionEquality().equals(other._types, _types));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    geocoderStatus,
    placeId,
    const DeepCollectionEquality().hash(_types),
  );

  /// Create a copy of GeocodedWaypoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GeocodedWaypointImplCopyWith<_$GeocodedWaypointImpl> get copyWith =>
      __$$GeocodedWaypointImplCopyWithImpl<_$GeocodedWaypointImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GeocodedWaypointImplToJson(this);
  }
}

abstract class _GeocodedWaypoint implements GeocodedWaypoint {
  const factory _GeocodedWaypoint({
    @JsonKey(name: 'geocoder_status') final String? geocoderStatus,
    @JsonKey(name: 'place_id') final String? placeId,
    final List<String>? types,
  }) = _$GeocodedWaypointImpl;

  factory _GeocodedWaypoint.fromJson(Map<String, dynamic> json) =
      _$GeocodedWaypointImpl.fromJson;

  @override
  @JsonKey(name: 'geocoder_status')
  String? get geocoderStatus;
  @override
  @JsonKey(name: 'place_id')
  String? get placeId;
  @override
  List<String>? get types;

  /// Create a copy of GeocodedWaypoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GeocodedWaypointImplCopyWith<_$GeocodedWaypointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Route _$RouteFromJson(Map<String, dynamic> json) {
  return _Route.fromJson(json);
}

/// @nodoc
mixin _$Route {
  Bounds? get bounds => throw _privateConstructorUsedError;
  String? get copyrights => throw _privateConstructorUsedError;
  List<Leg>? get legs => throw _privateConstructorUsedError;
  @JsonKey(name: 'overview_polyline')
  OverviewPolyline? get overviewPolyline => throw _privateConstructorUsedError;
  String? get summary => throw _privateConstructorUsedError;
  List<dynamic>? get warnings => throw _privateConstructorUsedError;
  @JsonKey(name: 'waypoint_order')
  List<dynamic>? get waypointOrder => throw _privateConstructorUsedError;

  /// Serializes this Route to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Route
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteCopyWith<Route> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteCopyWith<$Res> {
  factory $RouteCopyWith(Route value, $Res Function(Route) then) =
      _$RouteCopyWithImpl<$Res, Route>;
  @useResult
  $Res call({
    Bounds? bounds,
    String? copyrights,
    List<Leg>? legs,
    @JsonKey(name: 'overview_polyline') OverviewPolyline? overviewPolyline,
    String? summary,
    List<dynamic>? warnings,
    @JsonKey(name: 'waypoint_order') List<dynamic>? waypointOrder,
  });

  $BoundsCopyWith<$Res>? get bounds;
  $OverviewPolylineCopyWith<$Res>? get overviewPolyline;
}

/// @nodoc
class _$RouteCopyWithImpl<$Res, $Val extends Route>
    implements $RouteCopyWith<$Res> {
  _$RouteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Route
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bounds = freezed,
    Object? copyrights = freezed,
    Object? legs = freezed,
    Object? overviewPolyline = freezed,
    Object? summary = freezed,
    Object? warnings = freezed,
    Object? waypointOrder = freezed,
  }) {
    return _then(
      _value.copyWith(
            bounds: freezed == bounds
                ? _value.bounds
                : bounds // ignore: cast_nullable_to_non_nullable
                      as Bounds?,
            copyrights: freezed == copyrights
                ? _value.copyrights
                : copyrights // ignore: cast_nullable_to_non_nullable
                      as String?,
            legs: freezed == legs
                ? _value.legs
                : legs // ignore: cast_nullable_to_non_nullable
                      as List<Leg>?,
            overviewPolyline: freezed == overviewPolyline
                ? _value.overviewPolyline
                : overviewPolyline // ignore: cast_nullable_to_non_nullable
                      as OverviewPolyline?,
            summary: freezed == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String?,
            warnings: freezed == warnings
                ? _value.warnings
                : warnings // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>?,
            waypointOrder: freezed == waypointOrder
                ? _value.waypointOrder
                : waypointOrder // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>?,
          )
          as $Val,
    );
  }

  /// Create a copy of Route
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BoundsCopyWith<$Res>? get bounds {
    if (_value.bounds == null) {
      return null;
    }

    return $BoundsCopyWith<$Res>(_value.bounds!, (value) {
      return _then(_value.copyWith(bounds: value) as $Val);
    });
  }

  /// Create a copy of Route
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OverviewPolylineCopyWith<$Res>? get overviewPolyline {
    if (_value.overviewPolyline == null) {
      return null;
    }

    return $OverviewPolylineCopyWith<$Res>(_value.overviewPolyline!, (value) {
      return _then(_value.copyWith(overviewPolyline: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RouteImplCopyWith<$Res> implements $RouteCopyWith<$Res> {
  factory _$$RouteImplCopyWith(
    _$RouteImpl value,
    $Res Function(_$RouteImpl) then,
  ) = __$$RouteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Bounds? bounds,
    String? copyrights,
    List<Leg>? legs,
    @JsonKey(name: 'overview_polyline') OverviewPolyline? overviewPolyline,
    String? summary,
    List<dynamic>? warnings,
    @JsonKey(name: 'waypoint_order') List<dynamic>? waypointOrder,
  });

  @override
  $BoundsCopyWith<$Res>? get bounds;
  @override
  $OverviewPolylineCopyWith<$Res>? get overviewPolyline;
}

/// @nodoc
class __$$RouteImplCopyWithImpl<$Res>
    extends _$RouteCopyWithImpl<$Res, _$RouteImpl>
    implements _$$RouteImplCopyWith<$Res> {
  __$$RouteImplCopyWithImpl(
    _$RouteImpl _value,
    $Res Function(_$RouteImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Route
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bounds = freezed,
    Object? copyrights = freezed,
    Object? legs = freezed,
    Object? overviewPolyline = freezed,
    Object? summary = freezed,
    Object? warnings = freezed,
    Object? waypointOrder = freezed,
  }) {
    return _then(
      _$RouteImpl(
        bounds: freezed == bounds
            ? _value.bounds
            : bounds // ignore: cast_nullable_to_non_nullable
                  as Bounds?,
        copyrights: freezed == copyrights
            ? _value.copyrights
            : copyrights // ignore: cast_nullable_to_non_nullable
                  as String?,
        legs: freezed == legs
            ? _value._legs
            : legs // ignore: cast_nullable_to_non_nullable
                  as List<Leg>?,
        overviewPolyline: freezed == overviewPolyline
            ? _value.overviewPolyline
            : overviewPolyline // ignore: cast_nullable_to_non_nullable
                  as OverviewPolyline?,
        summary: freezed == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String?,
        warnings: freezed == warnings
            ? _value._warnings
            : warnings // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>?,
        waypointOrder: freezed == waypointOrder
            ? _value._waypointOrder
            : waypointOrder // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteImpl implements _Route {
  const _$RouteImpl({
    this.bounds,
    this.copyrights,
    final List<Leg>? legs,
    @JsonKey(name: 'overview_polyline') this.overviewPolyline,
    this.summary,
    final List<dynamic>? warnings,
    @JsonKey(name: 'waypoint_order') final List<dynamic>? waypointOrder,
  }) : _legs = legs,
       _warnings = warnings,
       _waypointOrder = waypointOrder;

  factory _$RouteImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteImplFromJson(json);

  @override
  final Bounds? bounds;
  @override
  final String? copyrights;
  final List<Leg>? _legs;
  @override
  List<Leg>? get legs {
    final value = _legs;
    if (value == null) return null;
    if (_legs is EqualUnmodifiableListView) return _legs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'overview_polyline')
  final OverviewPolyline? overviewPolyline;
  @override
  final String? summary;
  final List<dynamic>? _warnings;
  @override
  List<dynamic>? get warnings {
    final value = _warnings;
    if (value == null) return null;
    if (_warnings is EqualUnmodifiableListView) return _warnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<dynamic>? _waypointOrder;
  @override
  @JsonKey(name: 'waypoint_order')
  List<dynamic>? get waypointOrder {
    final value = _waypointOrder;
    if (value == null) return null;
    if (_waypointOrder is EqualUnmodifiableListView) return _waypointOrder;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Route(bounds: $bounds, copyrights: $copyrights, legs: $legs, overviewPolyline: $overviewPolyline, summary: $summary, warnings: $warnings, waypointOrder: $waypointOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteImpl &&
            (identical(other.bounds, bounds) || other.bounds == bounds) &&
            (identical(other.copyrights, copyrights) ||
                other.copyrights == copyrights) &&
            const DeepCollectionEquality().equals(other._legs, _legs) &&
            (identical(other.overviewPolyline, overviewPolyline) ||
                other.overviewPolyline == overviewPolyline) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality().equals(other._warnings, _warnings) &&
            const DeepCollectionEquality().equals(
              other._waypointOrder,
              _waypointOrder,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    bounds,
    copyrights,
    const DeepCollectionEquality().hash(_legs),
    overviewPolyline,
    summary,
    const DeepCollectionEquality().hash(_warnings),
    const DeepCollectionEquality().hash(_waypointOrder),
  );

  /// Create a copy of Route
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteImplCopyWith<_$RouteImpl> get copyWith =>
      __$$RouteImplCopyWithImpl<_$RouteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteImplToJson(this);
  }
}

abstract class _Route implements Route {
  const factory _Route({
    final Bounds? bounds,
    final String? copyrights,
    final List<Leg>? legs,
    @JsonKey(name: 'overview_polyline')
    final OverviewPolyline? overviewPolyline,
    final String? summary,
    final List<dynamic>? warnings,
    @JsonKey(name: 'waypoint_order') final List<dynamic>? waypointOrder,
  }) = _$RouteImpl;

  factory _Route.fromJson(Map<String, dynamic> json) = _$RouteImpl.fromJson;

  @override
  Bounds? get bounds;
  @override
  String? get copyrights;
  @override
  List<Leg>? get legs;
  @override
  @JsonKey(name: 'overview_polyline')
  OverviewPolyline? get overviewPolyline;
  @override
  String? get summary;
  @override
  List<dynamic>? get warnings;
  @override
  @JsonKey(name: 'waypoint_order')
  List<dynamic>? get waypointOrder;

  /// Create a copy of Route
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouteImplCopyWith<_$RouteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Bounds _$BoundsFromJson(Map<String, dynamic> json) {
  return _Bounds.fromJson(json);
}

/// @nodoc
mixin _$Bounds {
  LatLng? get northeast => throw _privateConstructorUsedError;
  LatLng? get southwest => throw _privateConstructorUsedError;

  /// Serializes this Bounds to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Bounds
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BoundsCopyWith<Bounds> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoundsCopyWith<$Res> {
  factory $BoundsCopyWith(Bounds value, $Res Function(Bounds) then) =
      _$BoundsCopyWithImpl<$Res, Bounds>;
  @useResult
  $Res call({LatLng? northeast, LatLng? southwest});

  $LatLngCopyWith<$Res>? get northeast;
  $LatLngCopyWith<$Res>? get southwest;
}

/// @nodoc
class _$BoundsCopyWithImpl<$Res, $Val extends Bounds>
    implements $BoundsCopyWith<$Res> {
  _$BoundsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Bounds
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? northeast = freezed, Object? southwest = freezed}) {
    return _then(
      _value.copyWith(
            northeast: freezed == northeast
                ? _value.northeast
                : northeast // ignore: cast_nullable_to_non_nullable
                      as LatLng?,
            southwest: freezed == southwest
                ? _value.southwest
                : southwest // ignore: cast_nullable_to_non_nullable
                      as LatLng?,
          )
          as $Val,
    );
  }

  /// Create a copy of Bounds
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LatLngCopyWith<$Res>? get northeast {
    if (_value.northeast == null) {
      return null;
    }

    return $LatLngCopyWith<$Res>(_value.northeast!, (value) {
      return _then(_value.copyWith(northeast: value) as $Val);
    });
  }

  /// Create a copy of Bounds
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LatLngCopyWith<$Res>? get southwest {
    if (_value.southwest == null) {
      return null;
    }

    return $LatLngCopyWith<$Res>(_value.southwest!, (value) {
      return _then(_value.copyWith(southwest: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BoundsImplCopyWith<$Res> implements $BoundsCopyWith<$Res> {
  factory _$$BoundsImplCopyWith(
    _$BoundsImpl value,
    $Res Function(_$BoundsImpl) then,
  ) = __$$BoundsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LatLng? northeast, LatLng? southwest});

  @override
  $LatLngCopyWith<$Res>? get northeast;
  @override
  $LatLngCopyWith<$Res>? get southwest;
}

/// @nodoc
class __$$BoundsImplCopyWithImpl<$Res>
    extends _$BoundsCopyWithImpl<$Res, _$BoundsImpl>
    implements _$$BoundsImplCopyWith<$Res> {
  __$$BoundsImplCopyWithImpl(
    _$BoundsImpl _value,
    $Res Function(_$BoundsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Bounds
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? northeast = freezed, Object? southwest = freezed}) {
    return _then(
      _$BoundsImpl(
        northeast: freezed == northeast
            ? _value.northeast
            : northeast // ignore: cast_nullable_to_non_nullable
                  as LatLng?,
        southwest: freezed == southwest
            ? _value.southwest
            : southwest // ignore: cast_nullable_to_non_nullable
                  as LatLng?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BoundsImpl implements _Bounds {
  const _$BoundsImpl({this.northeast, this.southwest});

  factory _$BoundsImpl.fromJson(Map<String, dynamic> json) =>
      _$$BoundsImplFromJson(json);

  @override
  final LatLng? northeast;
  @override
  final LatLng? southwest;

  @override
  String toString() {
    return 'Bounds(northeast: $northeast, southwest: $southwest)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoundsImpl &&
            (identical(other.northeast, northeast) ||
                other.northeast == northeast) &&
            (identical(other.southwest, southwest) ||
                other.southwest == southwest));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, northeast, southwest);

  /// Create a copy of Bounds
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BoundsImplCopyWith<_$BoundsImpl> get copyWith =>
      __$$BoundsImplCopyWithImpl<_$BoundsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BoundsImplToJson(this);
  }
}

abstract class _Bounds implements Bounds {
  const factory _Bounds({final LatLng? northeast, final LatLng? southwest}) =
      _$BoundsImpl;

  factory _Bounds.fromJson(Map<String, dynamic> json) = _$BoundsImpl.fromJson;

  @override
  LatLng? get northeast;
  @override
  LatLng? get southwest;

  /// Create a copy of Bounds
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BoundsImplCopyWith<_$BoundsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LatLng _$LatLngFromJson(Map<String, dynamic> json) {
  return _LatLng.fromJson(json);
}

/// @nodoc
mixin _$LatLng {
  double? get lat => throw _privateConstructorUsedError;
  double? get lng => throw _privateConstructorUsedError;

  /// Serializes this LatLng to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LatLng
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LatLngCopyWith<LatLng> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LatLngCopyWith<$Res> {
  factory $LatLngCopyWith(LatLng value, $Res Function(LatLng) then) =
      _$LatLngCopyWithImpl<$Res, LatLng>;
  @useResult
  $Res call({double? lat, double? lng});
}

/// @nodoc
class _$LatLngCopyWithImpl<$Res, $Val extends LatLng>
    implements $LatLngCopyWith<$Res> {
  _$LatLngCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LatLng
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? lat = freezed, Object? lng = freezed}) {
    return _then(
      _value.copyWith(
            lat: freezed == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                      as double?,
            lng: freezed == lng
                ? _value.lng
                : lng // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LatLngImplCopyWith<$Res> implements $LatLngCopyWith<$Res> {
  factory _$$LatLngImplCopyWith(
    _$LatLngImpl value,
    $Res Function(_$LatLngImpl) then,
  ) = __$$LatLngImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double? lat, double? lng});
}

/// @nodoc
class __$$LatLngImplCopyWithImpl<$Res>
    extends _$LatLngCopyWithImpl<$Res, _$LatLngImpl>
    implements _$$LatLngImplCopyWith<$Res> {
  __$$LatLngImplCopyWithImpl(
    _$LatLngImpl _value,
    $Res Function(_$LatLngImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LatLng
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? lat = freezed, Object? lng = freezed}) {
    return _then(
      _$LatLngImpl(
        lat: freezed == lat
            ? _value.lat
            : lat // ignore: cast_nullable_to_non_nullable
                  as double?,
        lng: freezed == lng
            ? _value.lng
            : lng // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LatLngImpl implements _LatLng {
  const _$LatLngImpl({this.lat, this.lng});

  factory _$LatLngImpl.fromJson(Map<String, dynamic> json) =>
      _$$LatLngImplFromJson(json);

  @override
  final double? lat;
  @override
  final double? lng;

  @override
  String toString() {
    return 'LatLng(lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LatLngImpl &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lat, lng);

  /// Create a copy of LatLng
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LatLngImplCopyWith<_$LatLngImpl> get copyWith =>
      __$$LatLngImplCopyWithImpl<_$LatLngImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LatLngImplToJson(this);
  }
}

abstract class _LatLng implements LatLng {
  const factory _LatLng({final double? lat, final double? lng}) = _$LatLngImpl;

  factory _LatLng.fromJson(Map<String, dynamic> json) = _$LatLngImpl.fromJson;

  @override
  double? get lat;
  @override
  double? get lng;

  /// Create a copy of LatLng
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LatLngImplCopyWith<_$LatLngImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Leg _$LegFromJson(Map<String, dynamic> json) {
  return _Leg.fromJson(json);
}

/// @nodoc
mixin _$Leg {
  Distance? get distance => throw _privateConstructorUsedError;
  DurationValue? get duration => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_address')
  String? get endAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_location')
  LatLng? get endLocation => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_address')
  String? get startAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_location')
  LatLng? get startLocation => throw _privateConstructorUsedError;
  List<Step>? get steps => throw _privateConstructorUsedError;
  @JsonKey(name: 'traffic_speed_entry')
  List<dynamic>? get trafficSpeedEntry => throw _privateConstructorUsedError;
  @JsonKey(name: 'via_waypoint')
  List<dynamic>? get viaWaypoint => throw _privateConstructorUsedError;

  /// Serializes this Leg to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Leg
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LegCopyWith<Leg> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LegCopyWith<$Res> {
  factory $LegCopyWith(Leg value, $Res Function(Leg) then) =
      _$LegCopyWithImpl<$Res, Leg>;
  @useResult
  $Res call({
    Distance? distance,
    DurationValue? duration,
    @JsonKey(name: 'end_address') String? endAddress,
    @JsonKey(name: 'end_location') LatLng? endLocation,
    @JsonKey(name: 'start_address') String? startAddress,
    @JsonKey(name: 'start_location') LatLng? startLocation,
    List<Step>? steps,
    @JsonKey(name: 'traffic_speed_entry') List<dynamic>? trafficSpeedEntry,
    @JsonKey(name: 'via_waypoint') List<dynamic>? viaWaypoint,
  });

  $DistanceCopyWith<$Res>? get distance;
  $DurationValueCopyWith<$Res>? get duration;
  $LatLngCopyWith<$Res>? get endLocation;
  $LatLngCopyWith<$Res>? get startLocation;
}

/// @nodoc
class _$LegCopyWithImpl<$Res, $Val extends Leg> implements $LegCopyWith<$Res> {
  _$LegCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Leg
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? distance = freezed,
    Object? duration = freezed,
    Object? endAddress = freezed,
    Object? endLocation = freezed,
    Object? startAddress = freezed,
    Object? startLocation = freezed,
    Object? steps = freezed,
    Object? trafficSpeedEntry = freezed,
    Object? viaWaypoint = freezed,
  }) {
    return _then(
      _value.copyWith(
            distance: freezed == distance
                ? _value.distance
                : distance // ignore: cast_nullable_to_non_nullable
                      as Distance?,
            duration: freezed == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as DurationValue?,
            endAddress: freezed == endAddress
                ? _value.endAddress
                : endAddress // ignore: cast_nullable_to_non_nullable
                      as String?,
            endLocation: freezed == endLocation
                ? _value.endLocation
                : endLocation // ignore: cast_nullable_to_non_nullable
                      as LatLng?,
            startAddress: freezed == startAddress
                ? _value.startAddress
                : startAddress // ignore: cast_nullable_to_non_nullable
                      as String?,
            startLocation: freezed == startLocation
                ? _value.startLocation
                : startLocation // ignore: cast_nullable_to_non_nullable
                      as LatLng?,
            steps: freezed == steps
                ? _value.steps
                : steps // ignore: cast_nullable_to_non_nullable
                      as List<Step>?,
            trafficSpeedEntry: freezed == trafficSpeedEntry
                ? _value.trafficSpeedEntry
                : trafficSpeedEntry // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>?,
            viaWaypoint: freezed == viaWaypoint
                ? _value.viaWaypoint
                : viaWaypoint // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>?,
          )
          as $Val,
    );
  }

  /// Create a copy of Leg
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DistanceCopyWith<$Res>? get distance {
    if (_value.distance == null) {
      return null;
    }

    return $DistanceCopyWith<$Res>(_value.distance!, (value) {
      return _then(_value.copyWith(distance: value) as $Val);
    });
  }

  /// Create a copy of Leg
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DurationValueCopyWith<$Res>? get duration {
    if (_value.duration == null) {
      return null;
    }

    return $DurationValueCopyWith<$Res>(_value.duration!, (value) {
      return _then(_value.copyWith(duration: value) as $Val);
    });
  }

  /// Create a copy of Leg
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LatLngCopyWith<$Res>? get endLocation {
    if (_value.endLocation == null) {
      return null;
    }

    return $LatLngCopyWith<$Res>(_value.endLocation!, (value) {
      return _then(_value.copyWith(endLocation: value) as $Val);
    });
  }

  /// Create a copy of Leg
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LatLngCopyWith<$Res>? get startLocation {
    if (_value.startLocation == null) {
      return null;
    }

    return $LatLngCopyWith<$Res>(_value.startLocation!, (value) {
      return _then(_value.copyWith(startLocation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LegImplCopyWith<$Res> implements $LegCopyWith<$Res> {
  factory _$$LegImplCopyWith(_$LegImpl value, $Res Function(_$LegImpl) then) =
      __$$LegImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Distance? distance,
    DurationValue? duration,
    @JsonKey(name: 'end_address') String? endAddress,
    @JsonKey(name: 'end_location') LatLng? endLocation,
    @JsonKey(name: 'start_address') String? startAddress,
    @JsonKey(name: 'start_location') LatLng? startLocation,
    List<Step>? steps,
    @JsonKey(name: 'traffic_speed_entry') List<dynamic>? trafficSpeedEntry,
    @JsonKey(name: 'via_waypoint') List<dynamic>? viaWaypoint,
  });

  @override
  $DistanceCopyWith<$Res>? get distance;
  @override
  $DurationValueCopyWith<$Res>? get duration;
  @override
  $LatLngCopyWith<$Res>? get endLocation;
  @override
  $LatLngCopyWith<$Res>? get startLocation;
}

/// @nodoc
class __$$LegImplCopyWithImpl<$Res> extends _$LegCopyWithImpl<$Res, _$LegImpl>
    implements _$$LegImplCopyWith<$Res> {
  __$$LegImplCopyWithImpl(_$LegImpl _value, $Res Function(_$LegImpl) _then)
    : super(_value, _then);

  /// Create a copy of Leg
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? distance = freezed,
    Object? duration = freezed,
    Object? endAddress = freezed,
    Object? endLocation = freezed,
    Object? startAddress = freezed,
    Object? startLocation = freezed,
    Object? steps = freezed,
    Object? trafficSpeedEntry = freezed,
    Object? viaWaypoint = freezed,
  }) {
    return _then(
      _$LegImpl(
        distance: freezed == distance
            ? _value.distance
            : distance // ignore: cast_nullable_to_non_nullable
                  as Distance?,
        duration: freezed == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as DurationValue?,
        endAddress: freezed == endAddress
            ? _value.endAddress
            : endAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
        endLocation: freezed == endLocation
            ? _value.endLocation
            : endLocation // ignore: cast_nullable_to_non_nullable
                  as LatLng?,
        startAddress: freezed == startAddress
            ? _value.startAddress
            : startAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
        startLocation: freezed == startLocation
            ? _value.startLocation
            : startLocation // ignore: cast_nullable_to_non_nullable
                  as LatLng?,
        steps: freezed == steps
            ? _value._steps
            : steps // ignore: cast_nullable_to_non_nullable
                  as List<Step>?,
        trafficSpeedEntry: freezed == trafficSpeedEntry
            ? _value._trafficSpeedEntry
            : trafficSpeedEntry // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>?,
        viaWaypoint: freezed == viaWaypoint
            ? _value._viaWaypoint
            : viaWaypoint // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LegImpl implements _Leg {
  const _$LegImpl({
    this.distance,
    this.duration,
    @JsonKey(name: 'end_address') this.endAddress,
    @JsonKey(name: 'end_location') this.endLocation,
    @JsonKey(name: 'start_address') this.startAddress,
    @JsonKey(name: 'start_location') this.startLocation,
    final List<Step>? steps,
    @JsonKey(name: 'traffic_speed_entry')
    final List<dynamic>? trafficSpeedEntry,
    @JsonKey(name: 'via_waypoint') final List<dynamic>? viaWaypoint,
  }) : _steps = steps,
       _trafficSpeedEntry = trafficSpeedEntry,
       _viaWaypoint = viaWaypoint;

  factory _$LegImpl.fromJson(Map<String, dynamic> json) =>
      _$$LegImplFromJson(json);

  @override
  final Distance? distance;
  @override
  final DurationValue? duration;
  @override
  @JsonKey(name: 'end_address')
  final String? endAddress;
  @override
  @JsonKey(name: 'end_location')
  final LatLng? endLocation;
  @override
  @JsonKey(name: 'start_address')
  final String? startAddress;
  @override
  @JsonKey(name: 'start_location')
  final LatLng? startLocation;
  final List<Step>? _steps;
  @override
  List<Step>? get steps {
    final value = _steps;
    if (value == null) return null;
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<dynamic>? _trafficSpeedEntry;
  @override
  @JsonKey(name: 'traffic_speed_entry')
  List<dynamic>? get trafficSpeedEntry {
    final value = _trafficSpeedEntry;
    if (value == null) return null;
    if (_trafficSpeedEntry is EqualUnmodifiableListView)
      return _trafficSpeedEntry;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<dynamic>? _viaWaypoint;
  @override
  @JsonKey(name: 'via_waypoint')
  List<dynamic>? get viaWaypoint {
    final value = _viaWaypoint;
    if (value == null) return null;
    if (_viaWaypoint is EqualUnmodifiableListView) return _viaWaypoint;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Leg(distance: $distance, duration: $duration, endAddress: $endAddress, endLocation: $endLocation, startAddress: $startAddress, startLocation: $startLocation, steps: $steps, trafficSpeedEntry: $trafficSpeedEntry, viaWaypoint: $viaWaypoint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LegImpl &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.endAddress, endAddress) ||
                other.endAddress == endAddress) &&
            (identical(other.endLocation, endLocation) ||
                other.endLocation == endLocation) &&
            (identical(other.startAddress, startAddress) ||
                other.startAddress == startAddress) &&
            (identical(other.startLocation, startLocation) ||
                other.startLocation == startLocation) &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            const DeepCollectionEquality().equals(
              other._trafficSpeedEntry,
              _trafficSpeedEntry,
            ) &&
            const DeepCollectionEquality().equals(
              other._viaWaypoint,
              _viaWaypoint,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    distance,
    duration,
    endAddress,
    endLocation,
    startAddress,
    startLocation,
    const DeepCollectionEquality().hash(_steps),
    const DeepCollectionEquality().hash(_trafficSpeedEntry),
    const DeepCollectionEquality().hash(_viaWaypoint),
  );

  /// Create a copy of Leg
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LegImplCopyWith<_$LegImpl> get copyWith =>
      __$$LegImplCopyWithImpl<_$LegImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LegImplToJson(this);
  }
}

abstract class _Leg implements Leg {
  const factory _Leg({
    final Distance? distance,
    final DurationValue? duration,
    @JsonKey(name: 'end_address') final String? endAddress,
    @JsonKey(name: 'end_location') final LatLng? endLocation,
    @JsonKey(name: 'start_address') final String? startAddress,
    @JsonKey(name: 'start_location') final LatLng? startLocation,
    final List<Step>? steps,
    @JsonKey(name: 'traffic_speed_entry')
    final List<dynamic>? trafficSpeedEntry,
    @JsonKey(name: 'via_waypoint') final List<dynamic>? viaWaypoint,
  }) = _$LegImpl;

  factory _Leg.fromJson(Map<String, dynamic> json) = _$LegImpl.fromJson;

  @override
  Distance? get distance;
  @override
  DurationValue? get duration;
  @override
  @JsonKey(name: 'end_address')
  String? get endAddress;
  @override
  @JsonKey(name: 'end_location')
  LatLng? get endLocation;
  @override
  @JsonKey(name: 'start_address')
  String? get startAddress;
  @override
  @JsonKey(name: 'start_location')
  LatLng? get startLocation;
  @override
  List<Step>? get steps;
  @override
  @JsonKey(name: 'traffic_speed_entry')
  List<dynamic>? get trafficSpeedEntry;
  @override
  @JsonKey(name: 'via_waypoint')
  List<dynamic>? get viaWaypoint;

  /// Create a copy of Leg
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LegImplCopyWith<_$LegImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Distance _$DistanceFromJson(Map<String, dynamic> json) {
  return _Distance.fromJson(json);
}

/// @nodoc
mixin _$Distance {
  String? get text => throw _privateConstructorUsedError;
  int? get value => throw _privateConstructorUsedError;

  /// Serializes this Distance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Distance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DistanceCopyWith<Distance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DistanceCopyWith<$Res> {
  factory $DistanceCopyWith(Distance value, $Res Function(Distance) then) =
      _$DistanceCopyWithImpl<$Res, Distance>;
  @useResult
  $Res call({String? text, int? value});
}

/// @nodoc
class _$DistanceCopyWithImpl<$Res, $Val extends Distance>
    implements $DistanceCopyWith<$Res> {
  _$DistanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Distance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? text = freezed, Object? value = freezed}) {
    return _then(
      _value.copyWith(
            text: freezed == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String?,
            value: freezed == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DistanceImplCopyWith<$Res>
    implements $DistanceCopyWith<$Res> {
  factory _$$DistanceImplCopyWith(
    _$DistanceImpl value,
    $Res Function(_$DistanceImpl) then,
  ) = __$$DistanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? text, int? value});
}

/// @nodoc
class __$$DistanceImplCopyWithImpl<$Res>
    extends _$DistanceCopyWithImpl<$Res, _$DistanceImpl>
    implements _$$DistanceImplCopyWith<$Res> {
  __$$DistanceImplCopyWithImpl(
    _$DistanceImpl _value,
    $Res Function(_$DistanceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Distance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? text = freezed, Object? value = freezed}) {
    return _then(
      _$DistanceImpl(
        text: freezed == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String?,
        value: freezed == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DistanceImpl implements _Distance {
  const _$DistanceImpl({this.text, this.value});

  factory _$DistanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$DistanceImplFromJson(json);

  @override
  final String? text;
  @override
  final int? value;

  @override
  String toString() {
    return 'Distance(text: $text, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DistanceImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, value);

  /// Create a copy of Distance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DistanceImplCopyWith<_$DistanceImpl> get copyWith =>
      __$$DistanceImplCopyWithImpl<_$DistanceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DistanceImplToJson(this);
  }
}

abstract class _Distance implements Distance {
  const factory _Distance({final String? text, final int? value}) =
      _$DistanceImpl;

  factory _Distance.fromJson(Map<String, dynamic> json) =
      _$DistanceImpl.fromJson;

  @override
  String? get text;
  @override
  int? get value;

  /// Create a copy of Distance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DistanceImplCopyWith<_$DistanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DurationValue _$DurationValueFromJson(Map<String, dynamic> json) {
  return _DurationValue.fromJson(json);
}

/// @nodoc
mixin _$DurationValue {
  String? get text => throw _privateConstructorUsedError;
  int? get value => throw _privateConstructorUsedError;

  /// Serializes this DurationValue to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DurationValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DurationValueCopyWith<DurationValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DurationValueCopyWith<$Res> {
  factory $DurationValueCopyWith(
    DurationValue value,
    $Res Function(DurationValue) then,
  ) = _$DurationValueCopyWithImpl<$Res, DurationValue>;
  @useResult
  $Res call({String? text, int? value});
}

/// @nodoc
class _$DurationValueCopyWithImpl<$Res, $Val extends DurationValue>
    implements $DurationValueCopyWith<$Res> {
  _$DurationValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DurationValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? text = freezed, Object? value = freezed}) {
    return _then(
      _value.copyWith(
            text: freezed == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String?,
            value: freezed == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DurationValueImplCopyWith<$Res>
    implements $DurationValueCopyWith<$Res> {
  factory _$$DurationValueImplCopyWith(
    _$DurationValueImpl value,
    $Res Function(_$DurationValueImpl) then,
  ) = __$$DurationValueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? text, int? value});
}

/// @nodoc
class __$$DurationValueImplCopyWithImpl<$Res>
    extends _$DurationValueCopyWithImpl<$Res, _$DurationValueImpl>
    implements _$$DurationValueImplCopyWith<$Res> {
  __$$DurationValueImplCopyWithImpl(
    _$DurationValueImpl _value,
    $Res Function(_$DurationValueImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DurationValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? text = freezed, Object? value = freezed}) {
    return _then(
      _$DurationValueImpl(
        text: freezed == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String?,
        value: freezed == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DurationValueImpl implements _DurationValue {
  const _$DurationValueImpl({this.text, this.value});

  factory _$DurationValueImpl.fromJson(Map<String, dynamic> json) =>
      _$$DurationValueImplFromJson(json);

  @override
  final String? text;
  @override
  final int? value;

  @override
  String toString() {
    return 'DurationValue(text: $text, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DurationValueImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, value);

  /// Create a copy of DurationValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DurationValueImplCopyWith<_$DurationValueImpl> get copyWith =>
      __$$DurationValueImplCopyWithImpl<_$DurationValueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DurationValueImplToJson(this);
  }
}

abstract class _DurationValue implements DurationValue {
  const factory _DurationValue({final String? text, final int? value}) =
      _$DurationValueImpl;

  factory _DurationValue.fromJson(Map<String, dynamic> json) =
      _$DurationValueImpl.fromJson;

  @override
  String? get text;
  @override
  int? get value;

  /// Create a copy of DurationValue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DurationValueImplCopyWith<_$DurationValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Step _$StepFromJson(Map<String, dynamic> json) {
  return _Step.fromJson(json);
}

/// @nodoc
mixin _$Step {
  Distance? get distance => throw _privateConstructorUsedError;
  DurationValue? get duration => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_location')
  LatLng? get endLocation => throw _privateConstructorUsedError;
  @JsonKey(name: 'html_instructions')
  String? get htmlInstructions => throw _privateConstructorUsedError;
  Polyline? get polyline => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_location')
  LatLng? get startLocation => throw _privateConstructorUsedError;
  @JsonKey(name: 'travel_mode')
  String? get travelMode => throw _privateConstructorUsedError;
  String? get maneuver => throw _privateConstructorUsedError;

  /// Serializes this Step to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Step
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StepCopyWith<Step> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StepCopyWith<$Res> {
  factory $StepCopyWith(Step value, $Res Function(Step) then) =
      _$StepCopyWithImpl<$Res, Step>;
  @useResult
  $Res call({
    Distance? distance,
    DurationValue? duration,
    @JsonKey(name: 'end_location') LatLng? endLocation,
    @JsonKey(name: 'html_instructions') String? htmlInstructions,
    Polyline? polyline,
    @JsonKey(name: 'start_location') LatLng? startLocation,
    @JsonKey(name: 'travel_mode') String? travelMode,
    String? maneuver,
  });

  $DistanceCopyWith<$Res>? get distance;
  $DurationValueCopyWith<$Res>? get duration;
  $LatLngCopyWith<$Res>? get endLocation;
  $PolylineCopyWith<$Res>? get polyline;
  $LatLngCopyWith<$Res>? get startLocation;
}

/// @nodoc
class _$StepCopyWithImpl<$Res, $Val extends Step>
    implements $StepCopyWith<$Res> {
  _$StepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Step
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? distance = freezed,
    Object? duration = freezed,
    Object? endLocation = freezed,
    Object? htmlInstructions = freezed,
    Object? polyline = freezed,
    Object? startLocation = freezed,
    Object? travelMode = freezed,
    Object? maneuver = freezed,
  }) {
    return _then(
      _value.copyWith(
            distance: freezed == distance
                ? _value.distance
                : distance // ignore: cast_nullable_to_non_nullable
                      as Distance?,
            duration: freezed == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as DurationValue?,
            endLocation: freezed == endLocation
                ? _value.endLocation
                : endLocation // ignore: cast_nullable_to_non_nullable
                      as LatLng?,
            htmlInstructions: freezed == htmlInstructions
                ? _value.htmlInstructions
                : htmlInstructions // ignore: cast_nullable_to_non_nullable
                      as String?,
            polyline: freezed == polyline
                ? _value.polyline
                : polyline // ignore: cast_nullable_to_non_nullable
                      as Polyline?,
            startLocation: freezed == startLocation
                ? _value.startLocation
                : startLocation // ignore: cast_nullable_to_non_nullable
                      as LatLng?,
            travelMode: freezed == travelMode
                ? _value.travelMode
                : travelMode // ignore: cast_nullable_to_non_nullable
                      as String?,
            maneuver: freezed == maneuver
                ? _value.maneuver
                : maneuver // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of Step
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DistanceCopyWith<$Res>? get distance {
    if (_value.distance == null) {
      return null;
    }

    return $DistanceCopyWith<$Res>(_value.distance!, (value) {
      return _then(_value.copyWith(distance: value) as $Val);
    });
  }

  /// Create a copy of Step
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DurationValueCopyWith<$Res>? get duration {
    if (_value.duration == null) {
      return null;
    }

    return $DurationValueCopyWith<$Res>(_value.duration!, (value) {
      return _then(_value.copyWith(duration: value) as $Val);
    });
  }

  /// Create a copy of Step
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LatLngCopyWith<$Res>? get endLocation {
    if (_value.endLocation == null) {
      return null;
    }

    return $LatLngCopyWith<$Res>(_value.endLocation!, (value) {
      return _then(_value.copyWith(endLocation: value) as $Val);
    });
  }

  /// Create a copy of Step
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PolylineCopyWith<$Res>? get polyline {
    if (_value.polyline == null) {
      return null;
    }

    return $PolylineCopyWith<$Res>(_value.polyline!, (value) {
      return _then(_value.copyWith(polyline: value) as $Val);
    });
  }

  /// Create a copy of Step
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LatLngCopyWith<$Res>? get startLocation {
    if (_value.startLocation == null) {
      return null;
    }

    return $LatLngCopyWith<$Res>(_value.startLocation!, (value) {
      return _then(_value.copyWith(startLocation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StepImplCopyWith<$Res> implements $StepCopyWith<$Res> {
  factory _$$StepImplCopyWith(
    _$StepImpl value,
    $Res Function(_$StepImpl) then,
  ) = __$$StepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Distance? distance,
    DurationValue? duration,
    @JsonKey(name: 'end_location') LatLng? endLocation,
    @JsonKey(name: 'html_instructions') String? htmlInstructions,
    Polyline? polyline,
    @JsonKey(name: 'start_location') LatLng? startLocation,
    @JsonKey(name: 'travel_mode') String? travelMode,
    String? maneuver,
  });

  @override
  $DistanceCopyWith<$Res>? get distance;
  @override
  $DurationValueCopyWith<$Res>? get duration;
  @override
  $LatLngCopyWith<$Res>? get endLocation;
  @override
  $PolylineCopyWith<$Res>? get polyline;
  @override
  $LatLngCopyWith<$Res>? get startLocation;
}

/// @nodoc
class __$$StepImplCopyWithImpl<$Res>
    extends _$StepCopyWithImpl<$Res, _$StepImpl>
    implements _$$StepImplCopyWith<$Res> {
  __$$StepImplCopyWithImpl(_$StepImpl _value, $Res Function(_$StepImpl) _then)
    : super(_value, _then);

  /// Create a copy of Step
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? distance = freezed,
    Object? duration = freezed,
    Object? endLocation = freezed,
    Object? htmlInstructions = freezed,
    Object? polyline = freezed,
    Object? startLocation = freezed,
    Object? travelMode = freezed,
    Object? maneuver = freezed,
  }) {
    return _then(
      _$StepImpl(
        distance: freezed == distance
            ? _value.distance
            : distance // ignore: cast_nullable_to_non_nullable
                  as Distance?,
        duration: freezed == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as DurationValue?,
        endLocation: freezed == endLocation
            ? _value.endLocation
            : endLocation // ignore: cast_nullable_to_non_nullable
                  as LatLng?,
        htmlInstructions: freezed == htmlInstructions
            ? _value.htmlInstructions
            : htmlInstructions // ignore: cast_nullable_to_non_nullable
                  as String?,
        polyline: freezed == polyline
            ? _value.polyline
            : polyline // ignore: cast_nullable_to_non_nullable
                  as Polyline?,
        startLocation: freezed == startLocation
            ? _value.startLocation
            : startLocation // ignore: cast_nullable_to_non_nullable
                  as LatLng?,
        travelMode: freezed == travelMode
            ? _value.travelMode
            : travelMode // ignore: cast_nullable_to_non_nullable
                  as String?,
        maneuver: freezed == maneuver
            ? _value.maneuver
            : maneuver // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StepImpl implements _Step {
  const _$StepImpl({
    this.distance,
    this.duration,
    @JsonKey(name: 'end_location') this.endLocation,
    @JsonKey(name: 'html_instructions') this.htmlInstructions,
    this.polyline,
    @JsonKey(name: 'start_location') this.startLocation,
    @JsonKey(name: 'travel_mode') this.travelMode,
    this.maneuver,
  });

  factory _$StepImpl.fromJson(Map<String, dynamic> json) =>
      _$$StepImplFromJson(json);

  @override
  final Distance? distance;
  @override
  final DurationValue? duration;
  @override
  @JsonKey(name: 'end_location')
  final LatLng? endLocation;
  @override
  @JsonKey(name: 'html_instructions')
  final String? htmlInstructions;
  @override
  final Polyline? polyline;
  @override
  @JsonKey(name: 'start_location')
  final LatLng? startLocation;
  @override
  @JsonKey(name: 'travel_mode')
  final String? travelMode;
  @override
  final String? maneuver;

  @override
  String toString() {
    return 'Step(distance: $distance, duration: $duration, endLocation: $endLocation, htmlInstructions: $htmlInstructions, polyline: $polyline, startLocation: $startLocation, travelMode: $travelMode, maneuver: $maneuver)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StepImpl &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.endLocation, endLocation) ||
                other.endLocation == endLocation) &&
            (identical(other.htmlInstructions, htmlInstructions) ||
                other.htmlInstructions == htmlInstructions) &&
            (identical(other.polyline, polyline) ||
                other.polyline == polyline) &&
            (identical(other.startLocation, startLocation) ||
                other.startLocation == startLocation) &&
            (identical(other.travelMode, travelMode) ||
                other.travelMode == travelMode) &&
            (identical(other.maneuver, maneuver) ||
                other.maneuver == maneuver));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    distance,
    duration,
    endLocation,
    htmlInstructions,
    polyline,
    startLocation,
    travelMode,
    maneuver,
  );

  /// Create a copy of Step
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StepImplCopyWith<_$StepImpl> get copyWith =>
      __$$StepImplCopyWithImpl<_$StepImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StepImplToJson(this);
  }
}

abstract class _Step implements Step {
  const factory _Step({
    final Distance? distance,
    final DurationValue? duration,
    @JsonKey(name: 'end_location') final LatLng? endLocation,
    @JsonKey(name: 'html_instructions') final String? htmlInstructions,
    final Polyline? polyline,
    @JsonKey(name: 'start_location') final LatLng? startLocation,
    @JsonKey(name: 'travel_mode') final String? travelMode,
    final String? maneuver,
  }) = _$StepImpl;

  factory _Step.fromJson(Map<String, dynamic> json) = _$StepImpl.fromJson;

  @override
  Distance? get distance;
  @override
  DurationValue? get duration;
  @override
  @JsonKey(name: 'end_location')
  LatLng? get endLocation;
  @override
  @JsonKey(name: 'html_instructions')
  String? get htmlInstructions;
  @override
  Polyline? get polyline;
  @override
  @JsonKey(name: 'start_location')
  LatLng? get startLocation;
  @override
  @JsonKey(name: 'travel_mode')
  String? get travelMode;
  @override
  String? get maneuver;

  /// Create a copy of Step
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StepImplCopyWith<_$StepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Polyline _$PolylineFromJson(Map<String, dynamic> json) {
  return _Polyline.fromJson(json);
}

/// @nodoc
mixin _$Polyline {
  String? get points => throw _privateConstructorUsedError;

  /// Serializes this Polyline to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Polyline
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PolylineCopyWith<Polyline> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PolylineCopyWith<$Res> {
  factory $PolylineCopyWith(Polyline value, $Res Function(Polyline) then) =
      _$PolylineCopyWithImpl<$Res, Polyline>;
  @useResult
  $Res call({String? points});
}

/// @nodoc
class _$PolylineCopyWithImpl<$Res, $Val extends Polyline>
    implements $PolylineCopyWith<$Res> {
  _$PolylineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Polyline
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? points = freezed}) {
    return _then(
      _value.copyWith(
            points: freezed == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PolylineImplCopyWith<$Res>
    implements $PolylineCopyWith<$Res> {
  factory _$$PolylineImplCopyWith(
    _$PolylineImpl value,
    $Res Function(_$PolylineImpl) then,
  ) = __$$PolylineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? points});
}

/// @nodoc
class __$$PolylineImplCopyWithImpl<$Res>
    extends _$PolylineCopyWithImpl<$Res, _$PolylineImpl>
    implements _$$PolylineImplCopyWith<$Res> {
  __$$PolylineImplCopyWithImpl(
    _$PolylineImpl _value,
    $Res Function(_$PolylineImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Polyline
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? points = freezed}) {
    return _then(
      _$PolylineImpl(
        points: freezed == points
            ? _value.points
            : points // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PolylineImpl implements _Polyline {
  const _$PolylineImpl({this.points});

  factory _$PolylineImpl.fromJson(Map<String, dynamic> json) =>
      _$$PolylineImplFromJson(json);

  @override
  final String? points;

  @override
  String toString() {
    return 'Polyline(points: $points)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PolylineImpl &&
            (identical(other.points, points) || other.points == points));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, points);

  /// Create a copy of Polyline
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PolylineImplCopyWith<_$PolylineImpl> get copyWith =>
      __$$PolylineImplCopyWithImpl<_$PolylineImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PolylineImplToJson(this);
  }
}

abstract class _Polyline implements Polyline {
  const factory _Polyline({final String? points}) = _$PolylineImpl;

  factory _Polyline.fromJson(Map<String, dynamic> json) =
      _$PolylineImpl.fromJson;

  @override
  String? get points;

  /// Create a copy of Polyline
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PolylineImplCopyWith<_$PolylineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OverviewPolyline _$OverviewPolylineFromJson(Map<String, dynamic> json) {
  return _OverviewPolyline.fromJson(json);
}

/// @nodoc
mixin _$OverviewPolyline {
  String? get points => throw _privateConstructorUsedError;

  /// Serializes this OverviewPolyline to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OverviewPolyline
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OverviewPolylineCopyWith<OverviewPolyline> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OverviewPolylineCopyWith<$Res> {
  factory $OverviewPolylineCopyWith(
    OverviewPolyline value,
    $Res Function(OverviewPolyline) then,
  ) = _$OverviewPolylineCopyWithImpl<$Res, OverviewPolyline>;
  @useResult
  $Res call({String? points});
}

/// @nodoc
class _$OverviewPolylineCopyWithImpl<$Res, $Val extends OverviewPolyline>
    implements $OverviewPolylineCopyWith<$Res> {
  _$OverviewPolylineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OverviewPolyline
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? points = freezed}) {
    return _then(
      _value.copyWith(
            points: freezed == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OverviewPolylineImplCopyWith<$Res>
    implements $OverviewPolylineCopyWith<$Res> {
  factory _$$OverviewPolylineImplCopyWith(
    _$OverviewPolylineImpl value,
    $Res Function(_$OverviewPolylineImpl) then,
  ) = __$$OverviewPolylineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? points});
}

/// @nodoc
class __$$OverviewPolylineImplCopyWithImpl<$Res>
    extends _$OverviewPolylineCopyWithImpl<$Res, _$OverviewPolylineImpl>
    implements _$$OverviewPolylineImplCopyWith<$Res> {
  __$$OverviewPolylineImplCopyWithImpl(
    _$OverviewPolylineImpl _value,
    $Res Function(_$OverviewPolylineImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OverviewPolyline
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? points = freezed}) {
    return _then(
      _$OverviewPolylineImpl(
        points: freezed == points
            ? _value.points
            : points // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OverviewPolylineImpl implements _OverviewPolyline {
  const _$OverviewPolylineImpl({this.points});

  factory _$OverviewPolylineImpl.fromJson(Map<String, dynamic> json) =>
      _$$OverviewPolylineImplFromJson(json);

  @override
  final String? points;

  @override
  String toString() {
    return 'OverviewPolyline(points: $points)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OverviewPolylineImpl &&
            (identical(other.points, points) || other.points == points));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, points);

  /// Create a copy of OverviewPolyline
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OverviewPolylineImplCopyWith<_$OverviewPolylineImpl> get copyWith =>
      __$$OverviewPolylineImplCopyWithImpl<_$OverviewPolylineImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OverviewPolylineImplToJson(this);
  }
}

abstract class _OverviewPolyline implements OverviewPolyline {
  const factory _OverviewPolyline({final String? points}) =
      _$OverviewPolylineImpl;

  factory _OverviewPolyline.fromJson(Map<String, dynamic> json) =
      _$OverviewPolylineImpl.fromJson;

  @override
  String? get points;

  /// Create a copy of OverviewPolyline
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OverviewPolylineImplCopyWith<_$OverviewPolylineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
