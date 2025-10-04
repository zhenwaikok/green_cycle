import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchases_model.freezed.dart';
part 'purchases_model.g.dart';

@freezed
class PurchasesModel with _$PurchasesModel {
  const factory PurchasesModel({
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
    String? status,
    DateTime? purchaseDate,
    DateTime? deliveredDate,
  }) = _PurchasesModel;

  factory PurchasesModel.fromJson(Map<String, dynamic> json) =>
      _$PurchasesModelFromJson(json);
}
