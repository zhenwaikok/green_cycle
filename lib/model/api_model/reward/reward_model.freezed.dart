// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reward_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RewardModel _$RewardModelFromJson(Map<String, dynamic> json) {
  return _RewardModel.fromJson(json);
}

/// @nodoc
mixin _$RewardModel {
  int? get rewardID => throw _privateConstructorUsedError;
  String? get rewardName => throw _privateConstructorUsedError;
  String? get rewardDescription => throw _privateConstructorUsedError;
  int? get pointsRequired => throw _privateConstructorUsedError;
  String? get rewardImageURL => throw _privateConstructorUsedError;
  DateTime? get createdDate => throw _privateConstructorUsedError;

  /// Serializes this RewardModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RewardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RewardModelCopyWith<RewardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RewardModelCopyWith<$Res> {
  factory $RewardModelCopyWith(
    RewardModel value,
    $Res Function(RewardModel) then,
  ) = _$RewardModelCopyWithImpl<$Res, RewardModel>;
  @useResult
  $Res call({
    int? rewardID,
    String? rewardName,
    String? rewardDescription,
    int? pointsRequired,
    String? rewardImageURL,
    DateTime? createdDate,
  });
}

/// @nodoc
class _$RewardModelCopyWithImpl<$Res, $Val extends RewardModel>
    implements $RewardModelCopyWith<$Res> {
  _$RewardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RewardModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rewardID = freezed,
    Object? rewardName = freezed,
    Object? rewardDescription = freezed,
    Object? pointsRequired = freezed,
    Object? rewardImageURL = freezed,
    Object? createdDate = freezed,
  }) {
    return _then(
      _value.copyWith(
            rewardID: freezed == rewardID
                ? _value.rewardID
                : rewardID // ignore: cast_nullable_to_non_nullable
                      as int?,
            rewardName: freezed == rewardName
                ? _value.rewardName
                : rewardName // ignore: cast_nullable_to_non_nullable
                      as String?,
            rewardDescription: freezed == rewardDescription
                ? _value.rewardDescription
                : rewardDescription // ignore: cast_nullable_to_non_nullable
                      as String?,
            pointsRequired: freezed == pointsRequired
                ? _value.pointsRequired
                : pointsRequired // ignore: cast_nullable_to_non_nullable
                      as int?,
            rewardImageURL: freezed == rewardImageURL
                ? _value.rewardImageURL
                : rewardImageURL // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdDate: freezed == createdDate
                ? _value.createdDate
                : createdDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RewardModelImplCopyWith<$Res>
    implements $RewardModelCopyWith<$Res> {
  factory _$$RewardModelImplCopyWith(
    _$RewardModelImpl value,
    $Res Function(_$RewardModelImpl) then,
  ) = __$$RewardModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? rewardID,
    String? rewardName,
    String? rewardDescription,
    int? pointsRequired,
    String? rewardImageURL,
    DateTime? createdDate,
  });
}

/// @nodoc
class __$$RewardModelImplCopyWithImpl<$Res>
    extends _$RewardModelCopyWithImpl<$Res, _$RewardModelImpl>
    implements _$$RewardModelImplCopyWith<$Res> {
  __$$RewardModelImplCopyWithImpl(
    _$RewardModelImpl _value,
    $Res Function(_$RewardModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RewardModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rewardID = freezed,
    Object? rewardName = freezed,
    Object? rewardDescription = freezed,
    Object? pointsRequired = freezed,
    Object? rewardImageURL = freezed,
    Object? createdDate = freezed,
  }) {
    return _then(
      _$RewardModelImpl(
        rewardID: freezed == rewardID
            ? _value.rewardID
            : rewardID // ignore: cast_nullable_to_non_nullable
                  as int?,
        rewardName: freezed == rewardName
            ? _value.rewardName
            : rewardName // ignore: cast_nullable_to_non_nullable
                  as String?,
        rewardDescription: freezed == rewardDescription
            ? _value.rewardDescription
            : rewardDescription // ignore: cast_nullable_to_non_nullable
                  as String?,
        pointsRequired: freezed == pointsRequired
            ? _value.pointsRequired
            : pointsRequired // ignore: cast_nullable_to_non_nullable
                  as int?,
        rewardImageURL: freezed == rewardImageURL
            ? _value.rewardImageURL
            : rewardImageURL // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdDate: freezed == createdDate
            ? _value.createdDate
            : createdDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RewardModelImpl implements _RewardModel {
  const _$RewardModelImpl({
    this.rewardID,
    this.rewardName,
    this.rewardDescription,
    this.pointsRequired,
    this.rewardImageURL,
    this.createdDate,
  });

  factory _$RewardModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RewardModelImplFromJson(json);

  @override
  final int? rewardID;
  @override
  final String? rewardName;
  @override
  final String? rewardDescription;
  @override
  final int? pointsRequired;
  @override
  final String? rewardImageURL;
  @override
  final DateTime? createdDate;

  @override
  String toString() {
    return 'RewardModel(rewardID: $rewardID, rewardName: $rewardName, rewardDescription: $rewardDescription, pointsRequired: $pointsRequired, rewardImageURL: $rewardImageURL, createdDate: $createdDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RewardModelImpl &&
            (identical(other.rewardID, rewardID) ||
                other.rewardID == rewardID) &&
            (identical(other.rewardName, rewardName) ||
                other.rewardName == rewardName) &&
            (identical(other.rewardDescription, rewardDescription) ||
                other.rewardDescription == rewardDescription) &&
            (identical(other.pointsRequired, pointsRequired) ||
                other.pointsRequired == pointsRequired) &&
            (identical(other.rewardImageURL, rewardImageURL) ||
                other.rewardImageURL == rewardImageURL) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    rewardID,
    rewardName,
    rewardDescription,
    pointsRequired,
    rewardImageURL,
    createdDate,
  );

  /// Create a copy of RewardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RewardModelImplCopyWith<_$RewardModelImpl> get copyWith =>
      __$$RewardModelImplCopyWithImpl<_$RewardModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RewardModelImplToJson(this);
  }
}

abstract class _RewardModel implements RewardModel {
  const factory _RewardModel({
    final int? rewardID,
    final String? rewardName,
    final String? rewardDescription,
    final int? pointsRequired,
    final String? rewardImageURL,
    final DateTime? createdDate,
  }) = _$RewardModelImpl;

  factory _RewardModel.fromJson(Map<String, dynamic> json) =
      _$RewardModelImpl.fromJson;

  @override
  int? get rewardID;
  @override
  String? get rewardName;
  @override
  String? get rewardDescription;
  @override
  int? get pointsRequired;
  @override
  String? get rewardImageURL;
  @override
  DateTime? get createdDate;

  /// Create a copy of RewardModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RewardModelImplCopyWith<_$RewardModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
