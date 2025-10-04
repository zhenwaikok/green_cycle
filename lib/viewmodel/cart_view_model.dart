import 'package:green_cycle_fyp/model/api_model/api_response_model/api_response_model.dart';
import 'package:green_cycle_fyp/model/api_model/cart/cart_model.dart';
import 'package:green_cycle_fyp/repository/cart_repository.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/viewmodel/base_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';

class CartViewModel extends BaseViewModel {
  CartViewModel({required this.cartRepository, required this.userRepository});

  CartRepository cartRepository;
  UserRepository userRepository;

  List<CartModel> _userCartItems = [];
  List<CartModel> get userCartItems => _userCartItems;

  Map<String, Map<String, dynamic>> _groupedCartItems = {};
  Map<String, Map<String, dynamic>> get groupedCartItems => _groupedCartItems;

  Future<Map<String, Map<String, dynamic>>> groupCartItemsBySeller({
    required List<CartModel> cartItemList,
    required UserViewModel userViewModel,
  }) async {
    final groupedBySeller = <String, Map<String, dynamic>>{};
    for (var item in cartItemList) {
      final sellerUserID = item.sellerUserID ?? '';

      if (!groupedBySeller.containsKey(sellerUserID)) {
        await userViewModel.getUserDetails(
          userID: sellerUserID,
          noNeedUpdateUserSharedPreference: true,
        );
        groupedBySeller[sellerUserID] = {
          'sellerName':
              '${userViewModel.userDetails?.firstName} ${userViewModel.userDetails?.lastName}',
          'items': <CartModel>[],
        };
      }

      groupedBySeller[sellerUserID]?['items'].add(item);
    }
    return groupedBySeller;
  }

  double calculateTotalAmount({required List<CartModel> cartItemList}) {
    double totalAmount = 0.0;

    for (var item in cartItemList) {
      totalAmount += item.itemListing?.itemPrice ?? 0.0;
    }
    return totalAmount;
  }

  Future<void> getUserCartItems({
    required String userID,
    UserViewModel? userViewModel,
    bool? groupCartItem,
  }) async {
    final response = await cartRepository.getCartItemsWithUserID(
      userID: userID,
    );
    if (response.data is List<CartModel>) {
      _userCartItems = response.data;

      if (groupCartItem == true) {
        _groupedCartItems = await groupCartItemsBySeller(
          cartItemList: _userCartItems,
          userViewModel:
              userViewModel ??
              UserViewModel(
                userRepository: UserRepository(
                  sharePreferenceHandler: SharedPreferenceHandler(),
                  userServices: UserServices(),
                ),
                firebaseRepository: FirebaseRepository(
                  firebaseServices: FirebaseServices(),
                ),
              ),
        );
      }
      notifyListeners();
    }

    checkError(response);
  }

  Future<bool> addToCart({
    required String buyerUserID,
    required String sellerUserID,
    required int itemListingID,
  }) async {
    CartModel cartModel = CartModel(
      buyerUserID: buyerUserID,
      sellerUserID: sellerUserID,
      itemListingID: itemListingID,
      addedDate: DateTime.now(),
    );

    final response = await cartRepository.insertCartItem(cartModel: cartModel);
    checkError(response);
    return response.data is CartModel;
  }

  Future<bool> removeFromCart({required int cartID}) async {
    final response = await cartRepository.deleteCartItem(cartID: cartID);
    checkError(response);
    return response.data is ApiResponseModel;
  }
}
