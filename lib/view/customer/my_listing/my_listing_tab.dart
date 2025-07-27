import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';

class MyListingTab extends StatelessWidget {
  const MyListingTab({
    super.key,
    required this.listingStatus,
    this.onTap,
    this.onLongPress,
  });

  final String listingStatus;
  final void Function()? onTap;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return getMyListingCard();
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on MyListingTab {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on MyListingTab {
  Widget getMyListingCard() {
    return TouchableOpacity(
      onPressed: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: _Styles.cardPadding,
        child: CustomCard(
          padding: _Styles.customCardPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [getStatus(), SizedBox(height: 10), getProductDetails()],
          ),
        ),
      ),
    );
  }

  Widget getStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Status: $listingStatus', style: _Styles.greyTextStyle),
        Text('Posted On: 24/7/2025', style: _Styles.greyTextStyle),
      ],
    );
  }

  Widget getProductDetails() {
    return Row(
      children: [
        getProductImage(),
        SizedBox(width: 15),
        Expanded(child: getProductDescription()),
        SizedBox(width: 15),
        getProductStatusPrice(),
      ],
    );
  }

  Widget getProductImage() {
    return CustomImage(
      imageSize: _Styles.productImageSize,
      imageURL:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      borderRadius: _Styles.imageBorderRadius,
    );
  }

  Widget getProductDescription() {
    return SizedBox(
      height: _Styles.productImageSize,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product Nasadasdsadasdasdasdasdasdme',
            style: _Styles.productNameTextStyle,
            maxLines: _Styles.maxTextLines,
            overflow: TextOverflow.ellipsis,
          ),
          Text('Category', style: _Styles.categoryTextStyle),
        ],
      ),
    );
  }

  Widget getProductStatusPrice() {
    return SizedBox(
      height: _Styles.productImageSize,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomStatusBar(text: 'Like new'),
          Text('RM xx.xx', style: _Styles.priceTextStyle),
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
  static const maxTextLines = 2;

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
