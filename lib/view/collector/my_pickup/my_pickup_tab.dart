import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/pickup_request/pickup_request_model.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyPickupTab extends StatefulWidget {
  const MyPickupTab({
    super.key,
    required this.onPressed,
    required this.pickupRequestDetails,
    required this.isLoading,
  });

  final PickupRequestModel pickupRequestDetails;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  State<MyPickupTab> createState() => _MyPickupTabState();
}

class _MyPickupTabState extends State<MyPickupTab> {
  @override
  Widget build(BuildContext context) {
    return getPickupCard(pickupRequestDetails: widget.pickupRequestDetails);
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _MyPickupTabState {
  Widget getPickupCard({required PickupRequestModel pickupRequestDetails}) {
    return Padding(
      padding: _Styles.cardPadding,
      child: CustomCard(
        padding: _Styles.customCardPadding,
        child: Skeletonizer(
          enabled: widget.isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getRequestID(
                    pickupRequestID: pickupRequestDetails.pickupRequestID ?? '',
                  ),
                  getRequestStatus(
                    status: pickupRequestDetails.pickupRequestStatus ?? '',
                  ),
                ],
              ),
              getDivider(),
              getItemDetails(pickupRequestDetails: pickupRequestDetails),
              getDivider(),
              getRequestDetails(
                pickupLocation: pickupRequestDetails.pickupLocation ?? '',
                pickupDate: pickupRequestDetails.pickupDate ?? DateTime.now(),
                pickupTimeRange: pickupRequestDetails.pickupTimeRange ?? '',
              ),
              SizedBox(height: 20),
              getButton(
                status: pickupRequestDetails.pickupRequestStatus ?? '',
                onPressed: widget.onPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getRequestDetails({
    required String pickupLocation,
    required DateTime pickupDate,
    required String pickupTimeRange,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        getRequestDetailsText(
          icon: Icons.location_on,
          title: 'Pickup Location: ',
          text: pickupLocation,
        ),

        SizedBox(height: 10),

        getRequestDetailsText(
          icon: Icons.access_time,
          title: 'Pickup Time: ',
          text: '${WidgetUtil.dateFormatter(pickupDate)}, $pickupTimeRange',
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

  Widget getRequestID({required String pickupRequestID}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Request ID', style: _Styles.requestIDTitleTextStyle),
        Text('#$pickupRequestID', style: _Styles.requestIDTextStyle),
      ],
    );
  }

  Widget getRequestStatus({required String status}) {
    final backgroundColor = WidgetUtil.getPickupRequestStatusColor(status);
    return CustomStatusBar(text: status, backgroundColor: backgroundColor);
  }

  Widget getItemDetails({required PickupRequestModel pickupRequestDetails}) {
    return Row(
      children: [
        getItemImage(
          imageURL: pickupRequestDetails.pickupItemImageURL?.first ?? '',
        ),
        SizedBox(width: 15),
        Expanded(
          child: getItemDescription(
            itemDescription: pickupRequestDetails.pickupItemDescription ?? '',
            itemCategory: pickupRequestDetails.pickupItemCategory ?? '',
            itemQuantity: pickupRequestDetails.pickupItemQuantity ?? 0,
          ),
        ),
      ],
    );
  }

  Widget getItemImage({required String imageURL}) {
    return CustomImage(
      imageSize: _Styles.imageSize,
      imageURL: imageURL,
      borderRadius: _Styles.imageBorderRadius,
    );
  }

  Widget getItemDescription({
    required String itemDescription,
    required String itemCategory,
    required int itemQuantity,
  }) {
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
                itemDescription,
                maxLines: _Styles.maxTextLines,
                overflow: TextOverflow.ellipsis,
                style: _Styles.itemDescriptionTextStyle,
              ),
              Text(itemCategory, style: _Styles.itemDescriptionTextStyle),
            ],
          ),
          Text('Quantity: $itemQuantity', style: _Styles.quantityTextStyle),
        ],
      ),
    );
  }

  Widget getButton({
    required String status,
    required void Function() onPressed,
  }) {
    return CustomButton(
      text: WidgetUtil.getButtonLabel(status),
      textColor: ColorManager.whiteColor,
      onPressed: onPressed,
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
