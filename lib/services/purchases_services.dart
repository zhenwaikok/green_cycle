import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/model/api_model/purchases/purchases_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/api_base_services.dart';

class PurchasesServices extends BaseServices {
  Future<MyResponse> getAllPurchases() async {
    String path = '${apiUrl()}/Purchases';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> insertPurchases({
    required PurchasesModel purchasesModel,
  }) async {
    String path = '${apiUrl()}/Purchases';

    return callAPI(
      httpMethod: HttpMethod.post,
      path: path,
      postBody: purchasesModel.toJson(),
    );
  }

  Future<MyResponse> getPurchasesWithSellerUserID({
    required String sellerUserID,
  }) async {
    String path = '${apiUrl()}/Purchases/Seller/$sellerUserID';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> getPurchasesWithUserID({required String userID}) async {
    String path = '${apiUrl()}/Purchases/User/$userID';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> getPurchaseDetails({required String purchaseID}) async {
    String path = '${apiUrl()}/Purchases/$purchaseID';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> updatePurchases({
    required int purchaseID,
    required PurchasesModel purchasesModel,
  }) async {
    String path = '${apiUrl()}/Purchases/$purchaseID';

    return callAPI(
      httpMethod: HttpMethod.put,
      path: path,
      postBody: purchasesModel.toJson(),
    );
  }

  Future<MyResponse> deletePurchases({required String purchaseID}) async {
    String path = '${apiUrl()}/Purchases/$purchaseID';

    return callAPI(httpMethod: HttpMethod.delete, path: path);
  }
}
