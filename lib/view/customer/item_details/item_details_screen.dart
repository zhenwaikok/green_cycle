import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:green_cycle_fyp/widget/dot_indicator.dart';
import 'package:green_cycle_fyp/widget/image_slider.dart';

@RoutePage()
class ItemDetailsScreen extends StatefulWidget {
  const ItemDetailsScreen({super.key});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  final List<String> imgItems = [
    'https://images.pexels.com/photos/1667088/pexels-photo-1667088.jpeg',
    'https://media.istockphoto.com/id/1181727539/photo/portrait-of-young-malaysian-man-behind-the-wheel.jpg?s=2048x2048&w=is&k=20&c=aVO02Y3tPJNKlQyv3ADJ6vm_Hp2LuXkLRSAClBznq3I=',
    'https://images.pexels.com/photos/1667088/pexels-photo-1667088.jpeg',
  ];

  int currentIndex = 0;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(child: getAddToCartButton()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                getItemImageSlider(),
                Positioned(top: 15, left: 15, child: getBackButton()),
              ],
            ),
            SizedBox(height: 10),
            getDotIndicator(),
            Padding(
              padding: _Styles.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getConditionAndPosted(),
                  SizedBox(height: 20),
                  getItemNamePrice(),
                  getDivider(),
                  getItemCategory(),
                  getDivider(),
                  getItemDescription(),
                  getDivider(),
                  getSellerDetails(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ItemDetailsScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  void onImageChanged(int index, dynamic reason) {
    _setState(() {
      currentIndex = index;
    });
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ItemDetailsScreenState {
  Widget getItemImageSlider() {
    return ImageSlider(
      items: imgItems,
      imageBorderRadius: 0,
      carouselHeight: _Styles.itemImageSize,
      containerMargin: _Styles.containerMargin,
      onImageChanged: onImageChanged,
    );
  }

  Widget getDotIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(
        imgItems.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: _Styles.indicatorRightPadding),
          child: DotIndicator(
            isActive: index == currentIndex,
            dotIndicatorSize: _Styles.dotIndicatorSize,
          ),
        ),
      ),
    );
  }

  Widget getBackButton() {
    return Container(
      width: _Styles.backButtonContainerSize,
      height: _Styles.backButtonContainerSize,
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
          onPressed: onBackButtonPressed,
        ),
      ),
    );
  }

  Widget getConditionAndPosted() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomStatusBar(text: 'Like New'),
        Text('Posted x days ago', style: _Styles.postedTextStyle),
      ],
    );
  }

  Widget getItemNamePrice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Product Name', style: _Styles.productNameTextStyle),
        SizedBox(height: 10),
        Text('RM xx.xx', style: _Styles.productPriceTextStyle),
      ],
    );
  }

  Widget getItemCategory() {
    return getTitleDescription(
      title: 'Category',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc varius urna eu ultricies egestas.',
    );
  }

  Widget getItemDescription() {
    return getTitleDescription(
      title: 'Description',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc varius urna eu ultricies egestas.',
    );
  }

  Widget getTitleDescription({
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: _Styles.titleTextStyle),
        Text(
          description,
          style: _Styles.descriptionTextStyle,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget getSellerDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Seller Info', style: _Styles.titleTextStyle),
        SizedBox(height: 10),
        getSellerInfoCard(),
      ],
    );
  }

  Widget getSellerInfoCard() {
    return CustomCard(
      needBoxShadow: false,
      backgroundColor: ColorManager.primaryLight,
      child: Row(
        children: [
          getSellerProfileImage(),
          SizedBox(width: 25),
          Expanded(child: getSellerNamePhoneNum()),
        ],
      ),
    );
  }

  Widget getSellerProfileImage() {
    return CustomImage(
      imageSize: _Styles.sellerImageSize,
      imageWidth: _Styles.sellerImageSize,
      borderRadius: _Styles.sellerBorderRadius,
      imageURL:
          'https://media.istockphoto.com/id/1181727539/photo/portrait-of-young-malaysian-man-behind-the-wheel.jpg?s=2048x2048&w=is&k=20&c=aVO02Y3tPJNKlQyv3ADJ6vm_Hp2LuXkLRSAClBznq3I=',
    );
  }

  Widget getSellerNamePhoneNum() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Seller Name',
          style: _Styles.sellerNameTextStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Icon(
              Icons.phone,
              size: _Styles.iconSize,
              color: ColorManager.blackColor,
            ),
            SizedBox(width: 8),
            Text('012-3456789', style: _Styles.sellerPhoneNumTextStyle),
          ],
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

  Widget getAddToCartButton() {
    return Padding(
      padding: _Styles.screenPadding,
      child: CustomButton(
        text: 'Add To Cart',
        textColor: ColorManager.whiteColor,
        onPressed: () {},
        backgroundColor: ColorManager.primary,
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const itemImageSize = 180.0;
  static const sellerImageSize = 80.0;
  static const sellerBorderRadius = 80.0;
  static const backButtonContainerSize = 50.0;
  static const iconSize = 20.0;
  static const dotIndicatorSize = 10.0;

  static const indicatorRightPadding = 8.0;

  static const dividerPadding = EdgeInsets.symmetric(vertical: 10);

  static const containerMargin = EdgeInsets.all(0);

  static const postedTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const productNameTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const productPriceTextStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.primary,
  );

  static const titleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const descriptionTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const sellerNameTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const sellerPhoneNumTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );
}
