import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/cart/cart_model.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/cart_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/item_listing_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/notification_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/purchase_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/stripe_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';

@RoutePage()
class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key, required this.cartItems});

  final List<CartModel> cartItems;

  @override
  Widget build(BuildContext context) {
    return _CheckoutScreen(cartItems: cartItems);
  }
}

class _CheckoutScreen extends BaseStatefulPage {
  const _CheckoutScreen({required this.cartItems});

  final List<CartModel> cartItems;

  @override
  State<_CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends BaseStatefulState<_CheckoutScreen> {
  String? userAddress;
  bool hasAddress = false;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserAddress();
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Checkout',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  EdgeInsets defaultPadding() {
    return EdgeInsets.zero;
  }

  @override
  Widget bottomNavigationBar() {
    return getBottomSheet(
      cartItemList: widget.cartItems,
      deliveryAddress: userAddress ?? '',
    );
  }

  @override
  Widget body() {
    return SingleChildScrollView(
      child: Padding(
        padding: _Styles.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getDeliveryDetailsSection(
              hasAddress: hasAddress,
              address: userAddress ?? '',
            ),
            SizedBox(height: 35),
            getCartItems(cartItems: widget.cartItems),
          ],
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CheckoutScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  Future<void> onPlaceOrderButtonPressed({
    required double amount,
    required List<CartModel> cartItemList,
    required String deliveryAddress,
  }) async {
    if (hasAddress) {
      final paymentIntentClientSecret = await tryLoad(
        context,
        () =>
            context.read<StripeViewModel>().createPaymentIntent(amount: amount),
      );
      if (mounted) {
        final paymentStatus = await context.read<StripeViewModel>().makePayment(
          paymentIntentClientSecret: paymentIntentClientSecret ?? '',
        );

        switch (paymentStatus) {
          case PaymentStatus.success:
            EasyLoading.show();
            final addPurchaseResult = await addPurchases(
              cartItemList: cartItemList,
              deliveryAddress: deliveryAddress,
            );
            if (addPurchaseResult) {
              final updateItemListingResult = await updateItemListing(
                cartItemList: cartItemList,
              );

              if (updateItemListingResult) {
                await sendPushNotification(
                  sellerUserID: cartItemList.first.sellerUserID ?? '',
                  title: 'Sales Order Received',
                  body:
                      'Your item(s) have been successfully purchased. Kindly please check your sales order for more details.',
                );
                await clearAllCartItems(cartItemList: cartItemList);
              }
            }
            EasyLoading.dismiss();
            break;
          case PaymentStatus.cancelled:
            WidgetUtil.showSnackBar(text: 'Payment cancelled');
            break;
          case PaymentStatus.failed:
            WidgetUtil.showSnackBar(text: 'Payment failed, please try again');
            break;
        }
      }
    } else {
      WidgetUtil.showSnackBar(text: 'Please provide a delivery address');
    }
  }

  Future<void> sendPushNotification({
    required String sellerUserID,
    required String title,
    required String body,
  }) async {
    final fcmToken = await tryLoad(
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

  Future<bool> addPurchases({
    required List<CartModel> cartItemList,
    required String deliveryAddress,
  }) async {
    final purchaseVM = context.read<PurchaseViewModel>();
    final purchaseGroupID = purchaseVM.generatePurchaseID();
    final purchaseDate = DateTime.now();
    bool allSuccess = true;

    for (var item in cartItemList) {
      final result = await tryCatch(
        context,
        () => purchaseVM.insertPurchases(
          buyerUserID: item.buyerUserID ?? '',
          sellerUserID: item.sellerUserID ?? '',
          itemListingID: item.itemListingID ?? 0,
          purchaseGroupID: purchaseGroupID,
          itemName: item.itemListing?.itemName ?? '',
          itemPrice: item.itemListing?.itemPrice ?? 0.0,
          itemCondition: item.itemListing?.itemCondition ?? '',
          itemCategory: item.itemListing?.itemCategory ?? '',
          itemImageURL: item.itemListing?.itemImageURL ?? [],
          deliveryAddress: deliveryAddress,
          purchaseDate: purchaseDate,
        ),
      );

      if (result == null || result == false) {
        allSuccess = false;
      }
    }
    return allSuccess;
  }

  Future<bool> updateItemListing({
    required List<CartModel> cartItemList,
  }) async {
    bool allSuccess = true;

    for (var item in cartItemList) {
      final result = await tryCatch(
        context,
        () => context.read<ItemListingViewModel>().updateItemListing(
          imageURLs: item.itemListing?.itemImageURL ?? [],
          itemName: item.itemListing?.itemName ?? '',
          itemDescription: item.itemListing?.itemDescription ?? '',
          itemPrice: item.itemListing?.itemPrice ?? 0.0,
          itemCondition: item.itemListing?.itemCondition ?? '',
          itemCategory: item.itemListing?.itemCategory ?? '',
          isSold: true,
          itemListingID: item.itemListingID,
          userID: item.sellerUserID ?? '',
          status: item.itemListing?.status ?? '',
          createdDate: item.itemListing?.createdDate,
        ),
      );

      if (result == null || result == false) {
        allSuccess = false;
      }
    }

    return allSuccess;
  }

  Future<void> clearAllCartItems({
    required List<CartModel> cartItemList,
  }) async {
    bool allSuccess = true;

    for (var item in cartItemList) {
      final result = await tryCatch(
        context,
        () => context.read<CartViewModel>().removeFromCart(
          cartID: item.cartID ?? 0,
        ),
      );

      if (result == null || result == false) {
        allSuccess = false;
      }
    }

    if (allSuccess) {
      pushToSuccessScreen();
    }
  }

  void pushToSuccessScreen() {
    context.router.replaceAll([
      SuccessRoute(
        title: 'Purchase Successful!',
        message:
            'Thank you for your purchase! Your order has been confirmed and is now being processed. The seller will prepare your items for delivery, and you can track the status in the “My Purchases” section.',
        buttonText: 'Continue',
      ),
    ]);
  }

  Future<void> fetchUserAddress() async {
    final userVM = context.read<UserViewModel>();
    final userID = userVM.user?.userID ?? '';
    await tryLoad(context, () => userVM.getUserDetails(userID: userID));

    final address1 = userVM.user?.address1;
    final address2 = userVM.user?.address2;
    final city = userVM.user?.city;
    final postalCode = userVM.user?.postalCode;
    final state = userVM.user?.state;

    _setState(() {
      userAddress = '$address1, $address2, $postalCode $city, $state';

      hasAddress = [
        address1,
        address2,
        city,
        postalCode,
        state,
      ].every((e) => e != null && e.isNotEmpty);
    });
  }

  void onAddOrEditAddressPressed({required bool isAddAddress}) async {
    final result = await context.router.push(
      AddOrEditAddressRoute(isAddAddress: isAddAddress),
    );

    if (result == true && mounted) {
      await fetchUserAddress();
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CheckoutScreenState {
  Widget getDeliveryDetailsSection({
    required bool hasAddress,
    required String address,
  }) {
    return CustomCard(
      padding: _Styles.customCardPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          getDeliveryTitleAndEditButton(hasAddress: hasAddress),
          SizedBox(height: 10),
          if (!hasAddress) ...[
            getProvideAddress(),
          ] else ...[
            getDeliveryAddress(address: address),
          ],
        ],
      ),
    );
  }

  Widget getDeliveryTitleAndEditButton({required bool hasAddress}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.location_on,
              size: _Styles.iconSize,
              color: ColorManager.greyColor,
            ),
            SizedBox(width: 5),
            Text('Delivery Address', style: _Styles.greyTextStyle),
          ],
        ),
        if (hasAddress)
          TouchableOpacity(
            onPressed: () => onAddOrEditAddressPressed(isAddAddress: false),
            child: Text('Edit', style: _Styles.greenTextStyle),
          ),
      ],
    );
  }

