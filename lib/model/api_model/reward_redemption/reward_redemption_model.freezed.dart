// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reward_redemption_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RewardRedemptionModel _$RewardRedemptionModelFromJson(
  Map<String, dynamic> json,
) {
  return _RewardRedemptionModel.fromJson(json);
}

/// @nodoc
mixin _$RewardRedemptionModel {
  int? get rewardRedemptionID => throw _privateConstructorUsedError;
  String? get userID => throw _privateConstructorUsedError;
  int? get rewardID => throw _privateConstructorUsedError;
  bool? get isUsed => throw _privateConstructorUsedError;
  DateTime? get redeemedDate => throw _privateConstructorUsedError;
  RewardModel? get reward => throw _privateConstructorUsedError;

  /// Serializes this RewardRedemptionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RewardRedemptionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RewardRedemptionModelCopyWith<RewardRedemptionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RewardRedemptionModelCopyWith<$Res> {
  factory $RewardRedemptionModelCopyWith(
    RewardRedemptionModel value,
    $Res Function(RewardRedemptionModel) then,
  ) = _$RewardRedemptionModelCopyWithImpl<$Res, RewardRedemptionModel>;
  @useResult
  $Res call({
    int? rewardRedemptionID,
    String? userID,
    int? rewardID,
    bool? isUsed,
    DateTime? redeemedDate,
    RewardModel? reward,
  });

  $RewardModelCopyWith<$Res>? get reward;
}

/// @nodoc
class _$RewardRedemptionModelCopyWithImpl<
  $Res,
  $Val extends RewardRedemptionModel
