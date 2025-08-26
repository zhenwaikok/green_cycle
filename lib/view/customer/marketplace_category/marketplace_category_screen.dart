import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/item_listing/item_listing_model.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/item_listing_repository.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/item_listing_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_sort_by.dart';
import 'package:green_cycle_fyp/widget/no_data_label.dart';
import 'package:green_cycle_fyp/widget/second_hand_item.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class MarketplaceCategoryScreen extends StatelessWidget {
  const MarketplaceCategoryScreen({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ItemListingViewModel(
        itemListingRepository: ItemListingRepository(),
        firebaseRepository: FirebaseRepository(
          firebaseServices: FirebaseServices(),
        ),
      ),
      child: _MarketplaceCategoryScreen(category: category),
    );
  }
}

class _MarketplaceCategoryScreen extends BaseStatefulPage {
  const _MarketplaceCategoryScreen({required this.category});

  final String category;

  @override
  State<_MarketplaceCategoryScreen> createState() =>
      _MarketplaceCategoryScreenState();
}

class _MarketplaceCategoryScreenState
    extends BaseStatefulState<_MarketplaceCategoryScreen> {
  final sortByItems = DropDownItems.itemListingSortByItems;
  final conditionItems = ['All', ...DropDownItems.itemListingConditionItems];
  bool _isLoading = true;
  String? selectedSort;
  String? selectedCondition;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    initialLoad();
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: widget.category,
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  Widget body() {
    final itemListingList = context.select(
      (ItemListingViewModel vm) => vm.itemListings.where(isMatch).toList(),
    );

    final userID = context.read<UserViewModel>().user?.userID ?? '';

    final categoryItemListingList = itemListingList.where((item) {
      return item.itemCategory == widget.category &&
          item.isSold == false &&
          item.userID != userID;
    }).toList();

    return Column(
      children: [
        getFilterOptions(),
        SizedBox(height: 35),
        Expanded(
          child: AdaptiveWidgets.buildRefreshableScrollView(
            context,
            onRefresh: initialLoad,
            color: ColorManager.blackColor,
            refreshIndicatorBackgroundColor: ColorManager.whiteColor,
            slivers: [
              if (_isLoading)
                SliverToBoxAdapter(
                  child: getCategoryItems(
                    itemListingList: List.generate(
                      5,
                      (index) => ItemListingModel(itemName: 'Loading...'),
                    ),
                    isLoading: _isLoading,
                  ),
                )
              else if (categoryItemListingList.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: NoDataAvailableLabel(noDataText: 'No Items Found'),
                  ),
                )
              else
                SliverToBoxAdapter(
                  child: getCategoryItems(
                    itemListingList: categoryItemListingList,
                    isLoading: false,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

// * ---------------------------- Helpers ----------------------------
extension _Helpers on _MarketplaceCategoryScreenState {
  bool isMatch(ItemListingModel item) {
    final matchesCondition =
        selectedCondition == null ||
        selectedCondition == conditionItems.first ||
        item.itemCondition == selectedCondition;

    return matchesCondition;
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _MarketplaceCategoryScreenState {
  void onBackButtonPressed() {
    context.router.maybePop(true);
  }

  void onSortByChanged(String? value) {
    _setState(() {
      selectedSort = value;
    });
  }

  void onConditionChanged(String? value) {
    _setState(() {
      selectedCondition = value;
    });
  }

  void onItemPressed({required int itemListingID}) async {
    final result = await context.router.push(
      ItemDetailsRoute(itemListingID: itemListingID),
    );

    if (result == true && mounted) {
      initialLoad();
    }
  }

  Future<void> initialLoad() async {
    _setState(() {
      _isLoading = true;
    });
    selectedSort = sortByItems.first;
    selectedCondition = conditionItems.first;
    await tryCatch(
      context,
      () => context.read<ItemListingViewModel>().getAllItemListings(),
    );
    _setState(() {
      _isLoading = false;
    });
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
extension _WidgetFactories on _MarketplaceCategoryScreenState {
  Widget getFilterOptions() {
    return Row(
      children: [
        getFilterDetails(
          text: 'Sort By',
          filterItems: sortByItems,
          selectedValue: selectedSort ?? '',
          onChanged: onSortByChanged,
        ),
        SizedBox(width: 10),
        getFilterDetails(
          text: 'Condition',
          filterItems: conditionItems,
          selectedValue: selectedCondition ?? '',
          onChanged: onConditionChanged,
        ),
      ],
    );
  }

  Widget getFilterDetails({
    required String text,
    required List<String> filterItems,
    required String selectedValue,
    required void Function(String?)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: _Styles.sortByTextStyle),
        SizedBox(height: 5),
        CustomSortBy(
          sortByItems: filterItems,
          selectedValue: selectedValue,
          onChanged: onChanged,
          isExpanded: false,
        ),
      ],
    );
  }

  Widget getCategoryItems({
    required List<ItemListingModel> itemListingList,
    required bool isLoading,
  }) {
    sortListings(itemListingList);
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        mainAxisExtent: 210,
      ),
      itemCount: itemListingList.length,
      itemBuilder: (context, index) {
        final item = itemListingList[index];
        return Padding(
          padding: _Styles.itemPadding,
          child: TouchableOpacity(
            onPressed: () =>
                onItemPressed(itemListingID: item.itemListingID ?? 0),
            child: Skeletonizer(
              enabled: isLoading,
              child: SecondHandItem(
                imageURL: item.itemImageURL?.first ?? '',
                productName: item.itemName ?? '',
                productPrice:
                    'RM ${WidgetUtil.priceFormatter(item.itemPrice ?? 0.0)}',
                text: item.itemCondition ?? '',
              ),
            ),
          ),
        );
      },
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const itemPadding = EdgeInsets.all(5);

  static const sortByTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );
}
