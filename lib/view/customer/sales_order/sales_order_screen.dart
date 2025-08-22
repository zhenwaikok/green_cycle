import 'dart:async';

import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/purchases/purchases_model.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/view/customer/sales_order/sales_order_tab.dart';
import 'package:green_cycle_fyp/viewmodel/purchase_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_tab_bar.dart';
import 'package:green_cycle_fyp/widget/no_data_label.dart';
import 'package:green_cycle_fyp/widget/search_bar.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SalesOrderScreen extends StatelessWidget {
  const SalesOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _SalesOrderScreen();
  }
}

class _SalesOrderScreen extends BaseStatefulPage {
  @override
  State<_SalesOrderScreen> createState() => _SalesOrderScreenState();
}

class _SalesOrderScreenState extends BaseStatefulState<_SalesOrderScreen> {
  bool isLoading = true;
  String? searchQuery;
  TextEditingController searchController = TextEditingController();

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
      title: 'Sales Order',
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

    final filteredGroupedOrders = groupedPurchaseItems.where((entry) {
      final buyerName = entry.value['buyerName'];
      final items = entry.value['items'] as List<PurchasesModel>;
      return items.any(
        (item) => purchaseVM.isMatch(
          purchase: item,
          searchQuery: searchQuery ?? '',
          buyerName: buyerName,
        ),
      );
    }).toList();

    final summaryGroups = {
      'All': purchaseVM.filterGroupsByStatus(
        groupedItems: groupedPurchaseItems,
      ),
      'In Progress': purchaseVM.filterGroupsByStatus(
        groupedItems: groupedPurchaseItems,
        status: 'In Progress',
      ),
      'Shipped': purchaseVM.filterGroupsByStatus(
        groupedItems: groupedPurchaseItems,
        status: 'Shipped',
      ),
      'Completed': purchaseVM.filterGroupsByStatus(
        groupedItems: groupedPurchaseItems,
        status: 'Completed',
      ),
    };

    final tabGroups = {
      'All': purchaseVM.filterGroupsByStatus(
        groupedItems: filteredGroupedOrders,
      ),
      'In Progress': purchaseVM.filterGroupsByStatus(
        groupedItems: filteredGroupedOrders,
        status: 'In Progress',
      ),
      'Shipped': purchaseVM.filterGroupsByStatus(
        groupedItems: filteredGroupedOrders,
        status: 'Shipped',
      ),
      'Completed': purchaseVM.filterGroupsByStatus(
        groupedItems: filteredGroupedOrders,
        status: 'Completed',
      ),
    };

    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          getOrderSummary(
            pendingOrders: summaryGroups['In Progress']?.length ?? 0,
            shippedOrders: summaryGroups['Shipped']?.length ?? 0,
            completedOrders: summaryGroups['Completed']?.length ?? 0,
          ),
          SizedBox(height: 40),
          getSearchBar(),
          SizedBox(height: 20),
          getTabBar(),
          SizedBox(height: 15),
          Expanded(
            child: TabBarView(
              children: tabGroups.values
                  .map((group) => buildTabContent(groupedPurchaseItems: group))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _SalesOrderScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  void onSearchChanged(String? value) {
    _setState(() {
      searchQuery = value;
    });
  }

  void removeSearchText() {
    _setState(() {
      searchQuery = null;
      searchController.clear();
    });
  }

  void onMarkAsShippedButtonPressed({
    required List<PurchasesModel> purchaseItems,
  }) {
    WidgetUtil.showAlertDialog(
      context,
      title: 'Shipped Confirmation',
      content: 'Are you sure to mark this order as shipped?',
      actions: [
        getAlertDialogTextButton(onPressed: onBackButtonPressed, text: 'No'),
        getAlertDialogTextButton(
          onPressed: () => onYesButtonPressed(purchaseItems: purchaseItems),
          text: 'Yes',
        ),
      ],
    );
  }

  Future<void> onYesButtonPressed({
    required List<PurchasesModel> purchaseItems,
  }) async {
    await context.router.maybePop();

    bool allSuccess = true;

    for (var item in purchaseItems) {
      if (mounted) {
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
            status: 'Shipped',
            isDelivered: item.isDelivered,
          ),
        );

        if (result == null || result == false) {
          allSuccess = false;
        }
      }
    }

    if (allSuccess) {
      unawaited(WidgetUtil.showSnackBar(text: 'Order marked as shipped'));
      await fetchData();
    }
  }

