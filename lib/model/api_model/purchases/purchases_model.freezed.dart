// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchases_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PurchasesModel _$PurchasesModelFromJson(Map<String, dynamic> json) {
  return _PurchasesModel.fromJson(json);
}

/// @nodoc
mixin _$PurchasesModel {
  int? get purchaseID => throw _privateConstructorUsedError;
  String? get buyerUserID => throw _privateConstructorUsedError;
  String? get sellerUserID => throw _privateConstructorUsedError;
  int? get itemListingID => throw _privateConstructorUsedError;
  String? get purchaseGroupID => throw _privateConstructorUsedError;
  String? get itemName => throw _privateConstructorUsedError;
  double? get itemPrice => throw _privateConstructorUsedError;
  String? get itemCondition => throw _privateConstructorUsedError;
  String? get itemCategory => throw _privateConstructorUsedError;
  List<String>? get itemImageURL => throw _privateConstructorUsedError;
  String? get deliveryAddress => throw _privateConstructorUsedError;
  bool? get isDelivered => throw _privateConstructorUsedError;
  DateTime? get purchaseDate => throw _privateConstructorUsedError;
  DateTime? get deliveredDate => throw _privateConstructorUsedError;

  /// Serializes this PurchasesModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PurchasesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchasesModelCopyWith<PurchasesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchasesModelCopyWith<$Res> {
  factory $PurchasesModelCopyWith(
    PurchasesModel value,
    $Res Function(PurchasesModel) then,
  ) = _$PurchasesModelCopyWithImpl<$Res, PurchasesModel>;
  @useResult
  $Res call({
    int? purchaseID,
    String? buyerUserID,
    String? sellerUserID,
    int? itemListingID,
    String? purchaseGroupID,
    String? itemName,
    double? itemPrice,
    String? itemCondition,
    String? itemCategory,
    List<String>? itemImageURL,
    String? deliveryAddress,
    bool? isDelivered,
    DateTime? purchaseDate,
    DateTime? deliveredDate,
  });
}

