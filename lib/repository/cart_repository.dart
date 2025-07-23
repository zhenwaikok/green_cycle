import 'package:green_cycle_fyp/model/api_model/cart/cart_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/cart_services.dart';

class CartRepository {
  CartServices get _cartServices => CartServices();

  Future<MyResponse> getAllCartItems() async {
    final response = await _cartServices.getAllCartItems();

    if (response.data is Map<String, dynamic>) {
      final resultModel = CartModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> insertCartItem({required CartModel cartModel}) async {
    final response = await _cartServices.insertCartItem(cartModel: cartModel);

    if (response.data is Map<String, dynamic>) {
      final resultModel = CartModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> getCartItemsWithUserID({required String userID}) async {
    final response = await _cartServices.getCartItemsWithUserID(userID: userID);

    if (response.data is Map<String, dynamic>) {
      final resultModel = CartModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> getCartItemDetails({required int cartID}) async {
    final response = await _cartServices.getCartItemDetails(cartID: cartID);

    if (response.data is Map<String, dynamic>) {
      final resultModel = CartModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> updateCartItem({
    required int cartID,
    required CartModel cartModel,
  }) async {
    final response = await _cartServices.updateCartItem(
      cartID: cartID,
      cartModel: cartModel,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = CartModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> deleteCartItem({required int cartID}) async {
    final response = await _cartServices.deleteCartItem(cartID: cartID);

    if (response.data is Map<String, dynamic>) {
      final resultModel = CartModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }
}
