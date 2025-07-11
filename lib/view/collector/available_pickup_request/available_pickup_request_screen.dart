import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_sort_by.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';

@RoutePage()
class AvailablePickupRequestScreen extends StatefulWidget {
  const AvailablePickupRequestScreen({super.key});

  @override
  State<AvailablePickupRequestScreen> createState() =>
      _AvailablePickupRequestScreenState();
}

class _AvailablePickupRequestScreenState
    extends State<AvailablePickupRequestScreen> {
  final List<String> sortByItems = [
    'All',
    'Nearest Distance',
    'Latest Request',
    'Soonest Time',
  ];

  String? selectedSort;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    selectedSort = sortByItems.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Available Pickup Requests',
        isBackButtonVisible: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: _Styles.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              getSortBy(),
              SizedBox(height: 20),
              Expanded(child: getAvailablePickupRequestList()),
            ],
          ),
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _AvailablePickupRequestScreenState {
  void onSortByChanged(String? value) {
    _setState(() {
      selectedSort = value;
    });
  }

  void onPickUpItemPressed() {
    context.router.push(CollectorPickupRequestDetailsRoute());
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _AvailablePickupRequestScreenState {
  Widget getSortBy() {
    return CustomSortBy(
      isExpanded: false,
      sortByItems: sortByItems,
      selectedValue: selectedSort,
      onChanged: onSortByChanged,
    );
  }

  Widget getAvailablePickupRequestList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return getAvailablePickupRequestItem();
      },
    );
  }

  Widget getAvailablePickupRequestItem() {
    return GestureDetector(
      onTap: onPickUpItemPressed,
      child: Padding(
        padding: _Styles.cardPadding,
        child: CustomCard(
          padding: _Styles.customCardPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              getDistance(),
              SizedBox(height: 15),
              getItemDetails(),
              getDivider(),
              getLocationAndTime(),
              SizedBox(height: 15),
              getButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getDistance() {
    return CustomStatusBar(text: '4.3 km away');
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

  Widget getLocationAndTime() {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: getLocationAndTimeItem(
              icon: Icons.pin_drop,
              text:
                  'No. 1, Jalan Balakong Jaya 1, 43300 Seri Kembangan, Selangor, Malaysia.\u00a0',
            ),
          ),
          VerticalDivider(
            color: ColorManager.greyColor,
            thickness: 1,
            width: 30,
          ),
          Expanded(
            child: getLocationAndTimeItem(
              icon: Icons.access_time_rounded,
              text: 'Tuesday, 29/4/2025, \n11AM - 1PM',
            ),
          ),
        ],
      ),
    );
  }

  Widget getLocationAndTimeItem({
    required IconData icon,
    required String text,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: ColorManager.blackColor, size: _Styles.iconSize),
        SizedBox(height: 10),
        Text(text, style: _Styles.greenTextStyle, textAlign: TextAlign.center),
      ],
    );
  }

  Widget getDivider() {
    return Padding(
      padding: _Styles.dividerPadding,
      child: Divider(color: ColorManager.lightGreyColor),
    );
  }

  Widget getButton() {
    return CustomButton(
      text: 'Accept Job',
      textColor: ColorManager.whiteColor,
      onPressed: () {},
      backgroundColor: ColorManager.primary,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const imageSize = 80.0;
  static const imageBorderRadius = 5.0;
  static const maxTextLines = 2;
  static const iconSize = 25.0;

  static const dividerPadding = EdgeInsets.symmetric(vertical: 10);

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );
  static const customCardPadding = EdgeInsets.all(10);

  static const cardPadding = EdgeInsets.symmetric(vertical: 10, horizontal: 5);

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

  static const greenTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.primary,
  );
}