/// @nodoc
class _$PurchasesModelCopyWithImpl<$Res, $Val extends PurchasesModel>
    implements $PurchasesModelCopyWith<$Res> {
  _$PurchasesModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PurchasesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? purchaseID = freezed,
    Object? buyerUserID = freezed,
    Object? sellerUserID = freezed,
    Object? itemListingID = freezed,
    Object? purchaseGroupID = freezed,
    Object? itemName = freezed,
    Object? itemPrice = freezed,
    Object? itemCondition = freezed,
    Object? itemCategory = freezed,
    Object? itemImageURL = freezed,
    Object? deliveryAddress = freezed,
    Object? isDelivered = freezed,
    Object? purchaseDate = freezed,
    Object? deliveredDate = freezed,
  }) {
    return _then(
      _value.copyWith(
            purchaseID: freezed == purchaseID
                ? _value.purchaseID
                : purchaseID // ignore: cast_nullable_to_non_nullable
                      as int?,
            buyerUserID: freezed == buyerUserID
                ? _value.buyerUserID
                : buyerUserID // ignore: cast_nullable_to_non_nullable
                      as String?,
            sellerUserID: freezed == sellerUserID
                ? _value.sellerUserID
                : sellerUserID // ignore: cast_nullable_to_non_nullable
                      as String?,
            itemListingID: freezed == itemListingID
                ? _value.itemListingID
                : itemListingID // ignore: cast_nullable_to_non_nullable
                      as int?,
            purchaseGroupID: freezed == purchaseGroupID
                ? _value.purchaseGroupID
                : purchaseGroupID // ignore: cast_nullable_to_non_nullable
                      as String?,
            itemName: freezed == itemName
                ? _value.itemName
                : itemName // ignore: cast_nullable_to_non_nullable
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
            itemImageURL: freezed == itemImageURL
                ? _value.itemImageURL
                : itemImageURL // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            deliveryAddress: freezed == deliveryAddress
                ? _value.deliveryAddress
                : deliveryAddress // ignore: cast_nullable_to_non_nullable
                      as String?,
            isDelivered: freezed == isDelivered
                ? _value.isDelivered
                : isDelivered // ignore: cast_nullable_to_non_nullable
                      as bool?,
            purchaseDate: freezed == purchaseDate
                ? _value.purchaseDate
                : purchaseDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            deliveredDate: freezed == deliveredDate
                ? _value.deliveredDate
                : deliveredDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PurchasesModelImplCopyWith<$Res>
    implements $PurchasesModelCopyWith<$Res> {
  factory _$$PurchasesModelImplCopyWith(
    _$PurchasesModelImpl value,
    $Res Function(_$PurchasesModelImpl) then,
  ) = __$$PurchasesModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? purchaseID,
    String? buyerUserID,
    String? sellerUserID,
    int? itemListingID,
    String? purchaseGroupID,
    String? itemName,
    double? itemPrice,
    String? itemCondition,
    String? itemCategory,
    List<String>? itemImageURL,
    String? deliveryAddress,
    bool? isDelivered,
    DateTime? purchaseDate,
    DateTime? deliveredDate,
  });
}

/// @nodoc
class __$$PurchasesModelImplCopyWithImpl<$Res>
    extends _$PurchasesModelCopyWithImpl<$Res, _$PurchasesModelImpl>
    implements _$$PurchasesModelImplCopyWith<$Res> {
  __$$PurchasesModelImplCopyWithImpl(
    _$PurchasesModelImpl _value,
    $Res Function(_$PurchasesModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PurchasesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? purchaseID = freezed,
    Object? buyerUserID = freezed,
    Object? sellerUserID = freezed,
    Object? itemListingID = freezed,
    Object? purchaseGroupID = freezed,
    Object? itemName = freezed,
    Object? itemPrice = freezed,
    Object? itemCondition = freezed,
    Object? itemCategory = freezed,
    Object? itemImageURL = freezed,
    Object? deliveryAddress = freezed,
    Object? isDelivered = freezed,
    Object? purchaseDate = freezed,
    Object? deliveredDate = freezed,
  }) {
    return _then(
      _$PurchasesModelImpl(
        purchaseID: freezed == purchaseID
            ? _value.purchaseID
            : purchaseID // ignore: cast_nullable_to_non_nullable
                  as int?,
        buyerUserID: freezed == buyerUserID
            ? _value.buyerUserID
            : buyerUserID // ignore: cast_nullable_to_non_nullable
                  as String?,
        sellerUserID: freezed == sellerUserID
            ? _value.sellerUserID
            : sellerUserID // ignore: cast_nullable_to_non_nullable
                  as String?,
        itemListingID: freezed == itemListingID
            ? _value.itemListingID
            : itemListingID // ignore: cast_nullable_to_non_nullable
                  as int?,
        purchaseGroupID: freezed == purchaseGroupID
            ? _value.purchaseGroupID
            : purchaseGroupID // ignore: cast_nullable_to_non_nullable
                  as String?,
        itemName: freezed == itemName
            ? _value.itemName
            : itemName // ignore: cast_nullable_to_non_nullable
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
        itemImageURL: freezed == itemImageURL
            ? _value._itemImageURL
            : itemImageURL // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        deliveryAddress: freezed == deliveryAddress
            ? _value.deliveryAddress
            : deliveryAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
        isDelivered: freezed == isDelivered
            ? _value.isDelivered
            : isDelivered // ignore: cast_nullable_to_non_nullable
                  as bool?,
        purchaseDate: freezed == purchaseDate
            ? _value.purchaseDate
            : purchaseDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        deliveredDate: freezed == deliveredDate
            ? _value.deliveredDate
            : deliveredDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchasesModelImpl implements _PurchasesModel {
  const _$PurchasesModelImpl({
    this.purchaseID,
    this.buyerUserID,
    this.sellerUserID,
    this.itemListingID,
    this.purchaseGroupID,
    this.itemName,
    this.itemPrice,
    this.itemCondition,
    this.itemCategory,
    final List<String>? itemImageURL,
    this.deliveryAddress,
    this.isDelivered,
    this.purchaseDate,
    this.deliveredDate,
  }) : _itemImageURL = itemImageURL;

  factory _$PurchasesModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchasesModelImplFromJson(json);

  @override
  final int? purchaseID;
  @override
  final String? buyerUserID;
  @override
  final String? sellerUserID;
  @override
  final int? itemListingID;
  @override
  final String? purchaseGroupID;
  @override
  final String? itemName;
  @override
  final double? itemPrice;
  @override
  final String? itemCondition;
  @override
  final String? itemCategory;
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
  final String? deliveryAddress;
  @override
  final bool? isDelivered;
  @override
  final DateTime? purchaseDate;
  @override
  final DateTime? deliveredDate;

  @override
  String toString() {
    return 'PurchasesModel(purchaseID: $purchaseID, buyerUserID: $buyerUserID, sellerUserID: $sellerUserID, itemListingID: $itemListingID, purchaseGroupID: $purchaseGroupID, itemName: $itemName, itemPrice: $itemPrice, itemCondition: $itemCondition, itemCategory: $itemCategory, itemImageURL: $itemImageURL, deliveryAddress: $deliveryAddress, isDelivered: $isDelivered, purchaseDate: $purchaseDate, deliveredDate: $deliveredDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchasesModelImpl &&
            (identical(other.purchaseID, purchaseID) ||
                other.purchaseID == purchaseID) &&
            (identical(other.buyerUserID, buyerUserID) ||
                other.buyerUserID == buyerUserID) &&
            (identical(other.sellerUserID, sellerUserID) ||
                other.sellerUserID == sellerUserID) &&
            (identical(other.itemListingID, itemListingID) ||
                other.itemListingID == itemListingID) &&
            (identical(other.purchaseGroupID, purchaseGroupID) ||
                other.purchaseGroupID == purchaseGroupID) &&
            (identical(other.itemName, itemName) ||
                other.itemName == itemName) &&
            (identical(other.itemPrice, itemPrice) ||
                other.itemPrice == itemPrice) &&
            (identical(other.itemCondition, itemCondition) ||
                other.itemCondition == itemCondition) &&
            (identical(other.itemCategory, itemCategory) ||
                other.itemCategory == itemCategory) &&
            const DeepCollectionEquality().equals(
              other._itemImageURL,
              _itemImageURL,
            ) &&
            (identical(other.deliveryAddress, deliveryAddress) ||
                other.deliveryAddress == deliveryAddress) &&
            (identical(other.isDelivered, isDelivered) ||
                other.isDelivered == isDelivered) &&
            (identical(other.purchaseDate, purchaseDate) ||
                other.purchaseDate == purchaseDate) &&
            (identical(other.deliveredDate, deliveredDate) ||
                other.deliveredDate == deliveredDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    purchaseID,
    buyerUserID,
    sellerUserID,
    itemListingID,
    purchaseGroupID,
    itemName,
    itemPrice,
    itemCondition,
    itemCategory,
    const DeepCollectionEquality().hash(_itemImageURL),
    deliveryAddress,
    isDelivered,
    purchaseDate,
    deliveredDate,
  );

  /// Create a copy of PurchasesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchasesModelImplCopyWith<_$PurchasesModelImpl> get copyWith =>
      __$$PurchasesModelImplCopyWithImpl<_$PurchasesModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchasesModelImplToJson(this);
  }
}

abstract class _PurchasesModel implements PurchasesModel {
  const factory _PurchasesModel({
    final int? purchaseID,
    final String? buyerUserID,
    final String? sellerUserID,
    final int? itemListingID,
    final String? purchaseGroupID,
    final String? itemName,
    final double? itemPrice,
    final String? itemCondition,
    final String? itemCategory,
    final List<String>? itemImageURL,
    final String? deliveryAddress,
    final bool? isDelivered,
    final DateTime? purchaseDate,
    final DateTime? deliveredDate,
  }) = _$PurchasesModelImpl;

  factory _PurchasesModel.fromJson(Map<String, dynamic> json) =
      _$PurchasesModelImpl.fromJson;

  @override
  int? get purchaseID;
  @override
  String? get buyerUserID;
  @override
  String? get sellerUserID;
  @override
  int? get itemListingID;
  @override
  String? get purchaseGroupID;
  @override
  String? get itemName;
  @override
  double? get itemPrice;
  @override
  String? get itemCondition;
  @override
  String? get itemCategory;
  @override
  List<String>? get itemImageURL;
  @override
  String? get deliveryAddress;
  @override
  bool? get isDelivered;
  @override
  DateTime? get purchaseDate;
  @override
  DateTime? get deliveredDate;

  /// Create a copy of PurchasesModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchasesModelImplCopyWith<_$PurchasesModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
