import 'package:green_cycle_fyp/model/api_model/item_listing/item_listing_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/item_listing_services.dart';

class ItemListingRepository {
  ItemListingServices get _itemListingServices => ItemListingServices();

  Future<MyResponse> getAllItemListings() async {
    final response = await _itemListingServices.getAllItemListings();

    if (response.data is Map<String, dynamic>) {
      final resultModel = ItemListingModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> insertItemListing({
    required ItemListingModel itemListingModel,
  }) async {
    final response = await _itemListingServices.insertItemListing(
      itemListingModel: itemListingModel,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = ItemListingModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> getItemListingWithUserID({required String userID}) async {
    final response = await _itemListingServices.getItemListingWithUserID(
      userID: userID,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = ItemListingModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> getItemListingDetails({required int itemListingID}) async {
    final response = await _itemListingServices.getItemListingDetails(
      itemListingID: itemListingID,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = ItemListingModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> updateItemListing({
    required int itemListingID,
    required ItemListingModel itemListingModel,
  }) async {
    final response = await _itemListingServices.updateItemListing(
      itemListingID: itemListingID,
      itemListingModel: itemListingModel,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = ItemListingModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> deleteItemListing({required int itemListingID}) async {
    final response = await _itemListingServices.deleteItemListing(
      itemListingID: itemListingID,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = ItemListingModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }
}
