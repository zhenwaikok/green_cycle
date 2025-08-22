import 'dart:async';

import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/cart/cart_model.dart';
import 'package:green_cycle_fyp/model/api_model/item_listing/item_listing_model.dart';
import 'package:green_cycle_fyp/repository/cart_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/cart_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:green_cycle_fyp/widget/no_data_label.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        CartViewModel(
          cartRepository: CartRepository(),
          userRepository: UserRepository(
            sharePreferenceHandler: SharedPreferenceHandler(),
            userServices: UserServices(),
          ),
        );
      },
      child: _CartScreen(),
    );
  }
}

class _CartScreen extends BaseStatefulPage {
  @override
  State<_CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends BaseStatefulState<_CartScreen> {
  bool isLoading = true;
  bool removeItem = false;

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
      title: 'Cart',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  EdgeInsets defaultPadding() {
    return _Styles.screenPadding;
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  Widget body() {
    final groupCartItemsBySeller = context.select(
      (CartViewModel vm) => vm.groupedCartItems.entries.toList(),
    );

    final loadingList = List.generate(
      3,
      (index) =>
          CartModel(itemListing: ItemListingModel(itemName: 'Loading...')),
    );

    return AdaptiveWidgets.buildRefreshableScrollView(
      context,
      onRefresh: fetchData,
      color: ColorManager.blackColor,
      refreshIndicatorBackgroundColor: ColorManager.whiteColor,
      slivers: [
        getcartList(
          isLoading: isLoading,
          groupCartItemsBySeller: groupCartItemsBySeller,
          loadingList: loadingList,
        ),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CartScreenState {
  void onBackButtonPressed() {
    context.router.maybePop(removeItem);
  }

  void onDeleteButtonPressed({required int cartID}) {
    WidgetUtil.showAlertDialog(
      context,
      title: 'Delete Confirmation',
      content: 'Are you sure you want to delete this item from your cart?',
      actions: [
        getAlertDialogTextButton(
          onPressed: () => context.router.maybePop(),
          text: 'No',
        ),
        getAlertDialogTextButton(
          onPressed: () => removeFromCart(cartID: cartID),
          text: 'Yes',
        ),
      ],
    );
  }

  Future<void> removeFromCart({required int cartID}) async {
    await context.router.maybePop();

    if (mounted) {
      final result =
          await tryLoad(
            context,
            () => context.read<CartViewModel>().removeFromCart(cartID: cartID),
          ) ??
          false;

      if (result) {
        _setState(() => removeItem = true);
        unawaited(
          WidgetUtil.showSnackBar(text: 'Item removed from cart successfully'),
        );
        await fetchData();
      }
    }
  }

  void onCheckoutButtonPressed({required List<CartModel> cartItems}) {
    context.router.push(CheckoutRoute(cartItems: cartItems));
  }

  void onCartItemPressed({required int itemListingID}) {
    context.router.push(ItemDetailsRoute(itemListingID: itemListingID));
  }

  Future<void> fetchData() async {
    _setState(() => isLoading = true);
    final userVM = context.read<UserViewModel>();
    final userID = context.read<UserViewModel>().user?.userID ?? '';

    await tryCatch(
      context,
      () => context.read<CartViewModel>().getUserCartItems(
        userID: userID,
        userViewModel: userVM,
        groupCartItem: true,
      ),
    );
    _setState(() => isLoading = false);
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CartScreenState {
  Widget getcartList({
    required bool isLoading,
    required List<CartModel> loadingList,
    required List groupCartItemsBySeller,
  }) {
    if (isLoading) {
      return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return Padding(
            padding: _Styles.cardPadding,
            child: getCartCard(
              cartItemList: loadingList,
              isLoading: isLoading,
              sellerNamee: 'Loading...',
            ),
          );
        }, childCount: 3),
      );
    }

    if (groupCartItemsBySeller.isEmpty) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: NoDataAvailableLabel(noDataText: 'Your cart is empty'),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final sellerName = groupCartItemsBySeller[index].value['sellerName'];
        final items =
            groupCartItemsBySeller[index].value['items'] as List<CartModel>;

        return Padding(
          padding: _Styles.cardPadding,
          child: getCartCard(
            cartItemList: items,
            isLoading: false,
            sellerNamee: sellerName,
          ),
        );
      }, childCount: groupCartItemsBySeller.length),
    );
  }

  Widget getCartCard({
    required List<CartModel> cartItemList,
    required String sellerNamee,
    required bool isLoading,
  }) {
    return CustomCard(
      padding: _Styles.customCardPadding,
      child: Skeletonizer(
        enabled: isLoading,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getSellerName(sellerName: sellerNamee),
            getDivider(),
            getCartItems(cartItemList: cartItemList),
            getDivider(),
            getTotalAmount(cartItemList: cartItemList),
            getDivider(),
            getCheckoutButton(cartItems: cartItemList),
          ],
        ),
      ),
    );
  }

