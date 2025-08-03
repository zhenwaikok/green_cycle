import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/constant/images_manager.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:green_cycle_fyp/widget/dot_indicator.dart';
import 'package:green_cycle_fyp/widget/image_slider.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class CollectorPickupRequestDetailsScreen extends StatelessWidget {
  const CollectorPickupRequestDetailsScreen({super.key, this.requestStatus});

  final String? requestStatus;

  @override
  Widget build(BuildContext context) {
    return _CollectorPickupRequestDetailsScreen(requestStatus: requestStatus);
  }
}

class _CollectorPickupRequestDetailsScreen extends BaseStatefulPage {
  const _CollectorPickupRequestDetailsScreen({this.requestStatus});

  final String? requestStatus;

  @override
  State<_CollectorPickupRequestDetailsScreen> createState() =>
      _CollectorPickupRequestDetailsScreenState();
}

class _CollectorPickupRequestDetailsScreenState
    extends BaseStatefulState<_CollectorPickupRequestDetailsScreen> {
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
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Pickup Request Details',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  Widget bottomNavigationBar() {
    return getButtonBasedOnStatus();
  }

  @override
  Widget body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getRequestIdAndStatus(),
          SizedBox(height: 10),
          getImageSlider(),
          SizedBox(height: 10),
          getDotIndicator(),
          SizedBox(height: 20),
          getRequestDetails(),
        ],
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CollectorPickupRequestDetailsScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  void onImageChanged(int index, dynamic reason) {
    _setState(() {
      currentIndex = index;
    });
  }

  Future<void> onGoogleMapsPressed() async {
    final isAvailable = await MapLauncher.isMapAvailable(MapType.google);
    if (isAvailable == true) {
      await MapLauncher.showDirections(
        mapType: MapType.google,
        destination: Coords(3.0551, 101.7006),
      );
    } else {
      if (Platform.isAndroid || Platform.isIOS) {
        final appId = Platform.isAndroid
            ? 'com.google.android.apps.maps'
            : '585027354';
        final url = Uri.parse(
          Platform.isAndroid
              ? 'https://play.google.com/store/apps/details?id=$appId'
              : 'https://apps.apple.com/app/id$appId',
        );
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    }
  }

  Future<void> onWazePressed() async {
    final isAvailable = await MapLauncher.isMapAvailable(MapType.waze);
    if (isAvailable == true) {
      await MapLauncher.showDirections(
        mapType: MapType.waze,
        destination: Coords(3.0551, 101.7006),
      );
    } else {
      if (Platform.isAndroid || Platform.isIOS) {
        final appId = Platform.isAndroid ? 'com.waze' : '323229106';
        final url = Uri.parse(
          Platform.isAndroid
              ? 'https://play.google.com/store/apps/details?id=$appId'
              : 'https://apps.apple.com/app/id$appId',
        );
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    }
  }

  void Function() onButtonPressed(String status) {
    return switch (status) {
      'Accepted' => onOnMyWayPressed,
      'Ongoing' => onArrivedPressed,
      'Arrived' => onCompletePickupPressed,
      _ => onAcceptPickupRequestPressed,
    };
  }

  void onOnMyWayPressed() {
    // Update status to "Ongoing"
  }

  void onArrivedPressed() {
    // Update status to "Arrived"
  }

  void onCompletePickupPressed() {
    context.router.push(CompletePickupRoute());
  }

  void onAcceptPickupRequestPressed() {
    // Assign pickup to this collector
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CollectorPickupRequestDetailsScreenState {
  Widget getRequestIdAndStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('#REQ13113', style: _Styles.greenTextStyle),
        CustomStatusBar(text: 'Accepted'),
      ],
    );
  }

  Widget getImageSlider() {
    return ImageSlider(
      items: imgItems,
      imageBorderRadius: _Styles.sliderImageBorderRadius,
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
        getTitleDescription(
          title: 'Pickup Location',
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc varius urna eu ultricies egestas.',
        ),
        SizedBox(height: 15),
        getNavigationOptions(),
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
        getRequestedBy(),
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

  Widget getNavigationOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: getNavigationButton(
            image: Images.wazeLogo,
            text: 'Waze',
            onPressed: onWazePressed,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: getNavigationButton(
            image: Images.googleLogo,
            text: 'Google Map',
            onPressed: onGoogleMapsPressed,
          ),
        ),
      ],
    );
  }

  Widget getNavigationButton({
    required String image,
    required String text,
    required void Function() onPressed,
  }) {
    return CustomButton(
      text: text,
      textColor: ColorManager.blackColor,
      onPressed: onPressed,
      image: image,
      borderColor: ColorManager.blackColor,
      backgroundColor: ColorManager.whiteColor,
    );
  }

  Widget getDivider() {
    return Padding(
      padding: _Styles.dividerPadding,
      child: Divider(color: ColorManager.lightGreyColor),
    );
  }

  Widget getRequestedBy() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Requested By', style: _Styles.greenTextStyle),
        SizedBox(height: 15),
        CustomCard(
          needBoxShadow: false,
          backgroundColor: ColorManager.primaryLight,
          child: Row(
            children: [
              CustomImage(
                imageSize: _Styles.imageSize,
                borderRadius: _Styles.imageBorderRadius,
                imageURL:
                    'https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D',
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      style: _Styles.usernameTextStyle,
                      maxLines: _Styles.maxTextLines,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '01563365555',
                      style: _Styles.phoneNumTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.call,
                  color: ColorManager.primary,
                  size: _Styles.iconSize,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getButtonBasedOnStatus() {
    return CustomButton(
      text: getButtonLabel(widget.requestStatus ?? ''),
      textColor: ColorManager.whiteColor,
      onPressed: onButtonPressed(widget.requestStatus ?? ''),
    );
  }

  String getButtonLabel(String status) {
    return switch (status) {
      'Accepted' => 'On My Way',
      'Ongoing' => 'Arrived',
      'Arrived' => 'Complete Pickup',
      _ => 'Accept Pickup Request',
    };
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const imageSize = 70.0;
  static const imageBorderRadius = 40.0;
  static const sliderImageBorderRadius = 10.0;
  static const carouselHeight = 180.0;
  static const indicatorRightPadding = 8.0;
  static const dotIndicatorSize = 10.0;
  static const iconSize = 25.0;
  static const maxTextLines = 2;

  static const dividerPadding = EdgeInsets.symmetric(vertical: 10);
  static const containerMargin = EdgeInsets.symmetric(horizontal: 5);

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

  static const usernameTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const phoneNumTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );
}
