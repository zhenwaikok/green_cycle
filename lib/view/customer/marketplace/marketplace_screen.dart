import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/item_listing/item_listing_model.dart';
import 'package:green_cycle_fyp/repository/cart_repository.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/item_listing_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/cart_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/item_listing_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_floating_action_button.dart';
import 'package:green_cycle_fyp/widget/no_data_label.dart';
import 'package:green_cycle_fyp/widget/search_bar.dart';
import 'package:green_cycle_fyp/widget/second_hand_item.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class MarketplaceScreen extends StatelessWidget {
  const MarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        ItemListingViewModel(
          itemListingRepository: ItemListingRepository(),
          firebaseRepository: FirebaseRepository(
            firebaseServices: FirebaseServices(),
          ),
        );

        CartViewModel(
          cartRepository: CartRepository(),
          userRepository: UserRepository(
            sharePreferenceHandler: SharedPreferenceHandler(),
            userServices: UserServices(),
          ),
        );
      },
      child: _MarketplaceScreen(),
    );
  }
}

class _MarketplaceScreen extends BaseStatefulPage {
  @override
  State<_MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends BaseStatefulState<_MarketplaceScreen> {
  late final tabsRouter = AutoTabsRouter.of(context);
  bool _isLoading = true;
  String? searchQuery;
  int numOfCartItems = 0;
  final secondHandItemCategories = DropDownItems.itemCategoryItems;
  TextEditingController searchController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabsRouter.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    tabsRouter.removeListener(_onTabChanged);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  EdgeInsets defaultPadding() {
    return EdgeInsets.zero;
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Secondhand Marketplace',
      isBackButtonVisible: false,
    );
  }

  @override
  Widget floatingActionButton() {
    return getFloatingActionButton(numOfCartItems: numOfCartItems);
  }

