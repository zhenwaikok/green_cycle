import 'package:green_cycle_fyp/model/api_model/purchases/purchases_model.dart';
import 'package:green_cycle_fyp/repository/purchases_repository.dart';
import 'package:green_cycle_fyp/viewmodel/base_view_model.dart';

class PurchaseViewModel extends BaseViewModel {
  PurchaseViewModel({required this.purchasesRepository});

  final PurchasesRepository purchasesRepository;

  Future<bool> insertPurchases({
    required String buyerUserID,
    required String sellerUserID,
    required int itemListingID,
    required String purchaseGroupID,
    required String itemName,
    required double itemPrice,
    required String itemCondition,
    required String itemCategory,
    required List<String> itemImageURL,
    required String deliveryAddress,
  }) async {
    PurchasesModel purchasesModel = PurchasesModel(
      buyerUserID: buyerUserID,
      sellerUserID: sellerUserID,
      itemListingID: itemListingID,
      purchaseGroupID: purchaseGroupID,
      itemName: itemName,
      itemPrice: itemPrice,
      itemCondition: itemCondition,
      itemCategory: itemCategory,
      itemImageURL: itemImageURL,
      deliveryAddress: deliveryAddress,
      isDelivered: false,
      purchaseDate: DateTime.now(),
      deliveredDate: null,
    );

    final response = await purchasesRepository.insertPurchases(
      purchasesModel: purchasesModel,
    );

    checkError(response);
    return response.data is PurchasesModel;
  }

  String generatePurchaseID() {
    final millis = DateTime.now().millisecondsSinceEpoch;
    return 'ORDER${millis % 1000000}';
  }
}
