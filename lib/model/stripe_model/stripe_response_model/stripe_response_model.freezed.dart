// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stripe_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StripeResponseModel _$StripeResponseModelFromJson(Map<String, dynamic> json) {
  return _StripeResponseModel.fromJson(json);
}

/// @nodoc
mixin _$StripeResponseModel {
  @JsonKey(name: 'client_secret')
  String? get clientSecret => throw _privateConstructorUsedError;

  /// Serializes this StripeResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StripeResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StripeResponseModelCopyWith<StripeResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StripeResponseModelCopyWith<$Res> {
  factory $StripeResponseModelCopyWith(
    StripeResponseModel value,
    $Res Function(StripeResponseModel) then,
  ) = _$StripeResponseModelCopyWithImpl<$Res, StripeResponseModel>;
  @useResult
  $Res call({@JsonKey(name: 'client_secret') String? clientSecret});
}

/// @nodoc
class _$StripeResponseModelCopyWithImpl<$Res, $Val extends StripeResponseModel>
    implements $StripeResponseModelCopyWith<$Res> {
  _$StripeResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StripeResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? clientSecret = freezed}) {
    return _then(
      _value.copyWith(
            clientSecret: freezed == clientSecret
                ? _value.clientSecret
                : clientSecret // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StripeResponseModelImplCopyWith<$Res>
    implements $StripeResponseModelCopyWith<$Res> {
  factory _$$StripeResponseModelImplCopyWith(
    _$StripeResponseModelImpl value,
    $Res Function(_$StripeResponseModelImpl) then,
  ) = __$$StripeResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'client_secret') String? clientSecret});
}

/// @nodoc
class __$$StripeResponseModelImplCopyWithImpl<$Res>
    extends _$StripeResponseModelCopyWithImpl<$Res, _$StripeResponseModelImpl>
    implements _$$StripeResponseModelImplCopyWith<$Res> {
  __$$StripeResponseModelImplCopyWithImpl(
    _$StripeResponseModelImpl _value,
    $Res Function(_$StripeResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StripeResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? clientSecret = freezed}) {
    return _then(
      _$StripeResponseModelImpl(
        clientSecret: freezed == clientSecret
            ? _value.clientSecret
            : clientSecret // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StripeResponseModelImpl implements _StripeResponseModel {
  const _$StripeResponseModelImpl({
    @JsonKey(name: 'client_secret') this.clientSecret,
  });

  factory _$StripeResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StripeResponseModelImplFromJson(json);

  @override
  @JsonKey(name: 'client_secret')
  final String? clientSecret;

  @override
  String toString() {
    return 'StripeResponseModel(clientSecret: $clientSecret)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StripeResponseModelImpl &&
            (identical(other.clientSecret, clientSecret) ||
                other.clientSecret == clientSecret));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, clientSecret);

  /// Create a copy of StripeResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StripeResponseModelImplCopyWith<_$StripeResponseModelImpl> get copyWith =>
      __$$StripeResponseModelImplCopyWithImpl<_$StripeResponseModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StripeResponseModelImplToJson(this);
  }
}

abstract class _StripeResponseModel implements StripeResponseModel {
  const factory _StripeResponseModel({
    @JsonKey(name: 'client_secret') final String? clientSecret,
  }) = _$StripeResponseModelImpl;

  factory _StripeResponseModel.fromJson(Map<String, dynamic> json) =
      _$StripeResponseModelImpl.fromJson;

  @override
  @JsonKey(name: 'client_secret')
  String? get clientSecret;

  /// Create a copy of StripeResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StripeResponseModelImplCopyWith<_$StripeResponseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
