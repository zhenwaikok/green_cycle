import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:green_cycle_fyp/model/api_model/item_listing/item_listing_model.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

@freezed
class CartModel with _$CartModel {
  const factory CartModel({
    int? cartID,
    String? buyerUserID,
    String? sellerUserID,
    int? itemListingID,
    DateTime? addedDate,
    ItemListingModel? itemListing,
  }) = _CartModel;

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);
}
