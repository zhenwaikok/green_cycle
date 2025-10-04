// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remote_message_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RemoteMessageDataModel _$RemoteMessageDataModelFromJson(
  Map<String, dynamic> json,
) {
  return _RemoteMessageDataModel.fromJson(json);
}

/// @nodoc
mixin _$RemoteMessageDataModel {
  @JsonKey(name: 'DeepLink')
  String? get deeplink => throw _privateConstructorUsedError;

  /// Serializes this RemoteMessageDataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RemoteMessageDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RemoteMessageDataModelCopyWith<RemoteMessageDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemoteMessageDataModelCopyWith<$Res> {
  factory $RemoteMessageDataModelCopyWith(
    RemoteMessageDataModel value,
    $Res Function(RemoteMessageDataModel) then,
  ) = _$RemoteMessageDataModelCopyWithImpl<$Res, RemoteMessageDataModel>;
  @useResult
  $Res call({@JsonKey(name: 'DeepLink') String? deeplink});
}

/// @nodoc
class _$RemoteMessageDataModelCopyWithImpl<
  $Res,
  $Val extends RemoteMessageDataModel
>
    implements $RemoteMessageDataModelCopyWith<$Res> {
  _$RemoteMessageDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RemoteMessageDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? deeplink = freezed}) {
    return _then(
      _value.copyWith(
            deeplink: freezed == deeplink
                ? _value.deeplink
                : deeplink // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RemoteMessageDataModelImplCopyWith<$Res>
    implements $RemoteMessageDataModelCopyWith<$Res> {
  factory _$$RemoteMessageDataModelImplCopyWith(
    _$RemoteMessageDataModelImpl value,
    $Res Function(_$RemoteMessageDataModelImpl) then,
  ) = __$$RemoteMessageDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'DeepLink') String? deeplink});
}

/// @nodoc
class __$$RemoteMessageDataModelImplCopyWithImpl<$Res>
    extends
        _$RemoteMessageDataModelCopyWithImpl<$Res, _$RemoteMessageDataModelImpl>
    implements _$$RemoteMessageDataModelImplCopyWith<$Res> {
  __$$RemoteMessageDataModelImplCopyWithImpl(
    _$RemoteMessageDataModelImpl _value,
    $Res Function(_$RemoteMessageDataModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RemoteMessageDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? deeplink = freezed}) {
    return _then(
      _$RemoteMessageDataModelImpl(
        deeplink: freezed == deeplink
            ? _value.deeplink
            : deeplink // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RemoteMessageDataModelImpl implements _RemoteMessageDataModel {
  _$RemoteMessageDataModelImpl({@JsonKey(name: 'DeepLink') this.deeplink});

  factory _$RemoteMessageDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RemoteMessageDataModelImplFromJson(json);

  @override
  @JsonKey(name: 'DeepLink')
  final String? deeplink;

  @override
  String toString() {
    return 'RemoteMessageDataModel(deeplink: $deeplink)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoteMessageDataModelImpl &&
            (identical(other.deeplink, deeplink) ||
                other.deeplink == deeplink));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, deeplink);

  /// Create a copy of RemoteMessageDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoteMessageDataModelImplCopyWith<_$RemoteMessageDataModelImpl>
  get copyWith =>
      __$$RemoteMessageDataModelImplCopyWithImpl<_$RemoteMessageDataModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RemoteMessageDataModelImplToJson(this);
  }
}

abstract class _RemoteMessageDataModel implements RemoteMessageDataModel {
  factory _RemoteMessageDataModel({
    @JsonKey(name: 'DeepLink') final String? deeplink,
  }) = _$RemoteMessageDataModelImpl;

  factory _RemoteMessageDataModel.fromJson(Map<String, dynamic> json) =
      _$RemoteMessageDataModelImpl.fromJson;

  @override
  @JsonKey(name: 'DeepLink')
  String? get deeplink;

  /// Create a copy of RemoteMessageDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoteMessageDataModelImplCopyWith<_$RemoteMessageDataModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
