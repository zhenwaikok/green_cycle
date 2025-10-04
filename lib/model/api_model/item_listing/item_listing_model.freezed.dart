// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_listing_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ItemListingModel _$ItemListingModelFromJson(Map<String, dynamic> json) {
  return _ItemListingModel.fromJson(json);
}

/// @nodoc
mixin _$ItemListingModel {
  int? get itemListingID => throw _privateConstructorUsedError;
  String? get userID => throw _privateConstructorUsedError;
  List<String>? get itemImageURL => throw _privateConstructorUsedError;
  String? get itemName => throw _privateConstructorUsedError;
  String? get itemDescription => throw _privateConstructorUsedError;
  double? get itemPrice => throw _privateConstructorUsedError;
  String? get itemCondition => throw _privateConstructorUsedError;
  String? get itemCategory => throw _privateConstructorUsedError;
  bool? get isSold => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  DateTime? get createdDate => throw _privateConstructorUsedError;

  /// Serializes this ItemListingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ItemListingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ItemListingModelCopyWith<ItemListingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemListingModelCopyWith<$Res> {
  factory $ItemListingModelCopyWith(
    ItemListingModel value,
    $Res Function(ItemListingModel) then,
  ) = _$ItemListingModelCopyWithImpl<$Res, ItemListingModel>;
  @useResult
  $Res call({
    int? itemListingID,
    String? userID,
    List<String>? itemImageURL,
    String? itemName,
    String? itemDescription,
    double? itemPrice,
    String? itemCondition,
    String? itemCategory,
    bool? isSold,
    String? status,
    DateTime? createdDate,
  });
}

