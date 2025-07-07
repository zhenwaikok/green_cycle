import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';

@RoutePage()
class RequestSummaryScreen extends StatefulWidget {
  const RequestSummaryScreen({super.key});

  @override
  State<RequestSummaryScreen> createState() => _RequestSummaryScreenState();
}

class _RequestSummaryScreenState extends State<RequestSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Request Summary',
        isBackButtonVisible: true,
        onPressed: onBackButtonPressed,
      ),
      bottomNavigationBar: Padding(
        padding: _Styles.screenPadding,
        child: getConfirmRequestButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: _Styles.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getTitle(),
                SizedBox(height: 35),
                getPickupLocationSection(),
                SizedBox(height: 25),
                getPickupDateTimeSection(),
                SizedBox(height: 25),
                getItemDetailsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _RequestSummaryScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _RequestSummaryScreenState {
  Widget getTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Review Request', style: _Styles.titleTextStyle),
        Text(
          'Review your pickup request details before submitting. You can edit any section if needed.',
          style: _Styles.blackTextStyle,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget getPickupLocationSection() {
    return Column(
      children: [
        getSectionTitle(title: 'Pickup Location', onPressed: () {}),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc varius urna eu ultricies egestas.',
          style: _Styles.blackTextStyle,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget getPickupDateTimeSection() {
    return Column(
      children: [
        getSectionTitle(title: 'Pickup Date & Time', onPressed: () {}),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc varius urna eu ultricies egestas.',
          style: _Styles.blackTextStyle,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget getItemDetailsSection() {
    return Column(
      children: [
        getSectionTitle(title: 'Item Details', onPressed: () {}),
        SizedBox(height: 10),
        //TODO: Pass image list later
        Row(
          children: [
            ...List.generate(
              3,
              (index) => Padding(
                padding: _Styles.itemImagePadding,
                child: CustomImage(
                  imageSize: _Styles.itemImageSize,
                  borderRadius: _Styles.itemImageBorderRadius,
                  imageURL:
                      'https://thumbs.dreamstime.com/b/image-attractive-shopper-girl-dressed-casual-clothing-holding-paper-bags-standing-isolated-over-pyrple-iimage-attractive-150643339.jpg',
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        getItemDescription(),
      ],
    );
  }

  Widget getSectionTitle({
    required String title,
    required void Function() onPressed,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: _Styles.sectionTitleTextStyle),
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.edit,
            color: ColorManager.primary,
            size: _Styles.editIconSize,
          ),
        ),
      ],
    );
  }

  Widget getItemDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getItemDescriptionText(
          itemTitle: 'Item Description: ',
          itemDescription: 'xxxxx',
        ),
        SizedBox(height: 15),
        getItemDescriptionText(
          itemTitle: 'Category: ',
          itemDescription: 'xxxxx',
        ),
        SizedBox(height: 15),
        getItemDescriptionText(
          itemTitle: 'Quantity: ',
          itemDescription: 'xxxxx',
        ),
        SizedBox(height: 15),
        getItemDescriptionText(
          itemTitle: 'Condition & Usage Info: ',
          itemDescription: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
        ),
      ],
    );
  }

  Widget getItemDescriptionText({
    required String itemTitle,
    required String itemDescription,
  }) {
    return RichText(
      text: TextSpan(
        text: itemTitle,
        style: _Styles.blackTextStyle,
        children: [
          TextSpan(text: itemDescription, style: _Styles.greyTextStyle),
        ],
      ),
    );
  }

  Widget getConfirmRequestButton() {
    return CustomButton(
      text: 'Confirm Request',
      textColor: ColorManager.whiteColor,
      onPressed: () {},
      backgroundColor: ColorManager.primary,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const editIconSize = 25.0;
  static const itemImageSize = 100.0;
  static const itemImageBorderRadius = 10.0;

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const itemImagePadding = EdgeInsets.only(right: 10);

  static const titleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const blackTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const greyTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const sectionTitleTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );
}
