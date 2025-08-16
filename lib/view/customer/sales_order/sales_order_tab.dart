import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/purchases/purchases_model.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/viewmodel/purchase_view_model.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SalesOrderTab extends StatefulWidget {
  const SalesOrderTab({
    super.key,
    required this.purchaseItems,
    required this.purchaseGroupID,
    required this.buyerName,
    required this.isLoading,
    required this.onMarkAsShippedButtonPressed,
  });

  final String purchaseGroupID;
  final String buyerName;
  final List<PurchasesModel> purchaseItems;
  final bool isLoading;
  final VoidCallback onMarkAsShippedButtonPressed;

  @override
  State<SalesOrderTab> createState() => _MyPurchasesTabState();
}

class _MyPurchasesTabState extends State<SalesOrderTab> {
  @override
  Widget build(BuildContext context) {
    return getPurchaseCard();
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _MyPurchasesTabState {
  Widget getPurchaseCard() {
    return Padding(
      padding: _Styles.cardPadding,
      child: CustomCard(
        padding: EdgeInsets.zero,
        child: Skeletonizer(
          enabled: widget.isLoading,
          child: Column(
            children: [
              Padding(
                padding: _Styles.customCardPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getOrderDetails(
                      purchaseGroupID: widget.purchaseGroupID,
                      purchaseDate:
                          widget.purchaseItems.first.purchaseDate ??
                          DateTime.now(),
                      purchaseStatus: widget.purchaseItems.first.status ?? '',
                    ),
                    getDivider(),
                    getItemList(purchaseItems: widget.purchaseItems),
                    getDivider(),
                    getBuyerDetails(
                      buyerName: widget.buyerName,
                      deliveryAddress:
                          widget.purchaseItems.first.deliveryAddress ?? '',
                    ),
                  ],
                ),
              ),
              getBottomDetails(purchaseItems: widget.purchaseItems),
            ],
          ),
        ),
      ),
    );
  }

  Widget getOrderDetails({
    required String purchaseGroupID,
    required DateTime purchaseDate,
    required String purchaseStatus,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('#$purchaseGroupID', style: _Styles.boldBlackTextStyle),
              Text(
                WidgetUtil.dateTimeFormatter(purchaseDate),
                style: _Styles.greyTextStyle,
              ),
            ],
          ),
        ),
        if (purchaseStatus == 'In Progress') getMarkShippedButton(),
      ],
    );
  }

  Widget getMarkShippedButton() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorManager.primaryLight,
      ),
      child: IconButton(
        onPressed: widget.onMarkAsShippedButtonPressed,
        icon: Icon(
          Icons.local_shipping,
          color: ColorManager.primary,
          size: _Styles.iconSize,
        ),
      ),
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
                    style: _Styles.boldBlackTextStyle,
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

  Widget getBuyerDetails({
    required String buyerName,
    required String deliveryAddress,
  }) {
    return Column(
      children: [
        getBuyerDetailsElement(
          iconData: Icons.person,
          buyerDetailsValue: buyerName,
        ),
        SizedBox(height: 8),
        getBuyerDetailsElement(
          iconData: Icons.location_on_rounded,
          buyerDetailsValue: deliveryAddress,
        ),
      ],
    );
  }

  Widget getBuyerDetailsElement({
    required IconData iconData,
    required String buyerDetailsValue,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(iconData, size: _Styles.iconSize, color: ColorManager.blackColor),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            buyerDetailsValue,
            style: _Styles.regularBlackTextStyle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget getBottomDetails({required List<PurchasesModel> purchaseItems}) {
    final totalAmount = context.read<PurchaseViewModel>().calculateTotalAmount(
      purchaseList: purchaseItems,
    );

    return Container(
      padding: _Styles.customCardPadding,
      decoration: BoxDecoration(
        color: ColorManager.lightGreyColor2.withValues(alpha: 0.5),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(_Styles.cardBorderRadius),
          bottomRight: Radius.circular(_Styles.cardBorderRadius),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getBottomDetailsElement(
                title: 'Total',
                value: 'RM ${WidgetUtil.priceFormatter(totalAmount)}',
                textStyle: _Styles.bottomDetailsBlackTextStyle,
              ),
              getBottomDetailsElement(
                title: 'Item(s)',
                value: '${purchaseItems.length}',
                textStyle: _Styles.bottomDetailsBlackTextStyle,
              ),

              getBottomDetailsElement(
                title: 'Status',
                value: '${purchaseItems.first.status}',
                textStyle: _Styles.orderStatusTextStyle(
                  status: purchaseItems.first.status ?? '',
                ),
              ),
            ],
          ),
          if (purchaseItems.first.status == 'Completed') ...[
            SizedBox(height: 25),
            getDeliveredDetails(
              deliveredDate:
                  purchaseItems.first.deliveredDate ?? DateTime.now(),
            ),
          ],
        ],
      ),
    );
  }

  Widget getBottomDetailsElement({
    required String title,
    required String value,
    required TextStyle textStyle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: _Styles.bottomGreyTextStyle),
        SizedBox(height: 10),
        Text(
          value,
          style: textStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget getDeliveredDetails({required DateTime deliveredDate}) {
    return Text(
      'Completed on: ${WidgetUtil.dateTimeFormatter(deliveredDate)}',
      style: _Styles.deliveredDateTextStyle,
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
  static const cardBorderRadius = 15.0;

  static const cardPadding = EdgeInsets.symmetric(horizontal: 5, vertical: 10);
  static const customCardPadding = EdgeInsets.symmetric(
    vertical: 10,
    horizontal: 10,
  );
  static const dividerPadding = EdgeInsets.symmetric(vertical: 6);
  static const itemListPadding = EdgeInsets.symmetric(vertical: 10);

  static const regularBlackTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const greyTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const boldBlackTextStyle = TextStyle(
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
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const bottomGreyTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.semiBold,
    color: ColorManager.greyColor,
  );

  static const bottomDetailsBlackTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static TextStyle orderStatusTextStyle({required String status}) => TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: WidgetUtil.getPurchaseStatusColor(status),
  );
}
