import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/model/api_model/purchases/purchases_model.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/purchases_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/view/customer/my_purchases/my_purchases_tab.dart';
import 'package:green_cycle_fyp/viewmodel/notification_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/purchase_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_tab_bar.dart';
import 'package:green_cycle_fyp/widget/no_data_label.dart';
import 'package:provider/provider.dart';

@RoutePage()
class MyPurchasesScreen extends StatelessWidget {
  const MyPurchasesScreen({super.key, @PathParam() required this.userID});

  final String userID;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        PurchaseViewModel(purchasesRepository: PurchasesRepository());
        UserViewModel(
          userRepository: UserRepository(
            sharePreferenceHandler: SharedPreferenceHandler(),
            userServices: UserServices(),
          ),
          firebaseRepository: FirebaseRepository(
            firebaseServices: FirebaseServices(),
          ),
        );
      },
      child: _MyPurchasesScreen(userID: userID),
    );
  }
}

class _MyPurchasesScreen extends BaseStatefulPage {
  const _MyPurchasesScreen({required this.userID});

  final String userID;

  @override
  State<_MyPurchasesScreen> createState() => _MyPurchasesScreenState();
}

class _MyPurchasesScreenState extends BaseStatefulState<_MyPurchasesScreen> {
  bool isLoading = true;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'My Purchases',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  Widget body() {
    final groupedPurchaseItems = context.select(
      (PurchaseViewModel purchaseViewModel) =>
          purchaseViewModel.groupedPurchaseItems.entries.toList(),
    );

    final purchaseVM = context.read<PurchaseViewModel>();

    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          getTabBar(),
          SizedBox(height: 15),
          Expanded(
            child: TabBarView(
              children: [
                buildTabContent(
                  groupedPurchaseItems: purchaseVM.filterGroupsByStatus(
                    groupedItems: groupedPurchaseItems,
                    status: null,
                  ),
                ),
                buildTabContent(
                  groupedPurchaseItems: purchaseVM.filterGroupsByStatus(
                    groupedItems: groupedPurchaseItems,
                    status: 'In Progress',
                  ),
                ),
                buildTabContent(
                  groupedPurchaseItems: purchaseVM.filterGroupsByStatus(
                    groupedItems: groupedPurchaseItems,
                    status: 'Shipped',
                  ),
                ),
                buildTabContent(
                  groupedPurchaseItems: purchaseVM.filterGroupsByStatus(
                    groupedItems: groupedPurchaseItems,
                    status: 'Completed',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _MyPurchasesScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  Future<void> onOrderReceivedButtonPressed({
    required List<PurchasesModel> purchaseItems,
  }) async {
    final deliveredDate = DateTime.now();
    bool allSuccess = true;

    for (var item in purchaseItems) {
      final result = await tryLoad(
        context,
        () => context.read<PurchaseViewModel>().updatePurchases(
          purchaseID: item.purchaseID ?? 0,
          buyerUserID: item.buyerUserID ?? '',
          sellerUserID: item.sellerUserID ?? '',
          itemListingID: item.itemListingID ?? 0,
          purchaseGroupID: item.purchaseGroupID ?? '',
          itemName: item.itemName ?? '',
          itemPrice: item.itemPrice ?? 0.0,
          itemCondition: item.itemCondition ?? '',
          itemCategory: item.itemCategory ?? '',
          itemImageURL: item.itemImageURL ?? [],
          deliveryAddress: item.deliveryAddress ?? '',
          purchaseDate: item.purchaseDate ?? DateTime.now(),
          status: 'Completed',
          isDelivered: true,
          deliveredDate: deliveredDate,
        ),
      );

      if (result == null || result == false) {
        allSuccess = false;
      }
    }

    if (allSuccess) {
      await sendPushNotification(
        sellerUserID: purchaseItems.first.sellerUserID ?? '',
        title: 'Order Completed',
        body:
            'Your order #${purchaseItems.first.purchaseGroupID} has been received by the buyer.',
      );
      await fetchData();
    }
  }

  Future<void> sendPushNotification({
    required String sellerUserID,
    required String title,
    required String body,
  }) async {
    final fcmToken = await tryCatch(
      context,
      () => context.read<UserViewModel>().getFcmTokenWithUserID(
        userID: sellerUserID,
      ),
    );

    if (mounted) {
      await tryCatch(
        context,
        () => context.read<NotificationViewModel>().sendPushNotification(
          fcmToken: fcmToken?.token ?? '',
          title: title,
          body: body,
          deeplink: 'sales-order/$sellerUserID',
        ),
      );
    }
  }

  Future<void> fetchData() async {
    _setState(() => isLoading = true);
    final userVM = context.read<UserViewModel>();

    await tryCatch(
      context,
      () => context.read<PurchaseViewModel>().getPurchasesWithUserID(
        userID: widget.userID,
        userVM: userVM,
        groupPurchase: true,
      ),
    );
    _setState(() => isLoading = false);
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _MyPurchasesScreenState {
  Widget getTabBar() {
    return CustomTabBar(
      tabs: [
        Text('All'),
        Text('In Progress'),
        Text('Shipped'),
        Text('Completed'),
      ],
    );
  }

  Widget buildTabContent({
    required List<MapEntry<String, Map<String, dynamic>>> groupedPurchaseItems,
  }) {
    return AdaptiveWidgets.buildRefreshableScrollView(
      context,
      onRefresh: fetchData,
      color: ColorManager.blackColor,
      refreshIndicatorBackgroundColor: ColorManager.whiteColor,
      slivers: getPurchasesList(
        groupedPurchaseItems: groupedPurchaseItems,
        isLoading: isLoading,
      ),
    );
  }

  List<Widget> getPurchasesList({
    required List<MapEntry<String, Map<String, dynamic>>> groupedPurchaseItems,
    required bool isLoading,
  }) {
    final loadingList = List.generate(
      3,
      (index) => PurchasesModel(itemName: 'Loading...'),
    );

    if (isLoading) {
      return [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return MyPurchasesTab(
              purchaseItems: loadingList,
              purchaseGroupID: '',
              sellerName: 'Loading...',
              isLoading: isLoading,
              onOrderReceivedButtonPressed: () {},
            );
          }, childCount: loadingList.length),
        ),
      ];
    }

    if (groupedPurchaseItems.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: NoDataAvailableLabel(noDataText: 'No Purchases Found'),
          ),
        ),
      ];
    }

    return [
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final purchaseGroupID =
              groupedPurchaseItems[index].value['purchaseGroupID'];
          final sellerName = groupedPurchaseItems[index].value['sellerName'];
          final items =
              groupedPurchaseItems[index].value['items']
                  as List<PurchasesModel>;

          return MyPurchasesTab(
            purchaseItems: items,
            purchaseGroupID: purchaseGroupID,
            sellerName: sellerName,
            isLoading: isLoading,
            onOrderReceivedButtonPressed: () =>
                onOrderReceivedButtonPressed(purchaseItems: items),
          );
        }, childCount: groupedPurchaseItems.length),
      ),
    ];
  }
}
