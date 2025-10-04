// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'points_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PointsModel _$PointsModelFromJson(Map<String, dynamic> json) {
  return _PointsModel.fromJson(json);
}

/// @nodoc
mixin _$PointsModel {
  int? get pointID => throw _privateConstructorUsedError;
  String? get userID => throw _privateConstructorUsedError;
  int? get point => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this PointsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointsModelCopyWith<PointsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsModelCopyWith<$Res> {
  factory $PointsModelCopyWith(
    PointsModel value,
    $Res Function(PointsModel) then,
  ) = _$PointsModelCopyWithImpl<$Res, PointsModel>;
  @useResult
  $Res call({
    int? pointID,
    String? userID,
    int? point,
    String? type,
    String? description,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$PointsModelCopyWithImpl<$Res, $Val extends PointsModel>
    implements $PointsModelCopyWith<$Res> {
  _$PointsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pointID = freezed,
    Object? userID = freezed,
    Object? point = freezed,
    Object? type = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            pointID: freezed == pointID
                ? _value.pointID
                : pointID // ignore: cast_nullable_to_non_nullable
                      as int?,
            userID: freezed == userID
                ? _value.userID
                : userID // ignore: cast_nullable_to_non_nullable
                      as String?,
            point: freezed == point
                ? _value.point
                : point // ignore: cast_nullable_to_non_nullable
                      as int?,
            type: freezed == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PointsModelImplCopyWith<$Res>
    implements $PointsModelCopyWith<$Res> {
  factory _$$PointsModelImplCopyWith(
    _$PointsModelImpl value,
    $Res Function(_$PointsModelImpl) then,
  ) = __$$PointsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? pointID,
    String? userID,
    int? point,
    String? type,
    String? description,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$PointsModelImplCopyWithImpl<$Res>
    extends _$PointsModelCopyWithImpl<$Res, _$PointsModelImpl>
    implements _$$PointsModelImplCopyWith<$Res> {
  __$$PointsModelImplCopyWithImpl(
    _$PointsModelImpl _value,
    $Res Function(_$PointsModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pointID = freezed,
    Object? userID = freezed,
    Object? point = freezed,
    Object? type = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$PointsModelImpl(
        pointID: freezed == pointID
            ? _value.pointID
            : pointID // ignore: cast_nullable_to_non_nullable
                  as int?,
        userID: freezed == userID
            ? _value.userID
            : userID // ignore: cast_nullable_to_non_nullable
                  as String?,
        point: freezed == point
            ? _value.point
            : point // ignore: cast_nullable_to_non_nullable
                  as int?,
        type: freezed == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointsModelImpl implements _PointsModel {
  const _$PointsModelImpl({
    this.pointID,
    this.userID,
    this.point,
    this.type,
    this.description,
    this.createdAt,
  });

  factory _$PointsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointsModelImplFromJson(json);

  @override
  final int? pointID;
  @override
  final String? userID;
  @override
  final int? point;
  @override
  final String? type;
  @override
  final String? description;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'PointsModel(pointID: $pointID, userID: $userID, point: $point, type: $type, description: $description, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsModelImpl &&
            (identical(other.pointID, pointID) || other.pointID == pointID) &&
            (identical(other.userID, userID) || other.userID == userID) &&
            (identical(other.point, point) || other.point == point) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    pointID,
    userID,
    point,
    type,
    description,
    createdAt,
  );

  /// Create a copy of PointsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsModelImplCopyWith<_$PointsModelImpl> get copyWith =>
      __$$PointsModelImplCopyWithImpl<_$PointsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PointsModelImplToJson(this);
  }
}

abstract class _PointsModel implements PointsModel {
  const factory _PointsModel({
    final int? pointID,
    final String? userID,
    final int? point,
    final String? type,
    final String? description,
    final DateTime? createdAt,
  }) = _$PointsModelImpl;

  factory _PointsModel.fromJson(Map<String, dynamic> json) =
      _$PointsModelImpl.fromJson;

  @override
  int? get pointID;
  @override
  String? get userID;
  @override
  int? get point;
  @override
  String? get type;
  @override
  String? get description;
  @override
  DateTime? get createdAt;

  /// Create a copy of PointsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointsModelImplCopyWith<_$PointsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
