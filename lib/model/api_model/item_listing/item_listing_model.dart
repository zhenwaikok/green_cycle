import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_listing_model.freezed.dart';
part 'item_listing_model.g.dart';

@freezed
class ItemListingModel with _$ItemListingModel {
  const factory ItemListingModel({
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
  }) = _ItemListingModel;

  factory ItemListingModel.fromJson(Map<String, dynamic> json) =>
      _$ItemListingModelFromJson(json);
}
