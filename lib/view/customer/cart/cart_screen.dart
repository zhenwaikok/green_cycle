import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';

@RoutePage()
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Cart',
        isBackButtonVisible: true,
        onPressed: onBackButtonPressed,
      ),
      body: SafeArea(
        child: Padding(padding: _Styles.screenPadding, child: getCartList()),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CartScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  void onDeleteButtonPressed() {
    WidgetUtil.showAlertDialog(
      context,
      title: 'Delete Confirmation',
      content: 'Are you sure you want to delete this item from your cart?',
      actions: [
        getAlertDialogTextButton(onPressed: () {}, text: 'No'),
        getAlertDialogTextButton(onPressed: () {}, text: 'Yes'),
      ],
    );
  }

  void onCheckoutButtonPressed() {
    context.router.push(CheckoutRoute());
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CartScreenState {
  Widget getCartList() {
    return ListView.builder(
      padding: _Styles.listViewPadding,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(padding: _Styles.cardPadding, child: getCartCard());
      },
    );
  }

  Widget getCartCard() {
    return CustomCard(
      padding: _Styles.customCardPadding,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getSellerName(),
            getDivider(),
            getCartItems(),
            getDivider(),
            getTotalAmount(),
            getDivider(),
            getCheckoutButton(),
          ],
        ),
      ],
    );
  }

  Widget getSellerName() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          FontAwesomeIcons.shop,
          color: ColorManager.greyColor,
          size: _Styles.shopIconSize,
        ),
        SizedBox(width: 12),
        Text('Seller Name', style: _Styles.sellerNameTextStyle),
      ],
    );
  }

  Widget getCartItems() {
    return Column(
      children: List.generate(
        3,
        (index) => Padding(
          padding: _Styles.cartItemPadding,
          child: getCartItemDetails(),
        ),
      ),
    );
  }

  Widget getCartItemDetails() {
    return Row(
      children: [
        CustomImage(
          borderRadius: _Styles.itemImageBorderRadius,
          imageSize: _Styles.cartItemImageSize,
          imageURL:
              'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHx8MA%3D%3D',
        ),
        SizedBox(width: 10),
        Expanded(child: getCartItemDescription()),
        getDeleteButton(),
      ],
    );
  }

  Widget getCartItemDescription() {
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
                'Product Name',
                style: _Styles.blackTextStyle,
                maxLines: _Styles.maxTextLines,
                overflow: TextOverflow.ellipsis,
              ),
              CustomStatusBar(text: 'Like New'),
            ],
          ),
          Text('RM xx.xx', style: _Styles.priceTextStyle),
        ],
      ),
    );
  }

  Widget getDeleteButton() {
    return IconButton(
      onPressed: onDeleteButtonPressed,
      icon: Icon(
        Icons.delete,
        color: ColorManager.greyColor,
        size: _Styles.deleteIconSize,
      ),
    );
  }

  Widget getTotalAmount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Total (x items)', style: _Styles.blackTextStyle),
        Text('RM xx.xx', style: _Styles.totalPriceTextStyle),
      ],
    );
  }

  Widget getCheckoutButton() {
    return CustomButton(
      text: 'Checkout',
      textColor: ColorManager.whiteColor,
      onPressed: onCheckoutButtonPressed,
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
  static const shopIconSize = 15.0;

  static const dividerPadding = EdgeInsets.symmetric(vertical: 5);

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 10,
  );

  static const listViewPadding = EdgeInsets.all(10);

  static const customCardPadding = EdgeInsets.symmetric(
    horizontal: 15,
    vertical: 15,
  );

  static const cardPadding = EdgeInsets.symmetric(vertical: 15);
  static const cartItemPadding = EdgeInsets.symmetric(vertical: 10);

  static const sellerNameTextStyle = TextStyle(
    fontSize: 20,
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
