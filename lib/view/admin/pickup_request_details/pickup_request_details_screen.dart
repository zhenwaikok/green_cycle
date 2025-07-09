import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:green_cycle_fyp/widget/dot_indicator.dart';
import 'package:green_cycle_fyp/widget/image_slider.dart';

@RoutePage()
class PickupRequestDetailsScreen extends StatefulWidget {
  const PickupRequestDetailsScreen({super.key});

  @override
  State<PickupRequestDetailsScreen> createState() =>
      _PickupRequestDetailsScreenState();
}

class _PickupRequestDetailsScreenState
    extends State<PickupRequestDetailsScreen> {
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
      appBar: CustomAppBar(
        title: 'Request Details',
        isBackButtonVisible: true,
        onPressed: onBackButtonPressed,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: _Styles.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getRequestStatusAndRequestDetails(),
                SizedBox(height: 10),
                getImageSlider(),
                SizedBox(height: 10),
                getDotIndicator(),
                SizedBox(height: 20),
                getRequestDetails(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _PickupRequestDetailsScreenState {
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
extension _WidgetFactories on _PickupRequestDetailsScreenState {
  Widget getRequestStatusAndRequestDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomStatusBar(text: 'Accepted'),
        SizedBox(width: 40),
        Expanded(
          child: Text(
            'Requested by xxx',
            style: _Styles.smallGreyTextStyle,
            textAlign: TextAlign.right,
            maxLines: _Styles.maxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget getImageSlider() {
    return ImageSlider(
      items: imgItems,
      imageBorderRadius: _Styles.imageBorderRadius,
      carouselHeight: _Styles.carouselHeight,
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

  Widget getRequestDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Picked Up by xxx: 30/4/2025, 11:22 PM',
          style: _Styles.smallGreyTextStyle,
          textAlign: TextAlign.right,
          maxLines: _Styles.maxLines,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 15),
        getTitleDescription(title: 'Request ID', description: '#REQ13113'),
        getDivider(),
        getTitleDescription(
          title: 'Pickup Location',
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc varius urna eu ultricies egestas.',
        ),
        getDivider(),
        getTitleDescription(
          title: 'Pickup Time',
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc varius urna eu ultricies egestas.',
        ),
        getDivider(),
        getTitleDescription(
          title: 'Item Description',
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc varius urna eu ultricies egestas.',
        ),
        getDivider(),
        getTitleDescription(
          title: 'Category',
          description: 'Lorem ipsum dolor sit amet, consectetur',
        ),
        getDivider(),
        getTitleDescription(
          title: 'Quantity',
          description: 'Lorem ipsum dolor sit amet, consectetur',
        ),
        getDivider(),
        getTitleDescription(
          title: 'Condition & Usage Info',
          description: 'Lorem ipsum dolor sit amet, consectetur',
        ),
        getDivider(),
      ],
    );
  }

  Widget getTitleDescription({
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: _Styles.greenTextStyle),
        Text(
          description,
          style: _Styles.greyTextStyle,
          textAlign: TextAlign.justify,
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
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const maxLines = 1;

  static const imageBorderRadius = 10.0;
  static const carouselHeight = 180.0;
  static const indicatorRightPadding = 8.0;
  static const dotIndicatorSize = 10.0;

  static const dividerPadding = EdgeInsets.symmetric(vertical: 10);
  static const containerMargin = EdgeInsets.all(0);

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const greenTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const greyTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const smallGreyTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );
}