  Future<void> fetchData() async {
    _setState(() => isLoading = true);
    final userVM = context.read<UserViewModel>();
    final sellerUserID = userVM.user?.userID ?? '';

    await tryCatch(
      context,
      () => context.read<PurchaseViewModel>().getPurchasesWithSellerUserID(
        sellerUserID: sellerUserID,
        groupPurchase: true,
      ),
    );
    _setState(() => isLoading = false);
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _SalesOrderScreenState {
  Widget getOrderSummary({
    required int pendingOrders,
    required int shippedOrders,
    required int completedOrders,
  }) {
    return CustomCard(
      padding: _Styles.customCardPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Summary', style: _Styles.orderSummaryValueTextStyle),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: getOrderSummaryDetails(
                  backgroundColor: ColorManager.orangeColor.withValues(
                    alpha: 0.5,
                  ),
                  title: 'In Progress',
                  value: '$pendingOrders',
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: getOrderSummaryDetails(
                  backgroundColor: ColorManager.purpleColor.withValues(
                    alpha: 0.5,
                  ),
                  title: 'Shipped',
                  value: '$shippedOrders',
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: getOrderSummaryDetails(
                  backgroundColor: ColorManager.primaryLight,
                  title: 'Completed',
                  value: '$completedOrders',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getOrderSummaryDetails({
    required Color backgroundColor,
    required String title,
    required String value,
  }) {
    return CustomCard(
      backgroundColor: backgroundColor,
      needBoxShadow: false,
      padding: _Styles.customCardPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: _Styles.orderSummaryTitleTextStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10),
          Text(value, style: _Styles.orderSummaryValueTextStyle),
        ],
      ),
    );
  }

  Widget getSearchBar() {
    return CustomSearchBar(
      hintText: 'Search sales order here',
      controller: searchController,
      onChanged: (value) {
        onSearchChanged(value);
      },
      onPressed: removeSearchText,
    );
  }

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
      slivers: getOrderList(
        groupedPurchaseItems: groupedPurchaseItems,
        isLoading: isLoading,
      ),
    );
  }

  List<Widget> getOrderList({
    required List<MapEntry<String, Map<String, dynamic>>> groupedPurchaseItems,
    required bool isLoading,
  }) {
    final loadingList = List.generate(
      3,
      (index) =>
          PurchasesModel(itemName: 'Loading...', deliveryAddress: 'Loading...'),
    );

    if (isLoading) {
      return [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return SalesOrderTab(
              purchaseItems: loadingList,
              purchaseGroupID: '',
              buyerName: 'Loading...',
              isLoading: isLoading,
              onMarkAsShippedButtonPressed: () {},
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
            child: NoDataAvailableLabel(noDataText: 'No Orders Found'),
          ),
        ),
      ];
    }

    return [
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final purchaseGroupID =
              groupedPurchaseItems[index].value['purchaseGroupID'];
          final buyerName = groupedPurchaseItems[index].value['buyerName'];
          final items =
              groupedPurchaseItems[index].value['items']
                  as List<PurchasesModel>;

          return SalesOrderTab(
            purchaseItems: items,
            purchaseGroupID: purchaseGroupID,
            buyerName: buyerName,
            isLoading: isLoading,
            onMarkAsShippedButtonPressed: () =>
                onMarkAsShippedButtonPressed(purchaseItems: items),
          );
        }, childCount: groupedPurchaseItems.length),
      ),
    ];
  }

  Widget getAlertDialogTextButton({
    required void Function()? onPressed,
    required String text,
  }) {
    return TextButton(
      style: _Styles.textButtonStyle,
      onPressed: onPressed,
      child: Text(text, style: _Styles.textButtonTextStyle),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const customCardPadding = EdgeInsets.symmetric(
    vertical: 10,
    horizontal: 10,
  );

  static final textButtonStyle = ButtonStyle(
    overlayColor: WidgetStateProperty.all(ColorManager.lightGreyColor2),
  );

  static const orderSummaryTitleTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const orderSummaryValueTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const textButtonTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );
}
