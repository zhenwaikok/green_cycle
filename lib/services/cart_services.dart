import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/model/api_model/cart/cart_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/api_base_services.dart';

class CartServices extends BaseServices {
  Future<MyResponse> getAllCartItems() async {
    String path = '${apiUrl()}/Cart';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> insertCartItem({required CartModel cartModel}) async {
    String path = '${apiUrl()}/Cart';

    return callAPI(
      httpMethod: HttpMethod.post,
      path: path,
      postBody: cartModel.toJson(),
    );
  }

  Future<MyResponse> getCartItemsWithUserID({required String userID}) async {
    String path = '${apiUrl()}/Cart/$userID';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> getCartItemDetails({required int cartID}) async {
    String path = '${apiUrl()}/Cart/$cartID';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> updateCartItem({
    required int cartID,
    required CartModel cartModel,
  }) async {
    String path = '${apiUrl()}/Cart/$cartID';

    return callAPI(
      httpMethod: HttpMethod.put,
      path: path,
      postBody: cartModel.toJson(),
    );
  }

  Future<MyResponse> deleteCartItem({required int cartID}) async {
    String path = '${apiUrl()}/Cart/$cartID';

    return callAPI(httpMethod: HttpMethod.delete, path: path);
  }
}