  Widget getSellerName({required String sellerName}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.person,
          color: ColorManager.blackColor,
          size: _Styles.shopIconSize,
        ),
        SizedBox(width: 8),
        Text(sellerName, style: _Styles.sellerNameTextStyle),
      ],
    );
  }

  Widget getCartItems({required List<CartModel> cartItemList}) {
    return Column(
      children: List.generate(
        cartItemList.length,
        (index) => Padding(
          padding: _Styles.cartItemPadding,
          child: getCartItemDetails(cartItemDetails: cartItemList[index]),
        ),
      ),
    );
  }

  Widget getCartItemDetails({required CartModel cartItemDetails}) {
    return TouchableOpacity(
      onPressed: () => onCartItemPressed(
        itemListingID: cartItemDetails.itemListing?.itemListingID ?? 0,
      ),
      child: Row(
        children: [
          CustomImage(
            borderRadius: _Styles.itemImageBorderRadius,
            imageSize: _Styles.cartItemImageSize,
            imageURL: cartItemDetails.itemListing?.itemImageURL?.first ?? '',
          ),
          SizedBox(width: 10),
          Expanded(
            child: getCartItemDescription(
              productName: cartItemDetails.itemListing?.itemName ?? '',
              condition: cartItemDetails.itemListing?.itemCondition ?? '',
              price: cartItemDetails.itemListing?.itemPrice ?? 0.0,
            ),
          ),
          getDeleteButton(cartID: cartItemDetails.cartID ?? 0),
        ],
      ),
    );
  }

  Widget getCartItemDescription({
    required String productName,
    required String condition,
    required double price,
  }) {
    return SizedBox(
      height: _Styles.cartItemImageSize,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                style: _Styles.blackTextStyle,
                maxLines: _Styles.maxTextLines,
                overflow: TextOverflow.ellipsis,
              ),
              CustomStatusBar(text: condition),
            ],
          ),
          Text(
            'RM ${WidgetUtil.priceFormatter(price)}',
            style: _Styles.priceTextStyle,
          ),
        ],
      ),
    );
  }

  Widget getDeleteButton({required int cartID}) {
    return IconButton(
      onPressed: () => onDeleteButtonPressed(cartID: cartID),
      icon: Icon(
        Icons.delete,
        color: ColorManager.greyColor,
        size: _Styles.deleteIconSize,
      ),
    );
  }

  Widget getTotalAmount({required List<CartModel> cartItemList}) {
    final totalAmount = context.read<CartViewModel>().calculateTotalAmount(
      cartItemList: cartItemList,
    );
    final totalItems = cartItemList.length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          totalItems == 1
              ? 'Total ($totalItems item)'
              : 'Total ($totalItems items)',
          style: _Styles.blackTextStyle,
        ),
        Text(
          'RM ${WidgetUtil.priceFormatter(totalAmount)}',
          style: _Styles.totalPriceTextStyle,
        ),
      ],
    );
  }

  Widget getCheckoutButton({required List<CartModel> cartItems}) {
    return CustomButton(
      text: 'Checkout',
      textColor: ColorManager.whiteColor,
      onPressed: () => onCheckoutButtonPressed(cartItems: cartItems),
      backgroundColor: ColorManager.primary,
    );
  }

  Widget getDivider() {
    return Padding(
      padding: _Styles.dividerPadding,
      child: Divider(color: ColorManager.lightGreyColor),
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

  static const cartItemImageSize = 80.0;
  static const maxTextLines = 2;
  static const deleteIconSize = 20.0;
  static const itemImageBorderRadius = 5.0;
  static const shopIconSize = 20.0;

  static const dividerPadding = EdgeInsets.symmetric(vertical: 5);

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 10,
  );

  static const customCardPadding = EdgeInsets.symmetric(
    horizontal: 15,
    vertical: 15,
  );

  static const cardPadding = EdgeInsets.symmetric(vertical: 15, horizontal: 10);
  static const cartItemPadding = EdgeInsets.symmetric(vertical: 10);

  static const sellerNameTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const blackTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const priceTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.redColor,
  );

  static const totalPriceTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.redColor,
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
