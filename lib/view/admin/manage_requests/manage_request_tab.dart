import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';

class ManageRequestTab extends StatefulWidget {
  const ManageRequestTab({
    super.key,
    required this.status,
    required this.onTap,
  });

  final String status;
  final void Function() onTap;

  @override
  State<ManageRequestTab> createState() => _ManageRequestTabState();
}

class _ManageRequestTabState extends State<ManageRequestTab> {
  @override
  Widget build(BuildContext context) {
    return getRequestCard();
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ManageRequestTabState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ManageRequestTabState {
  Widget getRequestCard() {
    return TouchableOpacity(
      onPressed: widget.onTap,
      child: Padding(
        padding: _Styles.cardPadding,
        child: CustomCard(
          padding: _Styles.customCardPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getRequestID(),
                  getRequestStatus(status: widget.status),
                ],
              ),
              getDivider(),
              getItemDetails(),
              getDivider(),
              getRequestDetailsDate(text: 'Requested: 29/4/2025, 11:22 PM'),
              getRequestDetailsDate(text: 'Completed: 29/4/2025, 11:22 PM'),
            ],
          ),
        ),
      ),
    );
  }

  Widget getRequestDetailsDate({required String text}) {
    return Text(text, style: _Styles.completedTextStyle);
  }

  Widget getDivider() {
    return Padding(
      padding: _Styles.dividerPadding,
      child: Divider(color: ColorManager.lightGreyColor),
    );
  }

  Widget getRequestID() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Request ID', style: _Styles.requestIDTitleTextStyle),
        Text('#REQ13113', style: _Styles.requestIDTextStyle),
      ],
    );
  }

  Widget getRequestStatus({required String status}) {
    return CustomStatusBar(text: status);
  }

  Widget getItemDetails() {
    return Row(
      children: [
        getItemImage(),
        SizedBox(width: 15),
        Expanded(child: getItemDescription()),
      ],
    );
  }

  Widget getItemImage() {
    return CustomImage(
      imageSize: _Styles.imageSize,
      imageURL:
          'https://thumbs.dreamstime.com/b/image-attractive-shopper-girl-dressed-casual-clothing-holding-paper-bags-standing-isolated-over-pyrple-iimage-attractive-150643339.jpg',
      borderRadius: _Styles.imageBorderRadius,
    );
  }

  Widget getItemDescription() {
    return SizedBox(
      height: _Styles.imageSize,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Item Descriptionsas0',
                maxLines: _Styles.maxTextLines,
                overflow: TextOverflow.ellipsis,
                style: _Styles.itemDescriptionTextStyle,
              ),
              Text('Category', style: _Styles.itemDescriptionTextStyle),
            ],
          ),
          Text('Quantity: 1', style: _Styles.quantityTextStyle),
        ],
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const imageSize = 100.0;
  static const imageBorderRadius = 5.0;
  static const maxTextLines = 2;

  static const dividerPadding = EdgeInsets.symmetric(vertical: 6);

  static const cardPadding = EdgeInsets.symmetric(vertical: 15, horizontal: 5);
  static const customCardPadding = EdgeInsets.symmetric(
    vertical: 10,
    horizontal: 10,
  );

  static const requestIDTitleTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const requestIDTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const itemDescriptionTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const quantityTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.greyColor,
  );

  static const completedTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );
}
