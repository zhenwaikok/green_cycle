// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartModelImpl _$$CartModelImplFromJson(Map<String, dynamic> json) =>
    _$CartModelImpl(
      cartID: (json['cartID'] as num?)?.toInt(),
      buyerUserID: json['buyerUserID'] as String?,
      sellerUserID: json['sellerUserID'] as String?,
      itemListingID: (json['itemListingID'] as num?)?.toInt(),
      addedDate: json['addedDate'] == null
          ? null
          : DateTime.parse(json['addedDate'] as String),
      itemListing: json['itemListing'] == null
          ? null
          : ItemListingModel.fromJson(
              json['itemListing'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CartModelImplToJson(_$CartModelImpl instance) =>
    <String, dynamic>{
      'cartID': instance.cartID,
      'buyerUserID': instance.buyerUserID,
      'sellerUserID': instance.sellerUserID,
      'itemListingID': instance.itemListingID,
      'addedDate': instance.addedDate?.toIso8601String(),
      'itemListing': instance.itemListing,
    };
