import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/cart/cart_model.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/cart_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/stripe_view_model.dart';
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
    return getBottomSheet(cartItemList: widget.cartItems);
  }

  @override
  Widget body() {
    return SingleChildScrollView(
      child: Padding(
        padding: _Styles.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getDeliveryDetailsSection(),
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

  Future<void> onPlaceOrderButtonPressed({required double amount}) async {
    final paymentIntentClientSecret = await tryLoad(
      context,
      () => context.read<StripeViewModel>().createPaymentIntent(amount: amount),
    );
    if (mounted) {
      final paymentStatus = await context.read<StripeViewModel>().makePayment(
        paymentIntentClientSecret: paymentIntentClientSecret ?? '',
      );

      switch (paymentStatus) {
        case PaymentStatus.success:
          if (mounted) await context.router.maybePop();
          print('successful');
          break;
        case PaymentStatus.cancelled:
          WidgetUtil.showSnackBar(text: 'Payment cancelled');
          break;
        case PaymentStatus.failed:
          WidgetUtil.showSnackBar(text: 'Payment failed, please try again');
          break;
      }
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CheckoutScreenState {
  Widget getDeliveryDetailsSection() {
    return CustomCard(
      padding: _Styles.customCardPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          getDeliveryTitleAndEditButton(),
          SizedBox(height: 10),
          getDeliveryAddress(),
        ],
      ),
    );
  }

  Widget getDeliveryTitleAndEditButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Delivery Address', style: _Styles.greyTextStyle),
        TouchableOpacity(child: Text('Edit', style: _Styles.editTextStyle)),
      ],
    );
  }

  Widget getDeliveryAddress() {
    return Text(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc varius urna eu ultricies egestas.',
      textAlign: TextAlign.justify,
      style: _Styles.deliveryAddressTextStyle,
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

  Widget getBottomSheet({required List<CartModel> cartItemList}) {
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
          getPlaceOrderButton(amount: totalAmount),
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

  Widget getPlaceOrderButton({required double amount}) {
    return CustomButton(
      text: 'Place Order',
      textColor: ColorManager.whiteColor,
      onPressed: () => onPlaceOrderButtonPressed(amount: amount),
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

  static const editTextStyle = TextStyle(
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
