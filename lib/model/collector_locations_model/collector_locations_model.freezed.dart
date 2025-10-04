// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collector_locations_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CollectorLocationsModel _$CollectorLocationsModelFromJson(
  Map<String, dynamic> json,
) {
  return _CollectorLocationsModel.fromJson(json);
}

/// @nodoc
mixin _$CollectorLocationsModel {
  String? get collectorUserID => throw _privateConstructorUsedError;
  double? get collectorLatitude => throw _privateConstructorUsedError;
  double? get collectorLongtitude => throw _privateConstructorUsedError;
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this CollectorLocationsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CollectorLocationsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CollectorLocationsModelCopyWith<CollectorLocationsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectorLocationsModelCopyWith<$Res> {
  factory $CollectorLocationsModelCopyWith(
    CollectorLocationsModel value,
    $Res Function(CollectorLocationsModel) then,
  ) = _$CollectorLocationsModelCopyWithImpl<$Res, CollectorLocationsModel>;
  @useResult
  $Res call({
    String? collectorUserID,
    double? collectorLatitude,
    double? collectorLongtitude,
    DateTime? lastUpdated,
  });
}

/// @nodoc
class _$CollectorLocationsModelCopyWithImpl<
  $Res,
  $Val extends CollectorLocationsModel
>
    implements $CollectorLocationsModelCopyWith<$Res> {
  _$CollectorLocationsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CollectorLocationsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? collectorUserID = freezed,
    Object? collectorLatitude = freezed,
    Object? collectorLongtitude = freezed,
    Object? lastUpdated = freezed,
  }) {
    return _then(
      _value.copyWith(
            collectorUserID: freezed == collectorUserID
                ? _value.collectorUserID
                : collectorUserID // ignore: cast_nullable_to_non_nullable
                      as String?,
            collectorLatitude: freezed == collectorLatitude
                ? _value.collectorLatitude
                : collectorLatitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            collectorLongtitude: freezed == collectorLongtitude
                ? _value.collectorLongtitude
                : collectorLongtitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            lastUpdated: freezed == lastUpdated
                ? _value.lastUpdated
                : lastUpdated // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CollectorLocationsModelImplCopyWith<$Res>
    implements $CollectorLocationsModelCopyWith<$Res> {
  factory _$$CollectorLocationsModelImplCopyWith(
    _$CollectorLocationsModelImpl value,
    $Res Function(_$CollectorLocationsModelImpl) then,
  ) = __$$CollectorLocationsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? collectorUserID,
    double? collectorLatitude,
    double? collectorLongtitude,
    DateTime? lastUpdated,
  });
}

/// @nodoc
class __$$CollectorLocationsModelImplCopyWithImpl<$Res>
    extends
        _$CollectorLocationsModelCopyWithImpl<
          $Res,
          _$CollectorLocationsModelImpl
        >
    implements _$$CollectorLocationsModelImplCopyWith<$Res> {
  __$$CollectorLocationsModelImplCopyWithImpl(
    _$CollectorLocationsModelImpl _value,
    $Res Function(_$CollectorLocationsModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CollectorLocationsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? collectorUserID = freezed,
    Object? collectorLatitude = freezed,
    Object? collectorLongtitude = freezed,
    Object? lastUpdated = freezed,
  }) {
    return _then(
      _$CollectorLocationsModelImpl(
        collectorUserID: freezed == collectorUserID
            ? _value.collectorUserID
            : collectorUserID // ignore: cast_nullable_to_non_nullable
                  as String?,
        collectorLatitude: freezed == collectorLatitude
            ? _value.collectorLatitude
            : collectorLatitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        collectorLongtitude: freezed == collectorLongtitude
            ? _value.collectorLongtitude
            : collectorLongtitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        lastUpdated: freezed == lastUpdated
            ? _value.lastUpdated
            : lastUpdated // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CollectorLocationsModelImpl implements _CollectorLocationsModel {
  const _$CollectorLocationsModelImpl({
    this.collectorUserID,
    this.collectorLatitude,
    this.collectorLongtitude,
    this.lastUpdated,
  });

  factory _$CollectorLocationsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CollectorLocationsModelImplFromJson(json);

  @override
  final String? collectorUserID;
  @override
  final double? collectorLatitude;
  @override
  final double? collectorLongtitude;
  @override
  final DateTime? lastUpdated;

  @override
  String toString() {
    return 'CollectorLocationsModel(collectorUserID: $collectorUserID, collectorLatitude: $collectorLatitude, collectorLongtitude: $collectorLongtitude, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollectorLocationsModelImpl &&
            (identical(other.collectorUserID, collectorUserID) ||
                other.collectorUserID == collectorUserID) &&
            (identical(other.collectorLatitude, collectorLatitude) ||
                other.collectorLatitude == collectorLatitude) &&
            (identical(other.collectorLongtitude, collectorLongtitude) ||
                other.collectorLongtitude == collectorLongtitude) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    collectorUserID,
    collectorLatitude,
    collectorLongtitude,
    lastUpdated,
  );

  /// Create a copy of CollectorLocationsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CollectorLocationsModelImplCopyWith<_$CollectorLocationsModelImpl>
  get copyWith =>
      __$$CollectorLocationsModelImplCopyWithImpl<
        _$CollectorLocationsModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CollectorLocationsModelImplToJson(this);
  }
}

abstract class _CollectorLocationsModel implements CollectorLocationsModel {
  const factory _CollectorLocationsModel({
    final String? collectorUserID,
    final double? collectorLatitude,
    final double? collectorLongtitude,
    final DateTime? lastUpdated,
  }) = _$CollectorLocationsModelImpl;

  factory _CollectorLocationsModel.fromJson(Map<String, dynamic> json) =
      _$CollectorLocationsModelImpl.fromJson;

  @override
  String? get collectorUserID;
  @override
  double? get collectorLatitude;
  @override
  double? get collectorLongtitude;
  @override
  DateTime? get lastUpdated;

  /// Create a copy of CollectorLocationsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CollectorLocationsModelImplCopyWith<_$CollectorLocationsModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