>
    implements $RewardRedemptionModelCopyWith<$Res> {
  _$RewardRedemptionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RewardRedemptionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rewardRedemptionID = freezed,
    Object? userID = freezed,
    Object? rewardID = freezed,
    Object? isUsed = freezed,
    Object? redeemedDate = freezed,
    Object? reward = freezed,
  }) {
    return _then(
      _value.copyWith(
            rewardRedemptionID: freezed == rewardRedemptionID
                ? _value.rewardRedemptionID
                : rewardRedemptionID // ignore: cast_nullable_to_non_nullable
                      as int?,
            userID: freezed == userID
                ? _value.userID
                : userID // ignore: cast_nullable_to_non_nullable
                      as String?,
            rewardID: freezed == rewardID
                ? _value.rewardID
                : rewardID // ignore: cast_nullable_to_non_nullable
                      as int?,
            isUsed: freezed == isUsed
                ? _value.isUsed
                : isUsed // ignore: cast_nullable_to_non_nullable
                      as bool?,
            redeemedDate: freezed == redeemedDate
                ? _value.redeemedDate
                : redeemedDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            reward: freezed == reward
                ? _value.reward
                : reward // ignore: cast_nullable_to_non_nullable
                      as RewardModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of RewardRedemptionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RewardModelCopyWith<$Res>? get reward {
    if (_value.reward == null) {
      return null;
    }

    return $RewardModelCopyWith<$Res>(_value.reward!, (value) {
      return _then(_value.copyWith(reward: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RewardRedemptionModelImplCopyWith<$Res>
    implements $RewardRedemptionModelCopyWith<$Res> {
  factory _$$RewardRedemptionModelImplCopyWith(
    _$RewardRedemptionModelImpl value,
    $Res Function(_$RewardRedemptionModelImpl) then,
  ) = __$$RewardRedemptionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? rewardRedemptionID,
    String? userID,
    int? rewardID,
    bool? isUsed,
    DateTime? redeemedDate,
    RewardModel? reward,
  });

  @override
  $RewardModelCopyWith<$Res>? get reward;
}

/// @nodoc
class __$$RewardRedemptionModelImplCopyWithImpl<$Res>
    extends
        _$RewardRedemptionModelCopyWithImpl<$Res, _$RewardRedemptionModelImpl>
    implements _$$RewardRedemptionModelImplCopyWith<$Res> {
  __$$RewardRedemptionModelImplCopyWithImpl(
    _$RewardRedemptionModelImpl _value,
    $Res Function(_$RewardRedemptionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RewardRedemptionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rewardRedemptionID = freezed,
    Object? userID = freezed,
    Object? rewardID = freezed,
    Object? isUsed = freezed,
    Object? redeemedDate = freezed,
    Object? reward = freezed,
  }) {
    return _then(
      _$RewardRedemptionModelImpl(
        rewardRedemptionID: freezed == rewardRedemptionID
            ? _value.rewardRedemptionID
            : rewardRedemptionID // ignore: cast_nullable_to_non_nullable
                  as int?,
        userID: freezed == userID
            ? _value.userID
            : userID // ignore: cast_nullable_to_non_nullable
                  as String?,
        rewardID: freezed == rewardID
            ? _value.rewardID
            : rewardID // ignore: cast_nullable_to_non_nullable
                  as int?,
        isUsed: freezed == isUsed
            ? _value.isUsed
            : isUsed // ignore: cast_nullable_to_non_nullable
                  as bool?,
        redeemedDate: freezed == redeemedDate
            ? _value.redeemedDate
            : redeemedDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        reward: freezed == reward
            ? _value.reward
            : reward // ignore: cast_nullable_to_non_nullable
                  as RewardModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RewardRedemptionModelImpl implements _RewardRedemptionModel {
  const _$RewardRedemptionModelImpl({
    this.rewardRedemptionID,
    this.userID,
    this.rewardID,
    this.isUsed,
    this.redeemedDate,
    this.reward,
  });

  factory _$RewardRedemptionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RewardRedemptionModelImplFromJson(json);

  @override
  final int? rewardRedemptionID;
  @override
  final String? userID;
  @override
  final int? rewardID;
  @override
  final bool? isUsed;
  @override
  final DateTime? redeemedDate;
  @override
  final RewardModel? reward;

  @override
  String toString() {
    return 'RewardRedemptionModel(rewardRedemptionID: $rewardRedemptionID, userID: $userID, rewardID: $rewardID, isUsed: $isUsed, redeemedDate: $redeemedDate, reward: $reward)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RewardRedemptionModelImpl &&
            (identical(other.rewardRedemptionID, rewardRedemptionID) ||
                other.rewardRedemptionID == rewardRedemptionID) &&
            (identical(other.userID, userID) || other.userID == userID) &&
            (identical(other.rewardID, rewardID) ||
                other.rewardID == rewardID) &&
            (identical(other.isUsed, isUsed) || other.isUsed == isUsed) &&
            (identical(other.redeemedDate, redeemedDate) ||
                other.redeemedDate == redeemedDate) &&
            (identical(other.reward, reward) || other.reward == reward));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    rewardRedemptionID,
    userID,
    rewardID,
    isUsed,
    redeemedDate,
    reward,
  );

  /// Create a copy of RewardRedemptionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RewardRedemptionModelImplCopyWith<_$RewardRedemptionModelImpl>
  get copyWith =>
      __$$RewardRedemptionModelImplCopyWithImpl<_$RewardRedemptionModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RewardRedemptionModelImplToJson(this);
  }
}

abstract class _RewardRedemptionModel implements RewardRedemptionModel {
  const factory _RewardRedemptionModel({
    final int? rewardRedemptionID,
    final String? userID,
    final int? rewardID,
    final bool? isUsed,
    final DateTime? redeemedDate,
    final RewardModel? reward,
  }) = _$RewardRedemptionModelImpl;

  factory _RewardRedemptionModel.fromJson(Map<String, dynamic> json) =
      _$RewardRedemptionModelImpl.fromJson;

  @override
  int? get rewardRedemptionID;
  @override
  String? get userID;
  @override
  int? get rewardID;
  @override
  bool? get isUsed;
  @override
  DateTime? get redeemedDate;
  @override
  RewardModel? get reward;

  /// Create a copy of RewardRedemptionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RewardRedemptionModelImplCopyWith<_$RewardRedemptionModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
