import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:green_cycle_fyp/widget/dot_indicator.dart';
import 'package:green_cycle_fyp/widget/image_slider.dart';

@RoutePage()
class RequestDetailsScreen extends StatefulWidget {
  const RequestDetailsScreen({super.key});

  // TODO: Replace with actual request status later
  final bool isAccepted = true;

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
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
        actions: [getDeleteButton()],
      ),
      bottomNavigationBar: widget.isAccepted
          ? SafeArea(child: getTrackLocatorButton())
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: _Styles.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getRequestStatus(),
                SizedBox(height: 10),
                getImageSlider(),
                SizedBox(height: 10),
                getDotIndicator(),
                SizedBox(height: 20),
                getRequestDetails(),
                getNote(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _RequestDetailsScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  void onDeleteButtonPressed() {}

  void onImageChanged(int index, dynamic reason) {
    _setState(() {
      currentIndex = index;
    });
  }

  void onTrackButtonPressed() async {
    showModalBottomSheet(
      backgroundColor: ColorManager.whiteColor,
      context: context,
      builder: (context) {
        return getBottomSheet();
      },
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _RequestDetailsScreenState {
  Widget getDeleteButton() {
    return IconButton(
      onPressed: onDeleteButtonPressed,
      icon: Icon(Icons.delete, color: ColorManager.whiteColor),
    );
  }

  Widget getRequestStatus() {
    return CustomStatusBar(text: 'Accepted');
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

  Widget getNote() {
    return Text(
      '**Note: Tracking will be available once collector is on the way',
      style: _Styles.greyTextStyle,
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

  Widget getTrackLocatorButton() {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        boxShadow: [
          BoxShadow(
            color: ColorManager.blackColor.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: _Styles.screenPadding,
        child: CustomButton(
          text: 'Track Collector Location',
          textColor: ColorManager.whiteColor,
          onPressed: onTrackButtonPressed,
          backgroundColor: ColorManager.primary,
        ),
      ),
    );
  }

  Widget getBottomSheet() {
    return Padding(
      padding: _Styles.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getLocationTracking(),
          SizedBox(height: 20),
          getCollectorDetails(),
        ],
      ),
    );
  }

  Widget getLocationTracking() {
    return Column(
      children: [
        Text('Location Tracking', style: _Styles.greenTextStyle),
        //TODO: integrate google map
      ],
    );
  }

  Widget getCollectorDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Collector Details', style: _Styles.greenTextStyle),
        SizedBox(height: 20),
        Row(
          children: [
            CustomImage(
              borderRadius: _Styles.collectorImageBorderRadius,
              imageSize: _Styles.collectorImageSize,
              imageURL:
                  'https://img.freepik.com/free-photo/man-car-driving_23-2148889981.jpg?semt=ais_hybrid&w=740',
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Collector Name',
                    style: _Styles.collectorNameTextStyle,
                    maxLines: _Styles.maxTextLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Vehicle, WWN 2552',
                    style: _Styles.vehicleTextStyle,
                    maxLines: _Styles.maxTextLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.phone,
                color: ColorManager.primary,
                size: _Styles.dialButtonSize,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const imageBorderRadius = 10.0;
  static const carouselHeight = 180.0;
  static const indicatorRightPadding = 8.0;
  static const dotIndicatorSize = 10.0;
  static const collectorImageSize = 80.0;
  static const collectorImageBorderRadius = 50.0;
  static const dialButtonSize = 25.0;
  static const maxTextLines = 2;

  static const dividerPadding = EdgeInsets.symmetric(vertical: 10);
  static const containerMargin = EdgeInsets.symmetric(horizontal: 5);

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

  static const collectorNameTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const vehicleTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.greyColor,
  );
}