/// @nodoc
class _$ItemListingModelCopyWithImpl<$Res, $Val extends ItemListingModel>
    implements $ItemListingModelCopyWith<$Res> {
  _$ItemListingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ItemListingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemListingID = freezed,
    Object? userID = freezed,
    Object? itemImageURL = freezed,
    Object? itemName = freezed,
    Object? itemDescription = freezed,
    Object? itemPrice = freezed,
    Object? itemCondition = freezed,
    Object? itemCategory = freezed,
    Object? isSold = freezed,
    Object? status = freezed,
    Object? createdDate = freezed,
  }) {
    return _then(
      _value.copyWith(
            itemListingID: freezed == itemListingID
                ? _value.itemListingID
                : itemListingID // ignore: cast_nullable_to_non_nullable
                      as int?,
            userID: freezed == userID
                ? _value.userID
                : userID // ignore: cast_nullable_to_non_nullable
                      as String?,
            itemImageURL: freezed == itemImageURL
                ? _value.itemImageURL
                : itemImageURL // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            itemName: freezed == itemName
                ? _value.itemName
                : itemName // ignore: cast_nullable_to_non_nullable
                      as String?,
            itemDescription: freezed == itemDescription
                ? _value.itemDescription
                : itemDescription // ignore: cast_nullable_to_non_nullable
                      as String?,
            itemPrice: freezed == itemPrice
                ? _value.itemPrice
                : itemPrice // ignore: cast_nullable_to_non_nullable
                      as double?,
            itemCondition: freezed == itemCondition
                ? _value.itemCondition
                : itemCondition // ignore: cast_nullable_to_non_nullable
                      as String?,
            itemCategory: freezed == itemCategory
                ? _value.itemCategory
                : itemCategory // ignore: cast_nullable_to_non_nullable
                      as String?,
            isSold: freezed == isSold
                ? _value.isSold
                : isSold // ignore: cast_nullable_to_non_nullable
                      as bool?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ItemListingModelImplCopyWith<$Res>
    implements $ItemListingModelCopyWith<$Res> {
  factory _$$ItemListingModelImplCopyWith(
    _$ItemListingModelImpl value,
    $Res Function(_$ItemListingModelImpl) then,
  ) = __$$ItemListingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? itemListingID,
    String? userID,
    List<String>? itemImageURL,
    String? itemName,
    String? itemDescription,
    double? itemPrice,
    String? itemCondition,
    String? itemCategory,
    bool? isSold,
    String? status,
    DateTime? createdDate,
  });
}

/// @nodoc
class __$$ItemListingModelImplCopyWithImpl<$Res>
    extends _$ItemListingModelCopyWithImpl<$Res, _$ItemListingModelImpl>
    implements _$$ItemListingModelImplCopyWith<$Res> {
  __$$ItemListingModelImplCopyWithImpl(
    _$ItemListingModelImpl _value,
    $Res Function(_$ItemListingModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ItemListingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemListingID = freezed,
    Object? userID = freezed,
    Object? itemImageURL = freezed,
    Object? itemName = freezed,
    Object? itemDescription = freezed,
    Object? itemPrice = freezed,
    Object? itemCondition = freezed,
    Object? itemCategory = freezed,
    Object? isSold = freezed,
    Object? status = freezed,
    Object? createdDate = freezed,
  }) {
    return _then(
      _$ItemListingModelImpl(
        itemListingID: freezed == itemListingID
            ? _value.itemListingID
            : itemListingID // ignore: cast_nullable_to_non_nullable
                  as int?,
        userID: freezed == userID
            ? _value.userID
            : userID // ignore: cast_nullable_to_non_nullable
                  as String?,
        itemImageURL: freezed == itemImageURL
            ? _value._itemImageURL
            : itemImageURL // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        itemName: freezed == itemName
            ? _value.itemName
            : itemName // ignore: cast_nullable_to_non_nullable
                  as String?,
        itemDescription: freezed == itemDescription
            ? _value.itemDescription
            : itemDescription // ignore: cast_nullable_to_non_nullable
                  as String?,
        itemPrice: freezed == itemPrice
            ? _value.itemPrice
            : itemPrice // ignore: cast_nullable_to_non_nullable
                  as double?,
        itemCondition: freezed == itemCondition
            ? _value.itemCondition
            : itemCondition // ignore: cast_nullable_to_non_nullable
                  as String?,
        itemCategory: freezed == itemCategory
            ? _value.itemCategory
            : itemCategory // ignore: cast_nullable_to_non_nullable
                  as String?,
        isSold: freezed == isSold
            ? _value.isSold
            : isSold // ignore: cast_nullable_to_non_nullable
                  as bool?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
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
class _$ItemListingModelImpl implements _ItemListingModel {
  const _$ItemListingModelImpl({
    this.itemListingID,
    this.userID,
    final List<String>? itemImageURL,
    this.itemName,
    this.itemDescription,
    this.itemPrice,
    this.itemCondition,
    this.itemCategory,
    this.isSold,
    this.status,
    this.createdDate,
  }) : _itemImageURL = itemImageURL;

  factory _$ItemListingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemListingModelImplFromJson(json);

  @override
  final int? itemListingID;
  @override
  final String? userID;
  final List<String>? _itemImageURL;
  @override
  List<String>? get itemImageURL {
    final value = _itemImageURL;
    if (value == null) return null;
    if (_itemImageURL is EqualUnmodifiableListView) return _itemImageURL;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? itemName;
  @override
  final String? itemDescription;
  @override
  final double? itemPrice;
  @override
  final String? itemCondition;
  @override
  final String? itemCategory;
  @override
  final bool? isSold;
  @override
  final String? status;
  @override
  final DateTime? createdDate;

  @override
  String toString() {
    return 'ItemListingModel(itemListingID: $itemListingID, userID: $userID, itemImageURL: $itemImageURL, itemName: $itemName, itemDescription: $itemDescription, itemPrice: $itemPrice, itemCondition: $itemCondition, itemCategory: $itemCategory, isSold: $isSold, status: $status, createdDate: $createdDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemListingModelImpl &&
            (identical(other.itemListingID, itemListingID) ||
                other.itemListingID == itemListingID) &&
            (identical(other.userID, userID) || other.userID == userID) &&
            const DeepCollectionEquality().equals(
              other._itemImageURL,
              _itemImageURL,
            ) &&
            (identical(other.itemName, itemName) ||
                other.itemName == itemName) &&
            (identical(other.itemDescription, itemDescription) ||
                other.itemDescription == itemDescription) &&
            (identical(other.itemPrice, itemPrice) ||
                other.itemPrice == itemPrice) &&
            (identical(other.itemCondition, itemCondition) ||
                other.itemCondition == itemCondition) &&
            (identical(other.itemCategory, itemCategory) ||
                other.itemCategory == itemCategory) &&
            (identical(other.isSold, isSold) || other.isSold == isSold) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    itemListingID,
    userID,
    const DeepCollectionEquality().hash(_itemImageURL),
    itemName,
    itemDescription,
    itemPrice,
    itemCondition,
    itemCategory,
    isSold,
    status,
    createdDate,
  );

  /// Create a copy of ItemListingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemListingModelImplCopyWith<_$ItemListingModelImpl> get copyWith =>
      __$$ItemListingModelImplCopyWithImpl<_$ItemListingModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemListingModelImplToJson(this);
  }
}

abstract class _ItemListingModel implements ItemListingModel {
  const factory _ItemListingModel({
    final int? itemListingID,
    final String? userID,
    final List<String>? itemImageURL,
    final String? itemName,
    final String? itemDescription,
    final double? itemPrice,
    final String? itemCondition,
    final String? itemCategory,
    final bool? isSold,
    final String? status,
    final DateTime? createdDate,
  }) = _$ItemListingModelImpl;

  factory _ItemListingModel.fromJson(Map<String, dynamic> json) =
      _$ItemListingModelImpl.fromJson;

  @override
  int? get itemListingID;
  @override
  String? get userID;
  @override
  List<String>? get itemImageURL;
  @override
  String? get itemName;
  @override
  String? get itemDescription;
  @override
  double? get itemPrice;
  @override
  String? get itemCondition;
  @override
  String? get itemCategory;
  @override
  bool? get isSold;
  @override
  String? get status;
  @override
  DateTime? get createdDate;

  /// Create a copy of ItemListingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ItemListingModelImplCopyWith<_$ItemListingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
