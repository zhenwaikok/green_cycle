import 'dart:async';

import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/item_listing/item_listing_model.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/item_listing_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/view/customer/my_listing/my_listing_tab.dart';
import 'package:green_cycle_fyp/viewmodel/item_listing_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/bottom_sheet_action.dart';
import 'package:green_cycle_fyp/widget/custom_sort_by.dart';
import 'package:green_cycle_fyp/widget/custom_tab_bar.dart';
import 'package:green_cycle_fyp/widget/no_data_label.dart';
import 'package:provider/provider.dart';

@RoutePage()
class MyListingScreen extends StatelessWidget {
  const MyListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ItemListingViewModel(
        itemListingRepository: ItemListingRepository(),
        firebaseRepository: FirebaseRepository(
          firebaseServices: FirebaseServices(),
        ),
        userRepository: UserRepository(
          sharePreferenceHandler: SharedPreferenceHandler(),
          userServices: UserServices(),
        ),
      ),
      child: _MyListingScreen(),
    );
  }
}

class _MyListingScreen extends BaseStatefulPage {
  @override
  State<_MyListingScreen> createState() => _MyListingScreenState();
}

class _MyListingScreenState extends BaseStatefulState<_MyListingScreen> {
  final sortByItems = DropDownItems.itemListingSortByItems;
  String? selectedSort;
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
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'My Listing',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  Widget body() {
    final allItemListingList = context.select(
      (ItemListingViewModel vm) => vm.itemListings,
    );

    final activeItemListingList = allItemListingList
        .where((itemListing) => itemListing.status == 'Active')
        .toList();

    final soldItemListingList = allItemListingList
        .where((itemListing) => itemListing.status == 'Sold')
        .toList();

    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          getSortBy(),
          SizedBox(height: 20),
          getTabBar(),
          SizedBox(height: 15),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    children: [
                      buildTabContent(itemListingList: allItemListingList),
                      buildTabContent(itemListingList: activeItemListingList),
                      buildTabContent(itemListingList: soldItemListingList),
                    ],
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
extension _Actions on _MyListingScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  void onSortByChanged(String? value) {
    _setState(() {
      selectedSort = value;
    });
  }

  void onListingLongPressed({required int itemListingID}) {
    showModalBottomSheet(
      backgroundColor: ColorManager.whiteColor,
      context: context,
      builder: (context) {
        return getListingBottomSheet(itemListingID: itemListingID);
      },
    );
  }

  void onListingPressed({required int itemListingID}) {
    context.router.push(ItemDetailsRoute(itemListingID: itemListingID));
  }

  void onRemovePressed({required int itemListingID}) async {
    await context.router.maybePop();
    if (mounted) {
      WidgetUtil.showAlertDialog(
        context,
        title: 'Delete Confirmation',
        content: 'Are you sure you want to delete this item from your listing?',
        actions: [
          getAlertDialogTextButton(
            onPressed: () {
              onBackButtonPressed();
            },
            text: 'No',
          ),
          getAlertDialogTextButton(
            onPressed: () => onYesRemovePressed(itemListingID: itemListingID),
            text: 'Yes',
          ),
        ],
      );
    }
  }

  void onEditPressed({required int itemListingID}) async {
    await context.router.maybePop();
    if (mounted) {
      final result = await context.router.push(
        CreateEditListingRoute(isEdit: true, itemListingID: itemListingID),
      );

      if (result == true && mounted) {
        await fetchData();
      }
    }
  }

  Future<void> fetchData() async {
    _setState(() {
      isLoading = true;
    });
    selectedSort = sortByItems.first;
    await tryLoad(
      context,
      () => context.read<ItemListingViewModel>().getItemListingWithUserID(),
    );
    _setState(() {
      isLoading = false;
    });
  }

  Future<void> onYesRemovePressed({required int itemListingID}) async {
    await context.router.maybePop();
    final result = mounted
        ? await tryLoad(
                context,
                () => context.read<ItemListingViewModel>().deleteItemListing(
                  itemListingID: itemListingID,
                ),
              ) ??
              false
        : false;

    if (result) {
      unawaited(
        WidgetUtil.showSnackBar(text: 'Item listing removed successfully.'),
      );
      await fetchData();
    } else {
      WidgetUtil.showSnackBar(text: 'Failed to remove item listing.');
    }
  }

  void sortListings(List<ItemListingModel> itemListingList) {
    if (selectedSort == sortByItems[1]) {
      itemListingList.sort(
        (a, b) =>
            a.itemName?.toLowerCase().compareTo(
              b.itemName?.toLowerCase() ?? '',
            ) ??
            0,
      );
    } else if (selectedSort == sortByItems[2]) {
      itemListingList.sort(
        (a, b) =>
            b.itemName?.toLowerCase().compareTo(
              a.itemName?.toLowerCase() ?? '',
            ) ??
            0,
      );
    } else if (selectedSort == sortByItems[3]) {
      itemListingList.sort(
        (a, b) => a.itemPrice?.compareTo(b.itemPrice ?? 0) ?? 0,
      );
    } else if (selectedSort == sortByItems[4]) {
      itemListingList.sort(
        (a, b) => b.itemPrice?.compareTo(a.itemPrice ?? 0) ?? 0,
      );
    } else {
      itemListingList.sort(
        (a, b) =>
            b.createdDate?.compareTo(a.createdDate ?? DateTime.now()) ?? 0,
      );
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _MyListingScreenState {
  Widget getSortBy() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sort By', style: _Styles.sortByTextStyle),
        SizedBox(height: 5),
        CustomSortBy(
          selectedValue: selectedSort,
          sortByItems: sortByItems,
          onChanged: (String? value) {
            onSortByChanged(value);
          },
        ),
      ],
    );
  }

  Widget getTabBar() {
    return CustomTabBar(tabs: [Text('All'), Text('Active'), Text('Sold')]);
  }

  Widget buildTabContent({required List<ItemListingModel> itemListingList}) {
    return AdaptiveWidgets.buildRefreshableScrollView(
      context,
      onRefresh: fetchData,
      color: ColorManager.blackColor,
      refreshIndicatorBackgroundColor: ColorManager.whiteColor,
      slivers: getMyListingList(
        itemListingList: itemListingList,
        isLoading: isLoading,
      ),
    );
  }

  List<Widget> getMyListingList({
    required List<ItemListingModel> itemListingList,
    required bool isLoading,
  }) {
    sortListings(itemListingList);

    if (itemListingList.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: NoDataAvailableLabel(noDataText: 'No Item Listing Found'),
          ),
        ),
      ];
    }

    return [
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return MyListingTab(
            itemListingDetails: itemListingList[index],
            isLoading: isLoading,
            onTap: () => onListingPressed(
              itemListingID: itemListingList[index].itemListingID ?? 0,
            ),
            onLongPress: () => onListingLongPressed(
              itemListingID: itemListingList[index].itemListingID ?? 0,
            ),
          );
        }, childCount: itemListingList.length),
      ),
    ];
  }

  Widget getListingBottomSheet({required int itemListingID}) {
    return Padding(
      padding: _Styles.screenPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetAction(
            icon: Icons.edit,
            color: ColorManager.blackColor,
            text: 'Edit',
            onTap: () => onEditPressed(itemListingID: itemListingID),
          ),
          SizedBox(height: 10),
          BottomSheetAction(
            icon: Icons.check,
            color: ColorManager.blackColor,
            text: 'Mark as sold',
            onTap: () {},
          ),
          SizedBox(height: 10),
          BottomSheetAction(
            icon: Icons.delete_outline,
            color: ColorManager.redColor,
            text: 'Remove',
            onTap: () => onRemovePressed(itemListingID: itemListingID),
          ),
        ],
      ),
    );
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

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const sortByTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static final textButtonStyle = ButtonStyle(
    overlayColor: WidgetStateProperty.all(ColorManager.lightGreyColor2),
  );

  static const textButtonTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );
}
