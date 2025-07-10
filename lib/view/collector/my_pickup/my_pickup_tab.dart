import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';

class MyPickupTab extends StatefulWidget {
  const MyPickupTab({
    super.key,
    this.statusBarColor,
    required this.status,
    required this.buttonText,
    required this.onPressed,
  });

  final Color? statusBarColor;
  final String status;
  final String buttonText;
  final void Function() onPressed;

  @override
  State<MyPickupTab> createState() => _MyPickupTabState();
}

class _MyPickupTabState extends State<MyPickupTab> {
  @override
  Widget build(BuildContext context) {
    return getPickupCard();
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _MyPickupTabState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _MyPickupTabState {
  Widget getPickupCard() {
    return GestureDetector(
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
                children: [getRequestID(), getRequestStatus()],
              ),
              getDivider(),
              getItemDetails(),
              getDivider(),
              getRequestDetails(),
              SizedBox(height: 20),
              getButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getRequestDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        getRequestDetailsText(
          icon: Icons.location_on,
          title: 'Pickup Location: ',
          text:
              'No. 1, Jalan Balakong Jaya 1, Taman Balakong Jaya, 43300 Seri Kembangan, Selangor, Malaysia. ',
        ),

        SizedBox(height: 10),

        getRequestDetailsText(
          icon: Icons.access_time,
          title: 'Pickup Time: ',
          text: '29/4/2025, 11pm - 12am',
        ),
      ],
    );
  }

  Widget getRequestDetailsText({
    required IconData icon,
    required String title,
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Align icon to top
      children: [
        Icon(icon, color: ColorManager.blackColor, size: _Styles.iconSize),
        SizedBox(width: 5),
        Expanded(
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: title,
              style: _Styles.blackTextStyle,
              children: [TextSpan(text: text, style: _Styles.greyTextStyle)],
            ),
          ),
        ),
      ],
    );
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

  Widget getRequestStatus() {
    return CustomStatusBar(text: widget.status, color: widget.statusBarColor);
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

  Widget getButton() {
    return CustomButton(
      text: widget.buttonText,
      textColor: ColorManager.whiteColor,
      onPressed: widget.onPressed,
      backgroundColor: ColorManager.primary,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const imageSize = 100.0;
  static const imageBorderRadius = 5.0;
  static const maxTextLines = 2;
  static const iconSize = 15.0;

  static const dividerPadding = EdgeInsets.symmetric(vertical: 6);

  static const cardPadding = EdgeInsets.symmetric(vertical: 10, horizontal: 10);
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

  static const blackTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const greyTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );
}
