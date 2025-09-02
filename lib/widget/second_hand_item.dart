import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SecondHandItem extends StatelessWidget {
  const SecondHandItem({
    super.key,
    required this.imageURL,
    required this.productName,
    required this.productPrice,
    required this.text,
    required this.isLoading,
  });

  final String imageURL;
  final String productName;
  final String productPrice;
  final String text;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return getSecondHandItem();
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on SecondHandItem {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on SecondHandItem {
  Widget getSecondHandItem() {
    return CustomCard(
      padding: _Styles.customCardPadding,
      child: Skeletonizer(
        enabled: isLoading,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getItemImage(),
            SizedBox(height: 10),
            Padding(
              padding: _Styles.productDetailsPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getItemStatus(text: text),
                  SizedBox(height: 10),
                  getItemDetails(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getItemImage() {
    return CustomImage(
      imageSize: _Styles.imageSize,
      imageWidth: double.infinity,
      imageURL: imageURL,
    );
  }

  Widget getItemStatus({required String text}) {
    return CustomStatusBar(text: text);
  }

  Widget getItemDetails() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productName,
          style: _Styles.productNameTextStyle,
          overflow: TextOverflow.ellipsis,
          maxLines: _Styles.maxTextLines,
        ),
        Text(productPrice, style: _Styles.productPriceTextStyle),
      ],
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const maxTextLines = 1;
  static const imageSize = 100.0;

  static const customCardPadding = EdgeInsetsGeometry.all(0);

  static const productDetailsPadding = EdgeInsetsGeometry.symmetric(
    horizontal: 10,
  );

  static const productNameTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const productPriceTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.redColor,
  );
}
