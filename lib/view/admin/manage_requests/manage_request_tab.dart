import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/pickup_request/pickup_request_model.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ManageRequestTab extends StatefulWidget {
  const ManageRequestTab({
    super.key,
    required this.request,
    required this.onTap,
    required this.isLoading,
  });

  final PickupRequestModel request;
  final void Function() onTap;
  final bool isLoading;

  @override
  State<ManageRequestTab> createState() => _ManageRequestTabState();
}

class _ManageRequestTabState extends State<ManageRequestTab> {
  @override
  Widget build(BuildContext context) {
    return getRequestCard(request: widget.request);
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ManageRequestTabState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ManageRequestTabState {
  Widget getRequestCard({required PickupRequestModel request}) {
    return TouchableOpacity(
      onPressed: widget.onTap,
      isLoading: widget.isLoading,
      child: Padding(
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
                    getRequestID(requestID: request.pickupRequestID ?? ''),
                    getRequestStatus(status: request.pickupRequestStatus ?? ''),
                  ],
                ),
                getDivider(),
                getItemDetails(
                  imageURL: request.pickupItemImageURL?.first ?? '',
                  itemDescription: request.pickupItemDescription ?? '',
                  itemCategory: request.pickupItemCategory ?? '',
                  quantity: request.pickupItemQuantity ?? 0,
                ),
                getDivider(),
                getRequestDetailsDate(
                  text:
                      'Requested: ${WidgetUtil.dateTimeFormatter(request.requestedDate ?? DateTime.now())}',
                ),
                if (request.completedDate != null)
                  getRequestDetailsDate(
                    text:
                        'Completed: ${WidgetUtil.dateTimeFormatter(request.completedDate ?? DateTime.now())}',
                  ),
              ],
            ),
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

  Widget getRequestID({required String requestID}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Request ID', style: _Styles.requestIDTitleTextStyle),
        Text('#$requestID', style: _Styles.requestIDTextStyle),
      ],
    );
  }

  Widget getRequestStatus({required String status}) {
    final backgroundColor = WidgetUtil.getPickupRequestStatusColor(status);

    return CustomStatusBar(text: status, backgroundColor: backgroundColor);
  }

  Widget getItemDetails({
    required String imageURL,
    required String itemDescription,
    required String itemCategory,
    required int quantity,
  }) {
    return Row(
      children: [
        getItemImage(imageURL: imageURL),
        SizedBox(width: 15),
        Expanded(
          child: getItemDescription(
            itemDescription: itemDescription,
            itemCategory: itemCategory,
            quantity: quantity,
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
    required int quantity,
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
          Text('Quantity: $quantity', style: _Styles.quantityTextStyle),
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