  Widget getDeliveryAddress({required String address}) {
    return Text(
      address,
      textAlign: TextAlign.justify,
      style: _Styles.deliveryAddressTextStyle,
    );
  }

  Widget getProvideAddress() {
    return TouchableOpacity(
      onPressed: () => onAddOrEditAddressPressed(isAddAddress: true),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Please provide your delivery address',
            style: _Styles.greenTextStyle,
          ),
          SizedBox(width: 15),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: ColorManager.primary,
            size: _Styles.iconSize,
          ),
        ],
      ),
    );
  }

  Widget getCartItems({required List<CartModel> cartItems}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your Items', style: _Styles.blackTextStyle),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            return getCartItemCard(cartItem: cartItems[index]);
          },
        ),
      ],
    );
  }

  Widget getCartItemCard({required CartModel cartItem}) {
    return Padding(
      padding: _Styles.cardPadding,
      child: CustomCard(
        padding: _Styles.customCardPadding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getItemImage(
              imageURL: cartItem.itemListing?.itemImageURL?.first ?? '',
            ),
            SizedBox(width: 10),
            Expanded(
              child: getItemDetails(
                productName: cartItem.itemListing?.itemName ?? '',
                price: cartItem.itemListing?.itemPrice ?? 0.0,
              ),
            ),
            getItemCondition(
              condition: cartItem.itemListing?.itemCondition ?? '',
            ),
          ],
        ),
      ),
    );
  }

  Widget getItemImage({required String imageURL}) {
    return CustomImage(
      borderRadius: _Styles.itemImageBorderRadius,
      imageSize: _Styles.cartItemImageSize,
      imageURL: imageURL,
    );
  }

  Widget getItemDetails({required String productName, required double price}) {
    return SizedBox(
      height: _Styles.cartItemImageSize,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            productName,
            style: _Styles.blackSmallTextStyle,
            maxLines: _Styles.maxTextLines,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'RM ${WidgetUtil.priceFormatter(price)}',
            style: _Styles.productPriceTextStyle,
          ),
        ],
      ),
    );
  }

  Widget getItemCondition({required String condition}) {
    return CustomStatusBar(text: condition);
  }

  Widget getBottomSheet({
    required List<CartModel> cartItemList,
    required String deliveryAddress,
  }) {
    final numOfCartItems = cartItemList.length;
    final totalAmount = context.read<CartViewModel>().calculateTotalAmount(
      cartItemList: cartItemList,
    );

    return Padding(
      padding: _Styles.bottomSheetPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Summary', style: _Styles.blackTextStyle),
          SizedBox(height: 5),
          getOrderSummaryDetails(
            title: numOfCartItems == 1
                ? 'Item Total ($numOfCartItems item)'
                : 'Items Total ($numOfCartItems items)',
            amount: 'RM ${WidgetUtil.priceFormatter(totalAmount)}',
          ),
          SizedBox(height: 20),
          getTotalPriceDetails(
            title: 'Total',
            amount: 'RM ${WidgetUtil.priceFormatter(totalAmount)}',
          ),
          SizedBox(height: 15),
          getPlaceOrderButton(
            amount: totalAmount,
            cartItemList: cartItemList,
            deliveryAddress: deliveryAddress,
          ),
        ],
      ),
    );
  }

  Widget getOrderSummaryDetails({
    required String title,
    required String amount,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: _Styles.greyTextStyle),
        Text(amount, style: _Styles.blackSmallTextStyle),
      ],
    );
  }

  Widget getTotalPriceDetails({required String title, required String amount}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: _Styles.blackSmallTextStyle),
        Text(amount, style: _Styles.totalPriceTextStyle),
      ],
    );
  }

  Widget getPlaceOrderButton({
    required double amount,
    required List<CartModel> cartItemList,
    required String deliveryAddress,
  }) {
    return CustomButton(
      text: 'Place Order',
      textColor: ColorManager.whiteColor,
      onPressed: () => onPlaceOrderButtonPressed(
        amount: amount,
        cartItemList: cartItemList,
        deliveryAddress: deliveryAddress,
      ),
      backgroundColor: ColorManager.primary,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const cartItemImageSize = 80.0;
  static const itemImageBorderRadius = 5.0;
  static const maxTextLines = 2;
  static const iconSize = 15.0;

  static const bottomSheetPadding = EdgeInsets.all(20);
  static const cardPadding = EdgeInsets.symmetric(vertical: 10);
  static const customCardPadding = EdgeInsets.all(15);

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const greyTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.greyColor,
  );

  static const blackTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const greenTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const deliveryAddressTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const blackSmallTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const productPriceTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.redColor,
  );

  static const totalPriceTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.redColor,
  );
}
