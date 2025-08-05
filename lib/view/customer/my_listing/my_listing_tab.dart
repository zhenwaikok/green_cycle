import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/item_listing/item_listing_model.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyListingTab extends StatelessWidget {
  const MyListingTab({
    super.key,
    this.onTap,
    this.onLongPress,
    required this.itemListingDetails,
    required this.isLoading,
  });

  final void Function()? onTap;
  final void Function()? onLongPress;
  final ItemListingModel itemListingDetails;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return getMyListingCard(itemListingDetails: itemListingDetails);
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on MyListingTab {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on MyListingTab {
  Widget getMyListingCard({required ItemListingModel itemListingDetails}) {
    return TouchableOpacity(
      onPressed: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: _Styles.cardPadding,
        child: CustomCard(
          padding: _Styles.customCardPadding,
          child: Skeletonizer(
            enabled: isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getStatus(
                  listingStatus: itemListingDetails.status ?? '',
                  createdDate: itemListingDetails.createdDate ?? DateTime.now(),
                ),
                SizedBox(height: 10),
                getProductDetails(
                  itemListingDetails: isLoading
                      ? ItemListingModel(
                          itemName: 'Loading...',
                          itemCategory: 'Loading...',
                          itemCondition: 'Loading...',
                        )
                      : itemListingDetails,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getStatus({
    required String listingStatus,
    required DateTime createdDate,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Status: $listingStatus', style: _Styles.greyTextStyle),
        Text(
          'Posted On: ${WidgetUtil.dateFormatter(createdDate)}',
          style: _Styles.greyTextStyle,
        ),
      ],
    );
  }

  Widget getProductDetails({required ItemListingModel itemListingDetails}) {
    return Row(
      children: [
        getProductImage(imageURL: itemListingDetails.itemImageURL?.first ?? ''),
        SizedBox(width: 15),
        Expanded(
          child: getProductDescription(
            itemName: itemListingDetails.itemName ?? '',
            category: itemListingDetails.itemCategory ?? '',
          ),
        ),
        SizedBox(width: 15),
        getProductStatusPrice(
          itemCondition: itemListingDetails.itemCondition ?? '',
          itemPrice: itemListingDetails.itemPrice ?? 0.0,
        ),
      ],
    );
  }

  Widget getProductImage({required String imageURL}) {
    return CustomImage(
      imageSize: _Styles.productImageSize,
      imageURL: imageURL,
      borderRadius: _Styles.imageBorderRadius,
    );
  }

  Widget getProductDescription({
    required String itemName,
    required String category,
  }) {
    return SizedBox(
      height: _Styles.productImageSize,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            itemName,
            style: _Styles.productNameTextStyle,
            maxLines: _Styles.maxNameTextLines,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            category,
            style: _Styles.categoryTextStyle,
            maxLines: _Styles.maxCategoryTextLines,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget getProductStatusPrice({
    required String itemCondition,
    required double itemPrice,
  }) {
    return SizedBox(
      height: _Styles.productImageSize,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomStatusBar(text: itemCondition),
          Text(
            'RM ${WidgetUtil.priceFormatter(itemPrice)}',
            style: _Styles.priceTextStyle,
          ),
        ],
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const productImageSize = 80.0;
  static const imageBorderRadius = 5.0;
  static const customCardPadding = EdgeInsets.all(10);
  static const cardPadding = EdgeInsets.symmetric(horizontal: 5, vertical: 10);
  static const maxNameTextLines = 2;
  static const maxCategoryTextLines = 1;

  static const productNameTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const categoryTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const greyTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const priceTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.redColor,
  );
}
