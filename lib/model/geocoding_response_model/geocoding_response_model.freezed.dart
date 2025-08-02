// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'geocoding_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GeocodingResponseModel _$GeocodingResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _GeocodingResponseModel.fromJson(json);
}

/// @nodoc
mixin _$GeocodingResponseModel {
  List<GeocodingResult>? get results => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  /// Serializes this GeocodingResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GeocodingResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GeocodingResponseModelCopyWith<GeocodingResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeocodingResponseModelCopyWith<$Res> {
  factory $GeocodingResponseModelCopyWith(
    GeocodingResponseModel value,
    $Res Function(GeocodingResponseModel) then,
  ) = _$GeocodingResponseModelCopyWithImpl<$Res, GeocodingResponseModel>;
  @useResult
  $Res call({List<GeocodingResult>? results, String? status});
}

/// @nodoc
class _$GeocodingResponseModelCopyWithImpl<
  $Res,
  $Val extends GeocodingResponseModel
>
    implements $GeocodingResponseModelCopyWith<$Res> {
  _$GeocodingResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GeocodingResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? results = freezed, Object? status = freezed}) {
    return _then(
      _value.copyWith(
            results: freezed == results
                ? _value.results
                : results // ignore: cast_nullable_to_non_nullable
                      as List<GeocodingResult>?,
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
abstract class _$$GeocodingResponseModelImplCopyWith<$Res>
    implements $GeocodingResponseModelCopyWith<$Res> {
  factory _$$GeocodingResponseModelImplCopyWith(
    _$GeocodingResponseModelImpl value,
    $Res Function(_$GeocodingResponseModelImpl) then,
  ) = __$$GeocodingResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<GeocodingResult>? results, String? status});
}

/// @nodoc
class __$$GeocodingResponseModelImplCopyWithImpl<$Res>
    extends
        _$GeocodingResponseModelCopyWithImpl<$Res, _$GeocodingResponseModelImpl>
    implements _$$GeocodingResponseModelImplCopyWith<$Res> {
  __$$GeocodingResponseModelImplCopyWithImpl(
    _$GeocodingResponseModelImpl _value,
    $Res Function(_$GeocodingResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GeocodingResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? results = freezed, Object? status = freezed}) {
    return _then(
      _$GeocodingResponseModelImpl(
        results: freezed == results
            ? _value._results
            : results // ignore: cast_nullable_to_non_nullable
                  as List<GeocodingResult>?,
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
class _$GeocodingResponseModelImpl implements _GeocodingResponseModel {
  const _$GeocodingResponseModelImpl({
    final List<GeocodingResult>? results,
    this.status,
  }) : _results = results;

  factory _$GeocodingResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeocodingResponseModelImplFromJson(json);

  final List<GeocodingResult>? _results;
  @override
  List<GeocodingResult>? get results {
    final value = _results;
    if (value == null) return null;
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? status;

  @override
  String toString() {
    return 'GeocodingResponseModel(results: $results, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeocodingResponseModelImpl &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_results),
    status,
  );

  /// Create a copy of GeocodingResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GeocodingResponseModelImplCopyWith<_$GeocodingResponseModelImpl>
  get copyWith =>
      __$$GeocodingResponseModelImplCopyWithImpl<_$GeocodingResponseModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GeocodingResponseModelImplToJson(this);
  }
}

abstract class _GeocodingResponseModel implements GeocodingResponseModel {
  const factory _GeocodingResponseModel({
    final List<GeocodingResult>? results,
    final String? status,
  }) = _$GeocodingResponseModelImpl;

  factory _GeocodingResponseModel.fromJson(Map<String, dynamic> json) =
      _$GeocodingResponseModelImpl.fromJson;

  @override
  List<GeocodingResult>? get results;
  @override
  String? get status;

  /// Create a copy of GeocodingResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GeocodingResponseModelImplCopyWith<_$GeocodingResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

GeocodingResult _$GeocodingResultFromJson(Map<String, dynamic> json) {
  return _GeocodingResult.fromJson(json);
}

/// @nodoc
mixin _$GeocodingResult {
  // ignore: invalid_annotation_target
  @JsonKey(name: 'formatted_address')
  String? get formattedAddress => throw _privateConstructorUsedError;

  /// Serializes this GeocodingResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GeocodingResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GeocodingResultCopyWith<GeocodingResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeocodingResultCopyWith<$Res> {
  factory $GeocodingResultCopyWith(
    GeocodingResult value,
    $Res Function(GeocodingResult) then,
  ) = _$GeocodingResultCopyWithImpl<$Res, GeocodingResult>;
  @useResult
  $Res call({@JsonKey(name: 'formatted_address') String? formattedAddress});
}

/// @nodoc
class _$GeocodingResultCopyWithImpl<$Res, $Val extends GeocodingResult>
    implements $GeocodingResultCopyWith<$Res> {
  _$GeocodingResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GeocodingResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? formattedAddress = freezed}) {
    return _then(
      _value.copyWith(
            formattedAddress: freezed == formattedAddress
                ? _value.formattedAddress
                : formattedAddress // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GeocodingResultImplCopyWith<$Res>
    implements $GeocodingResultCopyWith<$Res> {
  factory _$$GeocodingResultImplCopyWith(
    _$GeocodingResultImpl value,
    $Res Function(_$GeocodingResultImpl) then,
  ) = __$$GeocodingResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'formatted_address') String? formattedAddress});
}

/// @nodoc
class __$$GeocodingResultImplCopyWithImpl<$Res>
    extends _$GeocodingResultCopyWithImpl<$Res, _$GeocodingResultImpl>
    implements _$$GeocodingResultImplCopyWith<$Res> {
  __$$GeocodingResultImplCopyWithImpl(
    _$GeocodingResultImpl _value,
    $Res Function(_$GeocodingResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GeocodingResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? formattedAddress = freezed}) {
    return _then(
      _$GeocodingResultImpl(
        formattedAddress: freezed == formattedAddress
            ? _value.formattedAddress
            : formattedAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GeocodingResultImpl implements _GeocodingResult {
  const _$GeocodingResultImpl({
    @JsonKey(name: 'formatted_address') this.formattedAddress,
  });

  factory _$GeocodingResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeocodingResultImplFromJson(json);

  // ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'formatted_address')
  final String? formattedAddress;

  @override
  String toString() {
    return 'GeocodingResult(formattedAddress: $formattedAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeocodingResultImpl &&
            (identical(other.formattedAddress, formattedAddress) ||
                other.formattedAddress == formattedAddress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, formattedAddress);

  /// Create a copy of GeocodingResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GeocodingResultImplCopyWith<_$GeocodingResultImpl> get copyWith =>
      __$$GeocodingResultImplCopyWithImpl<_$GeocodingResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GeocodingResultImplToJson(this);
  }
}

abstract class _GeocodingResult implements GeocodingResult {
  const factory _GeocodingResult({
    @JsonKey(name: 'formatted_address') final String? formattedAddress,
  }) = _$GeocodingResultImpl;

  factory _GeocodingResult.fromJson(Map<String, dynamic> json) =
      _$GeocodingResultImpl.fromJson;

  // ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'formatted_address')
  String? get formattedAddress;

  /// Create a copy of GeocodingResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GeocodingResultImplCopyWith<_$GeocodingResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
