// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchases_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PurchasesModelImpl _$$PurchasesModelImplFromJson(Map<String, dynamic> json) =>
    _$PurchasesModelImpl(
      purchaseID: (json['purchaseID'] as num?)?.toInt(),
      buyerUserID: json['buyerUserID'] as String?,
      sellerUserID: json['sellerUserID'] as String?,
      itemListingID: (json['itemListingID'] as num?)?.toInt(),
      purchaseGroupID: json['purchaseGroupID'] as String?,
      itemName: json['itemName'] as String?,
      itemPrice: (json['itemPrice'] as num?)?.toDouble(),
      itemCondition: json['itemCondition'] as String?,
      itemCategory: json['itemCategory'] as String?,
      itemImageURL: (json['itemImageURL'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      deliveryAddress: json['deliveryAddress'] as String?,
      isDelivered: json['isDelivered'] as bool?,
      purchaseDate: json['purchaseDate'] == null
          ? null
          : DateTime.parse(json['purchaseDate'] as String),
      deliveredDate: json['deliveredDate'] == null
          ? null
          : DateTime.parse(json['deliveredDate'] as String),
    );

Map<String, dynamic> _$$PurchasesModelImplToJson(
  _$PurchasesModelImpl instance,
) => <String, dynamic>{
  'purchaseID': instance.purchaseID,
  'buyerUserID': instance.buyerUserID,
  'sellerUserID': instance.sellerUserID,
  'itemListingID': instance.itemListingID,
  'purchaseGroupID': instance.purchaseGroupID,
  'itemName': instance.itemName,
  'itemPrice': instance.itemPrice,
  'itemCondition': instance.itemCondition,
  'itemCategory': instance.itemCategory,
  'itemImageURL': instance.itemImageURL,
  'deliveryAddress': instance.deliveryAddress,
  'isDelivered': instance.isDelivered,
  'purchaseDate': instance.purchaseDate?.toIso8601String(),
  'deliveredDate': instance.deliveredDate?.toIso8601String(),
};
