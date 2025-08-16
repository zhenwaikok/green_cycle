import 'package:green_cycle_fyp/model/api_model/api_response_model/api_response_model.dart';
import 'package:green_cycle_fyp/model/api_model/purchases/purchases_model.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/purchases_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/viewmodel/base_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';

class PurchaseViewModel extends BaseViewModel {
  PurchaseViewModel({required this.purchasesRepository});

  final PurchasesRepository purchasesRepository;

  List<PurchasesModel> _purchaseList = [];
  List<PurchasesModel> get purchaseList => _purchaseList;

  Map<String, Map<String, dynamic>> _groupedPurchaseItems = {};
  Map<String, Map<String, dynamic>> get groupedPurchaseItems =>
      _groupedPurchaseItems;

  Future<Map<String, Map<String, dynamic>>>
  groupPurchaseItemsByPurchaseGroupID({
    required List<PurchasesModel> purchaseList,
    required UserViewModel userViewModel,
    bool needBuyerName = false,
  }) async {
    final groupedByPurchaseGroupID = <String, Map<String, dynamic>>{};
    for (var item in purchaseList) {
      final sellerUserID = item.sellerUserID ?? '';
      final buyerUserID = item.buyerUserID ?? '';

      final purchaseGroupID = item.purchaseGroupID ?? '';

      if (!groupedByPurchaseGroupID.containsKey(purchaseGroupID)) {
        if (!needBuyerName) {
          await userViewModel.getUserDetails(
            userID: sellerUserID,
            noNeedUpdateUserSharedPreference: true,
          );
        } else {
          await userViewModel.getUserDetails(
            userID: buyerUserID,
            noNeedUpdateUserSharedPreference: true,
          );
        }

        groupedByPurchaseGroupID[purchaseGroupID] = {
          'purchaseGroupID': purchaseGroupID,
          if (needBuyerName)
            'buyerName':
                '${userViewModel.userDetails?.firstName} ${userViewModel.userDetails?.lastName}'
          else
            'sellerName':
                '${userViewModel.userDetails?.firstName} ${userViewModel.userDetails?.lastName}',
          'items': <PurchasesModel>[],
        };
      }

      groupedByPurchaseGroupID[purchaseGroupID]?['items'].add(item);
    }
    return groupedByPurchaseGroupID;
  }

  Future<void> getPurchasesWithSellerUserID({
    required String sellerUserID,
    UserViewModel? userVM,
    bool? groupPurchase,
  }) async {
    final response = await purchasesRepository.getPurchasesWithSellerUserID(
      sellerUserID: sellerUserID,
    );

    if (response.data is List<PurchasesModel>) {
      _purchaseList = response.data;

      if (groupPurchase == true) {
        _groupedPurchaseItems = await groupPurchaseItemsByPurchaseGroupID(
          purchaseList: _purchaseList,
          userViewModel:
              userVM ??
              UserViewModel(
                userRepository: UserRepository(
                  sharePreferenceHandler: SharedPreferenceHandler(),
                  userServices: UserServices(),
                ),
                firebaseRepository: FirebaseRepository(
                  firebaseServices: FirebaseServices(),
                ),
              ),
          needBuyerName: true,
        );
      }

      notifyListeners();
    }

    checkError(response);
  }

  Future<void> getPurchasesWithUserID({
    required String userID,
    UserViewModel? userVM,
    bool? groupPurchase,
  }) async {
    final response = await purchasesRepository.getPurchasesWithUserID(
      userID: userID,
    );

    if (response.data is List<PurchasesModel>) {
      _purchaseList = response.data;

      if (groupPurchase == true) {
        _groupedPurchaseItems = await groupPurchaseItemsByPurchaseGroupID(
          purchaseList: _purchaseList,
          userViewModel:
              userVM ??
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
    required DateTime purchaseDate,
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
      status: 'In Progress',
      purchaseDate: purchaseDate,
      deliveredDate: null,
    );

    final response = await purchasesRepository.insertPurchases(
      purchasesModel: purchasesModel,
    );

    checkError(response);
    return response.data is PurchasesModel;
  }

  Future<bool> updatePurchases({
    required int purchaseID,
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
    required DateTime purchaseDate,
    required String status,
    bool? isDelivered,
    DateTime? deliveredDate,
  }) async {
    PurchasesModel purchasesModel = PurchasesModel(
      purchaseID: purchaseID,
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
      isDelivered: isDelivered,
      status: status,
      purchaseDate: purchaseDate,
      deliveredDate: deliveredDate,
    );

    final response = await purchasesRepository.updatePurchases(
      purchaseID: purchaseID,
      purchasesModel: purchasesModel,
    );

    checkError(response);
    return response.data is ApiResponseModel;
  }

  String generatePurchaseID() {
    final millis = DateTime.now().millisecondsSinceEpoch;
    return 'ORDER${millis % 1000000}';
  }

  double calculateTotalAmount({required List<PurchasesModel> purchaseList}) {
    double totalAmount = 0.0;

    for (var item in purchaseList) {
      totalAmount += item.itemPrice ?? 0.0;
    }
    return totalAmount;
  }

  List<MapEntry<String, Map<String, dynamic>>> filterGroupsByStatus({
    required List<MapEntry<String, Map<String, dynamic>>> groupedItems,
    String? status,
  }) {
    return groupedItems.where((entry) {
      final items = entry.value['items'] as List<PurchasesModel>;
      if (status == null) return true;
      return items.any((item) => item.status == status);
    }).toList();
  }

  bool isMatch({
    required PurchasesModel purchase,
    required String searchQuery,
    String? buyerName,
  }) {
    final query = searchQuery.toLowerCase().trim();

    if (query.isEmpty) return true;

    final matchesSearch =
        (purchase.purchaseGroupID?.toLowerCase().contains(query) ?? false) ||
        (purchase.deliveryAddress?.toLowerCase().contains(query) ?? false) ||
        (purchase.itemName?.toLowerCase().contains(query) ?? false) ||
        (buyerName?.toLowerCase().contains(query) ?? false);

    return matchesSearch;
  }
}
