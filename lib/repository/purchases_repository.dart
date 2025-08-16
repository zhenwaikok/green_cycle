import 'package:green_cycle_fyp/model/api_model/api_response_model/api_response_model.dart';
import 'package:green_cycle_fyp/model/api_model/purchases/purchases_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/purchases_services.dart';

class PurchasesRepository {
  PurchasesServices get _purchasesServices => PurchasesServices();

  Future<MyResponse> getAllPurchases() async {
    final response = await _purchasesServices.getAllPurchases();

    if (response.data is Map<String, dynamic>) {
      final resultModel = PurchasesModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> insertPurchases({
    required PurchasesModel purchasesModel,
  }) async {
    final response = await _purchasesServices.insertPurchases(
      purchasesModel: purchasesModel,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = PurchasesModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> getPurchasesWithSellerUserID({
    required String sellerUserID,
  }) async {
    final response = await _purchasesServices.getPurchasesWithSellerUserID(
      sellerUserID: sellerUserID,
    );

    if (response.data is List) {
      final resultModel = (response.data as List)
          .map((json) => PurchasesModel.fromJson(json))
          .toList();
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> getPurchasesWithUserID({required String userID}) async {
    final response = await _purchasesServices.getPurchasesWithUserID(
      userID: userID,
    );

    if (response.data is List) {
      final resultModel = (response.data as List)
          .map((json) => PurchasesModel.fromJson(json))
          .toList();
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> getPurchasesDetails({required String purchaseID}) async {
    final response = await _purchasesServices.getPurchaseDetails(
      purchaseID: purchaseID,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = PurchasesModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> updatePurchases({
    required int purchaseID,
    required PurchasesModel purchasesModel,
  }) async {
    final response = await _purchasesServices.updatePurchases(
      purchaseID: purchaseID,
      purchasesModel: purchasesModel,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = ApiResponseModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> deletePurchases({required String purchaseID}) async {
    final response = await _purchasesServices.deletePurchases(
      purchaseID: purchaseID,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = PurchasesModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }
}
