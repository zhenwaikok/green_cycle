// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchases_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PurchasesModelImpl _$$PurchasesModelImplFromJson(Map<String, dynamic> json) =>
    _$PurchasesModelImpl(
      purchaseID: json['purchaseID'] as String?,
      buyerUserID: json['buyerUserID'] as String?,
      sellerUserID: json['sellerUserID'] as String?,
      itemListingID: (json['itemListingID'] as num?)?.toInt(),
      itemName: json['itemName'] as String?,
      itemPrice: (json['itemPrice'] as num?)?.toDouble(),
      itemCondition: json['itemCondition'] as String?,
      itemCategory: json['itemCategory'] as String?,
      itemImageURL: (json['itemImageURL'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isDelivered: json['isDelivered'] as bool?,
      purchasedDate: json['purchasedDate'] == null
          ? null
          : DateTime.parse(json['purchasedDate'] as String),
      deliveredDate: json['deliveredDate'] == null
          ? null
          : DateTime.parse(json['deliveredDate'] as String),
    );

Map<String, dynamic> _$$PurchasesModelImplToJson(
        _$PurchasesModelImpl instance) =>
    <String, dynamic>{
      'purchaseID': instance.purchaseID,
      'buyerUserID': instance.buyerUserID,
      'sellerUserID': instance.sellerUserID,
      'itemListingID': instance.itemListingID,
      'itemName': instance.itemName,
      'itemPrice': instance.itemPrice,
      'itemCondition': instance.itemCondition,
      'itemCategory': instance.itemCategory,
      'itemImageURL': instance.itemImageURL,
      'isDelivered': instance.isDelivered,
      'purchasedDate': instance.purchasedDate?.toIso8601String(),
      'deliveredDate': instance.deliveredDate?.toIso8601String(),
    };
