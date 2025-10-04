import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/model/api_model/item_listing/item_listing_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/api_base_services.dart';

class ItemListingServices extends BaseServices {
  Future<MyResponse> getAllItemListings() async {
    String path = '${apiUrl()}/ItemListing';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> insertItemListing({
    required ItemListingModel itemListingModel,
  }) async {
    String path = '${apiUrl()}/ItemListing';

    return callAPI(
      httpMethod: HttpMethod.post,
      path: path,
      postBody: itemListingModel.toJson(),
    );
  }

  Future<MyResponse> getItemListingWithUserID({required String userID}) async {
    String path = '${apiUrl()}/ItemListing/$userID';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> getItemListingDetails({required int itemListingID}) async {
    String path = '${apiUrl()}/ItemListing/$itemListingID';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> updateItemListing({
    required int itemListingID,
    required ItemListingModel itemListingModel,
  }) async {
    String path = '${apiUrl()}/ItemListing/$itemListingID';

    return callAPI(
      httpMethod: HttpMethod.put,
      path: path,
      postBody: itemListingModel.toJson(),
    );
  }

  Future<MyResponse> deleteItemListing({required int itemListingID}) async {
    String path = '${apiUrl()}/ItemListing/$itemListingID';

    return callAPI(httpMethod: HttpMethod.delete, path: path);
  }
}
