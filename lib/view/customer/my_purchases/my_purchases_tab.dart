import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';

class MyPurchasesTab extends StatelessWidget {
  const MyPurchasesTab({super.key, required this.purchaseStatus});

  final String purchaseStatus;

  @override
  Widget build(BuildContext context) {
    return getPurchaseCard();
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on MyPurchasesTab {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on MyPurchasesTab {
  Widget getPurchaseCard() {
    return Padding(
      padding: _Styles.cardPadding,
      child: CustomCard(
        padding: _Styles.customCardPadding,
        children: [
          getOrderDetails(),
          getDivider(),
          getItemList(),
          getDivider(),
          getBottomDetails(),
        ],
      ),
    );
  }

  Widget getOrderDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text('Order ID', style: _Styles.greyTextStyle),
                Text('#14334', style: _Styles.blackTextStyle),
              ],
            ),
            CustomStatusBar(text: 'Shipped'),
          ],
        ),
        Text('Purchase On: 29/4/2025, 11:22 PM', style: _Styles.greyTextStyle),
      ],
    );
  }

  Widget getItemList() {
    return Column(children: List.generate(2, (index) => getItemDetails()));
  }

  Widget getItemDetails() {
    return Padding(
      padding: _Styles.itemListPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomImage(
            imageSize: _Styles.itemImageSize,
            imageURL:
                'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            borderRadius: _Styles.itemImageBorderRadius,
          ),
          SizedBox(width: 15),
          Expanded(
            child: SizedBox(
              height: _Styles.itemImageSize,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Item Name',
                    style: _Styles.itemNameTextStyle,
                    maxLines: _Styles.maxTextLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                  CustomStatusBar(text: 'Like New'),
                ],
              ),
            ),
          ),

          Text(
            'RM xx.xx',
            style: _Styles.priceTextStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget getBottomDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTotalAmount(),
        if (purchaseStatus == 'Completed') ...[
          SizedBox(height: 10),
          getDeliveredDetails(),
        ],
        if (purchaseStatus == 'Shipped') ...[
          SizedBox(height: 10),
          getOrderReceivedButton(),
        ],
      ],
    );
  }

  Widget getTotalAmount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Total Amount:', style: _Styles.blackTextStyle),
        Text('RM xx.xx', style: _Styles.totalPriceTextStyle),
      ],
    );
  }

  Widget getDeliveredDetails() {
    return RichText(
      text: TextSpan(
        text: 'Delivered On: ',
        style: _Styles.greyTextStyle,
        children: [
          TextSpan(
            text: '29/4/2025, 11:22 PM',
            style: _Styles.deliveredDateTextStyle,
          ),
        ],
      ),
    );
  }

  Widget getOrderReceivedButton() {
    return CustomButton(
      text: 'Order Received',
      textColor: ColorManager.whiteColor,
      onPressed: () {},
      backgroundColor: ColorManager.primary,
    );
  }

  Widget getDivider() {
    return Padding(
      padding: _Styles.dividerPadding,
      child: Divider(color: ColorManager.lightGreyColor),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const maxTextLines = 2;
  static const itemImageBorderRadius = 5.0;
  static const itemImageSize = 80.0;
  static const orderReceivedButtonHeight = 25.0;

  static const cardPadding = EdgeInsets.symmetric(horizontal: 5, vertical: 10);
  static const customCardPadding = EdgeInsets.symmetric(
    vertical: 10,
    horizontal: 10,
  );
  static const dividerPadding = EdgeInsets.symmetric(vertical: 6);
  static const itemListPadding = EdgeInsets.symmetric(vertical: 10);

  static const greyTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const blackTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const itemNameTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const priceTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.redColor,
  );

  static const deliveredDateTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.primary,
  );

  static const totalPriceTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.redColor,
  );
}