  @override
  Widget body() {
    final userID = context.read<UserViewModel>().user?.userID ?? '';
    final itemListingList = context.watch<ItemListingViewModel>().itemListings;

    final filteredItems = itemListingList
        .where(
          (item) =>
              isMatch(item) && item.isSold == false && item.userID != userID,
        )
        .toList();
    final sortedItems = [...filteredItems]
      ..sort(
        (a, b) =>
            b.createdDate?.compareTo(a.createdDate ?? DateTime.now()) ?? 0,
      );
    final latest13ItemListingList = sortedItems.take(13).toList();

    return AdaptiveWidgets.buildRefreshableScrollView(
      context,
      onRefresh: fetchData,
      color: ColorManager.blackColor,
      refreshIndicatorBackgroundColor: ColorManager.whiteColor,
      slivers: [
        SliverPadding(
          padding: _Styles.screenPadding,
          sliver: SliverMainAxisGroup(
            slivers: [
              SliverToBoxAdapter(child: getStartSellingButton()),
              SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverToBoxAdapter(
                child: getCategoriesSection(
                  categories: secondHandItemCategories,
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 25)),
              SliverToBoxAdapter(child: getSearchBar()),
              SliverToBoxAdapter(child: SizedBox(height: 25)),
              SliverToBoxAdapter(
                child: getRecommendSection(
                  itemListingList: _isLoading
                      ? List.generate(
                          5,
                          (index) => ItemListingModel(itemName: 'Loading...'),
                        )
                      : latest13ItemListingList,
                  isLoading: _isLoading,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Helpers on _MarketplaceScreenState {
  bool isMatch(ItemListingModel item) {
    final query = searchQuery?.toLowerCase().trim() ?? '';

    final matchesSearch =
        query.isEmpty ||
        (item.itemName?.toLowerCase().contains(query) ?? false);

    return matchesSearch;
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _MarketplaceScreenState {
  void _onTabChanged() {
    if (tabsRouter.activeIndex == 2) {
      removeSearchText();
    }
  }

  void onCategoryCardPressed({required String category}) async {
    final result = await context.router.push(
      MarketplaceCategoryRoute(category: category),
    );

    if (result == true && mounted) {
      await fetchData();
    }
  }

  void onStartSellingPressed() {
    context.router.push(CreateEditListingRoute(isEdit: false));
  }

  void onCartPressed() async {
    final result = await context.router.push(CartRoute());

    if (result == true && mounted) {
      await fetchData();
    }
  }

  void onItemPressed({required int itemListingID}) async {
    final result = await context.router.push(
      ItemDetailsRoute(itemListingID: itemListingID),
    );

    if (result == true && mounted) {
      await fetchData();
    }
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

  Future<void> fetchData() async {
    _setState(() => _isLoading = true);

    final userID = context.read<UserViewModel>().user?.userID ?? '';
    final cartVM = context.read<CartViewModel>();

    await tryCatch(
      context,
      () => context.read<ItemListingViewModel>().getAllItemListings(),
    );

    if (mounted) {
      await tryCatch(context, () => cartVM.getUserCartItems(userID: userID));
    }

    _setState(() {
      numOfCartItems = cartVM.userCartItems.length;
      _isLoading = false;
    });
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _MarketplaceScreenState {
  Widget getStartSellingButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          style: _Styles.startSellingButtonStyle,
          onPressed: onStartSellingPressed,
          child: Text('Start Selling', style: _Styles.startSellingTextStyle),
        ),
      ],
    );
  }

  Widget getSearchBar() {
    return CustomSearchBar(
      controller: searchController,
      onChanged: (value) => onSearchChanged(value),
      onPressed: removeSearchText,
      hintText: 'Search here',
    );
  }

  Widget getCategoriesSection({required List<String> categories}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Categories', style: _Styles.blackTextStyle),

        SizedBox(
          height: MediaQuery.of(context).size.width * 0.18,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return getCategoryCard(category: categories[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget getCategoryCard({required String category}) {
    return Padding(
      padding: _Styles.categoryCardPadding,
      child: TouchableOpacity(
        onPressed: () => onCategoryCardPressed(category: category),
        child: Container(
          padding: _Styles.categoriesPadding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              _Styles.categoryCardBorderRadius,
            ),
            color: ColorManager.whiteColor,
            boxShadow: [
              BoxShadow(
                color: ColorManager.blackColor.withValues(alpha: 0.15),
                blurRadius: 8,
                spreadRadius: 0.2,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(category, style: _Styles.categoryCardTextStyle),
          ),
        ),
      ),
    );
  }

  Widget getRecommendSection({
    required List<ItemListingModel> itemListingList,
    required bool isLoading,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recommended For You', style: _Styles.blackTextStyle),
        SizedBox(height: 15),
        if (itemListingList.isEmpty) ...[
          Center(child: NoDataAvailableLabel(noDataText: 'No Items Found')),
        ],
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 30,
            crossAxisSpacing: 30,
            mainAxisExtent: 200,
          ),
          itemCount: itemListingList.length,
          itemBuilder: (context, index) {
            final item = itemListingList[index];
            return TouchableOpacity(
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
            );
          },
        ),
      ],
    );
  }

  Widget getFloatingActionButton({required int numOfCartItems}) {
    return CustomFloatingActionButton(
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(Icons.shopping_cart_rounded, color: ColorManager.whiteColor),
          if (numOfCartItems > 0) ...[
            Positioned(
              right: -5,
              top: -12,
              child: getCartItemBadge(numOfCartItems: numOfCartItems),
            ),
          ],
        ],
      ),
      onPressed: onCartPressed,
      heroTag: 'marketplace_fab',
    );
  }

  Widget getCartItemBadge({required int numOfCartItems}) {
    return Container(
      padding: _Styles.cartItemBadgePadding,
      decoration: BoxDecoration(
        color: ColorManager.redColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text('$numOfCartItems', style: _Styles.cartItemBadgeTextStyle),
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const categoryCardBorderRadius = 30.0;

  static const cartItemBadgePadding = EdgeInsets.all(4);

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const categoryCardPadding = EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 15,
  );

  static const categoriesPadding = EdgeInsets.symmetric(
    horizontal: 15,
    vertical: 8,
  );

  static final startSellingButtonStyle = ButtonStyle(
    overlayColor: WidgetStateProperty.all(ColorManager.lightGreyColor2),
  );

  static const startSellingTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const blackTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const categoryCardTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.primary,
  );

  static const cartItemBadgeTextStyle = TextStyle(
    fontSize: 11,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.whiteColor,
  );
}
