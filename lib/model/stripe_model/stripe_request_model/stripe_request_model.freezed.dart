// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stripe_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StripeRequestModel _$StripeRequestModelFromJson(Map<String, dynamic> json) {
  return _StripeRequestModel.fromJson(json);
}

/// @nodoc
mixin _$StripeRequestModel {
  int? get amount => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;

  /// Serializes this StripeRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StripeRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StripeRequestModelCopyWith<StripeRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StripeRequestModelCopyWith<$Res> {
  factory $StripeRequestModelCopyWith(
    StripeRequestModel value,
    $Res Function(StripeRequestModel) then,
  ) = _$StripeRequestModelCopyWithImpl<$Res, StripeRequestModel>;
  @useResult
  $Res call({int? amount, String? currency});
}

/// @nodoc
class _$StripeRequestModelCopyWithImpl<$Res, $Val extends StripeRequestModel>
    implements $StripeRequestModelCopyWith<$Res> {
  _$StripeRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StripeRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? amount = freezed, Object? currency = freezed}) {
    return _then(
      _value.copyWith(
            amount: freezed == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int?,
            currency: freezed == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StripeRequestModelImplCopyWith<$Res>
    implements $StripeRequestModelCopyWith<$Res> {
  factory _$$StripeRequestModelImplCopyWith(
    _$StripeRequestModelImpl value,
    $Res Function(_$StripeRequestModelImpl) then,
  ) = __$$StripeRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? amount, String? currency});
}

/// @nodoc
class __$$StripeRequestModelImplCopyWithImpl<$Res>
    extends _$StripeRequestModelCopyWithImpl<$Res, _$StripeRequestModelImpl>
    implements _$$StripeRequestModelImplCopyWith<$Res> {
  __$$StripeRequestModelImplCopyWithImpl(
    _$StripeRequestModelImpl _value,
    $Res Function(_$StripeRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StripeRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? amount = freezed, Object? currency = freezed}) {
    return _then(
      _$StripeRequestModelImpl(
        amount: freezed == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int?,
        currency: freezed == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StripeRequestModelImpl implements _StripeRequestModel {
  const _$StripeRequestModelImpl({this.amount, this.currency});

  factory _$StripeRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StripeRequestModelImplFromJson(json);

  @override
  final int? amount;
  @override
  final String? currency;

  @override
  String toString() {
    return 'StripeRequestModel(amount: $amount, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StripeRequestModelImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, amount, currency);

  /// Create a copy of StripeRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StripeRequestModelImplCopyWith<_$StripeRequestModelImpl> get copyWith =>
      __$$StripeRequestModelImplCopyWithImpl<_$StripeRequestModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StripeRequestModelImplToJson(this);
  }
}

abstract class _StripeRequestModel implements StripeRequestModel {
  const factory _StripeRequestModel({
    final int? amount,
    final String? currency,
  }) = _$StripeRequestModelImpl;

  factory _StripeRequestModel.fromJson(Map<String, dynamic> json) =
      _$StripeRequestModelImpl.fromJson;

  @override
  int? get amount;
  @override
  String? get currency;

  /// Create a copy of StripeRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StripeRequestModelImplCopyWith<_$StripeRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
