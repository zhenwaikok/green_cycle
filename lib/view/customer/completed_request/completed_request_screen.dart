import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_date_filter.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/search_bar.dart';

@RoutePage()
class CompletedRequestScreen extends StatelessWidget {
  const CompletedRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _CompletedRequestScreen();
  }
}

class _CompletedRequestScreen extends BaseStatefulPage {
  @override
  State<_CompletedRequestScreen> createState() =>
      _CompletedRequestScreenState();
}

class _CompletedRequestScreenState
    extends BaseStatefulState<_CompletedRequestScreen> {
  DateTimeRange? selectedRange;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Completed Request',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  Widget body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSearchBar(hintText: 'Search request here'),
        SizedBox(height: 20),
        CustomDateRangeFilter(
          selectedRange: selectedRange,
          onDateRangeChanged: onDateRangeChanged,
        ),
        SizedBox(height: 30),
        Expanded(child: getCompletedRequestList()),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CompletedRequestScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  void onDateRangeChanged(DateTimeRange range) {
    _setState(() {
      selectedRange = range;
    });
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CompletedRequestScreenState {
  Widget getCompletedRequestList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return getCompletedRequestCard();
      },
    );
  }

  Widget getCompletedRequestCard() {
    return Padding(
      padding: _Styles.cardPadding,
      child: CustomCard(
        padding: _Styles.customCardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getRequestID(),
            getDivider(),
            getItemDetails(),
            getDivider(),
            getCompletedDetails(),
          ],
        ),
      ),
    );
  }

  Widget getCompletedDetails() {
    return Text(
      'Completed: 29/4/2025, 11:22 PM',
      style: _Styles.completedTextStyle,
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
  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

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
