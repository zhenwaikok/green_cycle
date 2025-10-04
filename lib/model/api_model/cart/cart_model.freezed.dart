// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CartModel _$CartModelFromJson(Map<String, dynamic> json) {
  return _CartModel.fromJson(json);
}

/// @nodoc
mixin _$CartModel {
  int? get cartID => throw _privateConstructorUsedError;
  String? get buyerUserID => throw _privateConstructorUsedError;
  String? get sellerUserID => throw _privateConstructorUsedError;
  int? get itemListingID => throw _privateConstructorUsedError;
  DateTime? get addedDate => throw _privateConstructorUsedError;
  ItemListingModel? get itemListing => throw _privateConstructorUsedError;

  /// Serializes this CartModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CartModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CartModelCopyWith<CartModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartModelCopyWith<$Res> {
  factory $CartModelCopyWith(CartModel value, $Res Function(CartModel) then) =
      _$CartModelCopyWithImpl<$Res, CartModel>;
  @useResult
  $Res call({
    int? cartID,
    String? buyerUserID,
    String? sellerUserID,
    int? itemListingID,
    DateTime? addedDate,
    ItemListingModel? itemListing,
  });

  $ItemListingModelCopyWith<$Res>? get itemListing;
}

/// @nodoc
class _$CartModelCopyWithImpl<$Res, $Val extends CartModel>
    implements $CartModelCopyWith<$Res> {
  _$CartModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CartModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cartID = freezed,
    Object? buyerUserID = freezed,
    Object? sellerUserID = freezed,
    Object? itemListingID = freezed,
    Object? addedDate = freezed,
    Object? itemListing = freezed,
  }) {
    return _then(
      _value.copyWith(
            cartID: freezed == cartID
                ? _value.cartID
                : cartID // ignore: cast_nullable_to_non_nullable
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
            addedDate: freezed == addedDate
                ? _value.addedDate
                : addedDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            itemListing: freezed == itemListing
                ? _value.itemListing
                : itemListing // ignore: cast_nullable_to_non_nullable
                      as ItemListingModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of CartModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ItemListingModelCopyWith<$Res>? get itemListing {
    if (_value.itemListing == null) {
      return null;
    }

    return $ItemListingModelCopyWith<$Res>(_value.itemListing!, (value) {
      return _then(_value.copyWith(itemListing: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CartModelImplCopyWith<$Res>
    implements $CartModelCopyWith<$Res> {
  factory _$$CartModelImplCopyWith(
    _$CartModelImpl value,
    $Res Function(_$CartModelImpl) then,
  ) = __$$CartModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? cartID,
    String? buyerUserID,
    String? sellerUserID,
    int? itemListingID,
    DateTime? addedDate,
    ItemListingModel? itemListing,
  });

  @override
  $ItemListingModelCopyWith<$Res>? get itemListing;
}

/// @nodoc
class __$$CartModelImplCopyWithImpl<$Res>
    extends _$CartModelCopyWithImpl<$Res, _$CartModelImpl>
    implements _$$CartModelImplCopyWith<$Res> {
  __$$CartModelImplCopyWithImpl(
    _$CartModelImpl _value,
    $Res Function(_$CartModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CartModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cartID = freezed,
    Object? buyerUserID = freezed,
    Object? sellerUserID = freezed,
    Object? itemListingID = freezed,
    Object? addedDate = freezed,
    Object? itemListing = freezed,
  }) {
    return _then(
      _$CartModelImpl(
        cartID: freezed == cartID
            ? _value.cartID
            : cartID // ignore: cast_nullable_to_non_nullable
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
        addedDate: freezed == addedDate
            ? _value.addedDate
            : addedDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        itemListing: freezed == itemListing
            ? _value.itemListing
            : itemListing // ignore: cast_nullable_to_non_nullable
                  as ItemListingModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CartModelImpl implements _CartModel {
  const _$CartModelImpl({
    this.cartID,
    this.buyerUserID,
    this.sellerUserID,
    this.itemListingID,
    this.addedDate,
    this.itemListing,
  });

  factory _$CartModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CartModelImplFromJson(json);

  @override
  final int? cartID;
  @override
  final String? buyerUserID;
  @override
  final String? sellerUserID;
  @override
  final int? itemListingID;
  @override
  final DateTime? addedDate;
  @override
  final ItemListingModel? itemListing;

  @override
  String toString() {
    return 'CartModel(cartID: $cartID, buyerUserID: $buyerUserID, sellerUserID: $sellerUserID, itemListingID: $itemListingID, addedDate: $addedDate, itemListing: $itemListing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartModelImpl &&
            (identical(other.cartID, cartID) || other.cartID == cartID) &&
            (identical(other.buyerUserID, buyerUserID) ||
                other.buyerUserID == buyerUserID) &&
            (identical(other.sellerUserID, sellerUserID) ||
                other.sellerUserID == sellerUserID) &&
            (identical(other.itemListingID, itemListingID) ||
                other.itemListingID == itemListingID) &&
            (identical(other.addedDate, addedDate) ||
                other.addedDate == addedDate) &&
            (identical(other.itemListing, itemListing) ||
                other.itemListing == itemListing));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    cartID,
    buyerUserID,
    sellerUserID,
    itemListingID,
    addedDate,
    itemListing,
  );

  /// Create a copy of CartModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartModelImplCopyWith<_$CartModelImpl> get copyWith =>
      __$$CartModelImplCopyWithImpl<_$CartModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CartModelImplToJson(this);
  }
}

abstract class _CartModel implements CartModel {
  const factory _CartModel({
    final int? cartID,
    final String? buyerUserID,
    final String? sellerUserID,
    final int? itemListingID,
    final DateTime? addedDate,
    final ItemListingModel? itemListing,
  }) = _$CartModelImpl;

  factory _CartModel.fromJson(Map<String, dynamic> json) =
      _$CartModelImpl.fromJson;

  @override
  int? get cartID;
  @override
  String? get buyerUserID;
  @override
  String? get sellerUserID;
  @override
  int? get itemListingID;
  @override
  DateTime? get addedDate;
  @override
  ItemListingModel? get itemListing;

  /// Create a copy of CartModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartModelImplCopyWith<_$CartModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
