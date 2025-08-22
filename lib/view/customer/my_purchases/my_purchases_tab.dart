import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/purchases/purchases_model.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/viewmodel/purchase_view_model.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyPurchasesTab extends StatefulWidget {
  const MyPurchasesTab({
    super.key,
    required this.purchaseItems,
    required this.purchaseGroupID,
    required this.sellerName,
    required this.isLoading,
    required this.onOrderReceivedButtonPressed,
  });

  final String purchaseGroupID;
  final String sellerName;
  final List<PurchasesModel> purchaseItems;
  final bool isLoading;
  final VoidCallback onOrderReceivedButtonPressed;

  @override
  State<MyPurchasesTab> createState() => _MyPurchasesTabState();
}

class _MyPurchasesTabState extends State<MyPurchasesTab> {
  @override
  Widget build(BuildContext context) {
    return getPurchaseCard();
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on MyPurchasesTab {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _MyPurchasesTabState {
  Widget getPurchaseCard() {
    return Padding(
      padding: _Styles.cardPadding,
      child: CustomCard(
        padding: _Styles.customCardPadding,
        child: Skeletonizer(
          enabled: widget.isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getOrderDetails(
                sellerName: widget.sellerName,
                purchaseGroupID: widget.purchaseGroupID,
                purchaseDate:
                    widget.purchaseItems.first.purchaseDate ?? DateTime.now(),
                purchaseStatus: widget.purchaseItems.first.status ?? '',
              ),
              getDivider(),
              getItemList(purchaseItems: widget.purchaseItems),
              getDivider(),
              getBottomDetails(purchaseItems: widget.purchaseItems),
            ],
          ),
        ),
      ),
    );
  }

  Widget getOrderDetails({
    required String sellerName,
    required String purchaseGroupID,
    required DateTime purchaseDate,
    required String purchaseStatus,
  }) {
    final backgroundColor = WidgetUtil.getPurchaseStatusColor(purchaseStatus);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.person_outlined,
              color: ColorManager.greyColor,
              size: _Styles.iconSize,
            ),
            SizedBox(width: 8),
            Text(sellerName, style: _Styles.sellerTextStyle),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Order ID', style: _Styles.greyTextStyle),
                Text('#$purchaseGroupID', style: _Styles.blackTextStyle),
              ],
            ),
            CustomStatusBar(
              text: purchaseStatus,
              backgroundColor: backgroundColor,
            ),
          ],
        ),
        Text(
          'Purchase On: ${WidgetUtil.dateTimeFormatter(purchaseDate)}',
          style: _Styles.greyTextStyle,
        ),
      ],
    );
  }

  Widget getItemList({required List<PurchasesModel> purchaseItems}) {
    return Column(
      children: List.generate(
        purchaseItems.length,
        (index) => getItemDetails(purchaseItemDetails: purchaseItems[index]),
      ),
    );
  }

  Widget getItemDetails({required PurchasesModel purchaseItemDetails}) {
    return Padding(
      padding: _Styles.itemListPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomImage(
            imageSize: _Styles.itemImageSize,
            imageURL: purchaseItemDetails.itemImageURL?.first ?? '',
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
                    purchaseItemDetails.itemName ?? '',
                    style: _Styles.itemNameTextStyle,
                    maxLines: _Styles.maxTextLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                  CustomStatusBar(
                    text: purchaseItemDetails.itemCondition ?? '',
                  ),
                ],
              ),
            ),
          ),

          Text(
            'RM ${WidgetUtil.priceFormatter(purchaseItemDetails.itemPrice ?? 0.0)}',
            style: _Styles.priceTextStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget getBottomDetails({required List<PurchasesModel> purchaseItems}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTotalAmount(purchaseItems: purchaseItems),
        if (purchaseItems.first.status == 'Completed') ...[
          SizedBox(height: 10),
          getDeliveredDetails(
            deliveredDate: purchaseItems.first.deliveredDate ?? DateTime.now(),
          ),
        ],
        if (purchaseItems.first.status == 'Shipped') ...[
          SizedBox(height: 10),
          getOrderReceivedButton(),
        ],
      ],
    );
  }

  Widget getTotalAmount({required List<PurchasesModel> purchaseItems}) {
    final totalAmount = context.read<PurchaseViewModel>().calculateTotalAmount(
      purchaseList: purchaseItems,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Total Amount:', style: _Styles.blackTextStyle),
        Text(
          'RM ${WidgetUtil.priceFormatter(totalAmount)}',
          style: _Styles.totalPriceTextStyle,
        ),
      ],
    );
  }

  Widget getDeliveredDetails({required DateTime deliveredDate}) {
    return RichText(
      text: TextSpan(
        text: 'Delivered On: ',
        style: _Styles.greyTextStyle,
        children: [
          TextSpan(
            text: WidgetUtil.dateTimeFormatter(deliveredDate),
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
      onPressed: widget.onOrderReceivedButtonPressed,
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
  static const iconSize = 20.0;

  static const cardPadding = EdgeInsets.symmetric(horizontal: 5, vertical: 10);
  static const customCardPadding = EdgeInsets.symmetric(
    vertical: 10,
    horizontal: 10,
  );
  static const dividerPadding = EdgeInsets.symmetric(vertical: 6);
  static const itemListPadding = EdgeInsets.symmetric(vertical: 10);

  static const sellerTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

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
