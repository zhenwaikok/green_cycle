// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_listing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemListingModelImpl _$$ItemListingModelImplFromJson(
  Map<String, dynamic> json,
) => _$ItemListingModelImpl(
  itemListingID: (json['itemListingID'] as num?)?.toInt(),
  userID: json['userID'] as String?,
  itemImageURL: (json['itemImageURL'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  itemName: json['itemName'] as String?,
  itemDescription: json['itemDescription'] as String?,
  itemPrice: (json['itemPrice'] as num?)?.toDouble(),
  itemCondition: json['itemCondition'] as String?,
  itemCategory: json['itemCategory'] as String?,
  isSold: json['isSold'] as bool?,
  status: json['status'] as String?,
  createdDate: json['createdDate'] == null
      ? null
      : DateTime.parse(json['createdDate'] as String),
);

Map<String, dynamic> _$$ItemListingModelImplToJson(
  _$ItemListingModelImpl instance,
) => <String, dynamic>{
  'itemListingID': instance.itemListingID,
  'userID': instance.userID,
  'itemImageURL': instance.itemImageURL,
  'itemName': instance.itemName,
  'itemDescription': instance.itemDescription,
  'itemPrice': instance.itemPrice,
  'itemCondition': instance.itemCondition,
  'itemCategory': instance.itemCategory,
  'isSold': instance.isSold,
  'status': instance.status,
  'createdDate': instance.createdDate?.toIso8601String(),
};
