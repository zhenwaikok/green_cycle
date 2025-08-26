// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fcm_token_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FcmTokenModel _$FcmTokenModelFromJson(Map<String, dynamic> json) {
  return _FcmTokenModel.fromJson(json);
}

/// @nodoc
mixin _$FcmTokenModel {
  String? get userID => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;

  /// Serializes this FcmTokenModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FcmTokenModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FcmTokenModelCopyWith<FcmTokenModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FcmTokenModelCopyWith<$Res> {
  factory $FcmTokenModelCopyWith(
    FcmTokenModel value,
    $Res Function(FcmTokenModel) then,
  ) = _$FcmTokenModelCopyWithImpl<$Res, FcmTokenModel>;
  @useResult
  $Res call({String? userID, String? token});
}

/// @nodoc
class _$FcmTokenModelCopyWithImpl<$Res, $Val extends FcmTokenModel>
    implements $FcmTokenModelCopyWith<$Res> {
  _$FcmTokenModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FcmTokenModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userID = freezed, Object? token = freezed}) {
    return _then(
      _value.copyWith(
            userID: freezed == userID
                ? _value.userID
                : userID // ignore: cast_nullable_to_non_nullable
                      as String?,
            token: freezed == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FcmTokenModelImplCopyWith<$Res>
    implements $FcmTokenModelCopyWith<$Res> {
  factory _$$FcmTokenModelImplCopyWith(
    _$FcmTokenModelImpl value,
    $Res Function(_$FcmTokenModelImpl) then,
  ) = __$$FcmTokenModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? userID, String? token});
}

/// @nodoc
class __$$FcmTokenModelImplCopyWithImpl<$Res>
    extends _$FcmTokenModelCopyWithImpl<$Res, _$FcmTokenModelImpl>
    implements _$$FcmTokenModelImplCopyWith<$Res> {
  __$$FcmTokenModelImplCopyWithImpl(
    _$FcmTokenModelImpl _value,
    $Res Function(_$FcmTokenModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FcmTokenModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userID = freezed, Object? token = freezed}) {
    return _then(
      _$FcmTokenModelImpl(
        userID: freezed == userID
            ? _value.userID
            : userID // ignore: cast_nullable_to_non_nullable
                  as String?,
        token: freezed == token
            ? _value.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FcmTokenModelImpl implements _FcmTokenModel {
  const _$FcmTokenModelImpl({this.userID, this.token});

  factory _$FcmTokenModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FcmTokenModelImplFromJson(json);

  @override
  final String? userID;
  @override
  final String? token;

  @override
  String toString() {
    return 'FcmTokenModel(userID: $userID, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FcmTokenModelImpl &&
            (identical(other.userID, userID) || other.userID == userID) &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userID, token);

  /// Create a copy of FcmTokenModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FcmTokenModelImplCopyWith<_$FcmTokenModelImpl> get copyWith =>
      __$$FcmTokenModelImplCopyWithImpl<_$FcmTokenModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FcmTokenModelImplToJson(this);
  }
}

abstract class _FcmTokenModel implements FcmTokenModel {
  const factory _FcmTokenModel({final String? userID, final String? token}) =
      _$FcmTokenModelImpl;

  factory _FcmTokenModel.fromJson(Map<String, dynamic> json) =
      _$FcmTokenModelImpl.fromJson;

  @override
  String? get userID;
  @override
  String? get token;

  /// Create a copy of FcmTokenModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FcmTokenModelImplCopyWith<_$FcmTokenModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
