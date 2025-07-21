// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'awareness_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AwarenessModel _$AwarenessModelFromJson(Map<String, dynamic> json) {
  return _AwarenessModel.fromJson(json);
}

/// @nodoc
mixin _$AwarenessModel {
  int? get awarenessID => throw _privateConstructorUsedError;
  String? get awarenessImageURL => throw _privateConstructorUsedError;
  String? get awarenessTitle => throw _privateConstructorUsedError;
  String? get awarenessContent => throw _privateConstructorUsedError;
  DateTime? get createdDate => throw _privateConstructorUsedError;

  /// Serializes this AwarenessModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AwarenessModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AwarenessModelCopyWith<AwarenessModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AwarenessModelCopyWith<$Res> {
  factory $AwarenessModelCopyWith(
          AwarenessModel value, $Res Function(AwarenessModel) then) =
      _$AwarenessModelCopyWithImpl<$Res, AwarenessModel>;
  @useResult
  $Res call(
      {int? awarenessID,
      String? awarenessImageURL,
      String? awarenessTitle,
      String? awarenessContent,
      DateTime? createdDate});
}

/// @nodoc
class _$AwarenessModelCopyWithImpl<$Res, $Val extends AwarenessModel>
    implements $AwarenessModelCopyWith<$Res> {
  _$AwarenessModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AwarenessModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? awarenessID = freezed,
    Object? awarenessImageURL = freezed,
    Object? awarenessTitle = freezed,
    Object? awarenessContent = freezed,
    Object? createdDate = freezed,
  }) {
    return _then(_value.copyWith(
      awarenessID: freezed == awarenessID
          ? _value.awarenessID
          : awarenessID // ignore: cast_nullable_to_non_nullable
              as int?,
      awarenessImageURL: freezed == awarenessImageURL
          ? _value.awarenessImageURL
          : awarenessImageURL // ignore: cast_nullable_to_non_nullable
              as String?,
      awarenessTitle: freezed == awarenessTitle
          ? _value.awarenessTitle
          : awarenessTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      awarenessContent: freezed == awarenessContent
          ? _value.awarenessContent
          : awarenessContent // ignore: cast_nullable_to_non_nullable
              as String?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AwarenessModelImplCopyWith<$Res>
    implements $AwarenessModelCopyWith<$Res> {
  factory _$$AwarenessModelImplCopyWith(_$AwarenessModelImpl value,
          $Res Function(_$AwarenessModelImpl) then) =
      __$$AwarenessModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? awarenessID,
      String? awarenessImageURL,
      String? awarenessTitle,
      String? awarenessContent,
      DateTime? createdDate});
}

/// @nodoc
class __$$AwarenessModelImplCopyWithImpl<$Res>
    extends _$AwarenessModelCopyWithImpl<$Res, _$AwarenessModelImpl>
    implements _$$AwarenessModelImplCopyWith<$Res> {
  __$$AwarenessModelImplCopyWithImpl(
      _$AwarenessModelImpl _value, $Res Function(_$AwarenessModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AwarenessModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? awarenessID = freezed,
    Object? awarenessImageURL = freezed,
    Object? awarenessTitle = freezed,
    Object? awarenessContent = freezed,
    Object? createdDate = freezed,
  }) {
    return _then(_$AwarenessModelImpl(
      awarenessID: freezed == awarenessID
          ? _value.awarenessID
          : awarenessID // ignore: cast_nullable_to_non_nullable
              as int?,
      awarenessImageURL: freezed == awarenessImageURL
          ? _value.awarenessImageURL
          : awarenessImageURL // ignore: cast_nullable_to_non_nullable
              as String?,
      awarenessTitle: freezed == awarenessTitle
          ? _value.awarenessTitle
          : awarenessTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      awarenessContent: freezed == awarenessContent
          ? _value.awarenessContent
          : awarenessContent // ignore: cast_nullable_to_non_nullable
              as String?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AwarenessModelImpl implements _AwarenessModel {
  const _$AwarenessModelImpl(
      {this.awarenessID,
      this.awarenessImageURL,
      this.awarenessTitle,
      this.awarenessContent,
      this.createdDate});

  factory _$AwarenessModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AwarenessModelImplFromJson(json);

  @override
  final int? awarenessID;
  @override
  final String? awarenessImageURL;
  @override
  final String? awarenessTitle;
  @override
  final String? awarenessContent;
  @override
  final DateTime? createdDate;

  @override
  String toString() {
    return 'AwarenessModel(awarenessID: $awarenessID, awarenessImageURL: $awarenessImageURL, awarenessTitle: $awarenessTitle, awarenessContent: $awarenessContent, createdDate: $createdDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AwarenessModelImpl &&
            (identical(other.awarenessID, awarenessID) ||
                other.awarenessID == awarenessID) &&
            (identical(other.awarenessImageURL, awarenessImageURL) ||
                other.awarenessImageURL == awarenessImageURL) &&
            (identical(other.awarenessTitle, awarenessTitle) ||
                other.awarenessTitle == awarenessTitle) &&
            (identical(other.awarenessContent, awarenessContent) ||
                other.awarenessContent == awarenessContent) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, awarenessID, awarenessImageURL,
      awarenessTitle, awarenessContent, createdDate);

  /// Create a copy of AwarenessModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AwarenessModelImplCopyWith<_$AwarenessModelImpl> get copyWith =>
      __$$AwarenessModelImplCopyWithImpl<_$AwarenessModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AwarenessModelImplToJson(
      this,
    );
  }
}

abstract class _AwarenessModel implements AwarenessModel {
  const factory _AwarenessModel(
      {final int? awarenessID,
      final String? awarenessImageURL,
      final String? awarenessTitle,
      final String? awarenessContent,
      final DateTime? createdDate}) = _$AwarenessModelImpl;

  factory _AwarenessModel.fromJson(Map<String, dynamic> json) =
      _$AwarenessModelImpl.fromJson;

  @override
  int? get awarenessID;
  @override
  String? get awarenessImageURL;
  @override
  String? get awarenessTitle;
  @override
  String? get awarenessContent;
  @override
  DateTime? get createdDate;

  /// Create a copy of AwarenessModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AwarenessModelImplCopyWith<_$AwarenessModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
