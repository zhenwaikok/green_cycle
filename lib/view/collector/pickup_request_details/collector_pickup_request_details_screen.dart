import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/constant/images_manager.dart';
import 'package:green_cycle_fyp/model/api_model/pickup_request/pickup_request_model.dart';
import 'package:green_cycle_fyp/model/api_model/user/user_model.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/pickup_request_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/background_service.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/location_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/notification_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/pickup_request_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:green_cycle_fyp/widget/dot_indicator.dart';
import 'package:green_cycle_fyp/widget/image_slider.dart';
import 'package:green_cycle_fyp/widget/profile_image.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class CollectorPickupRequestDetailsScreen extends StatelessWidget {
  const CollectorPickupRequestDetailsScreen({
    super.key,
    required this.pickupRequestID,
  });

  final String pickupRequestID;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        PickupRequestViewModel(
          pickupRequestRepository: PickupRequestRepository(),
          firebaseRepository: FirebaseRepository(
            firebaseServices: FirebaseServices(),
          ),
          userRepository: UserRepository(
            sharePreferenceHandler: SharedPreferenceHandler(),
            userServices: UserServices(),
          ),
        );
        UserViewModel(
          userRepository: UserRepository(
            sharePreferenceHandler: SharedPreferenceHandler(),
            userServices: UserServices(),
          ),
          firebaseRepository: FirebaseRepository(
            firebaseServices: FirebaseServices(),
          ),
        );
      },
      child: _CollectorPickupRequestDetailsScreen(
        pickupRequestID: pickupRequestID,
      ),
    );
  }
}

class _CollectorPickupRequestDetailsScreen extends BaseStatefulPage {
  const _CollectorPickupRequestDetailsScreen({required this.pickupRequestID});

  final String pickupRequestID;

  @override
  State<_CollectorPickupRequestDetailsScreen> createState() =>
      _CollectorPickupRequestDetailsScreenState();
}

class _CollectorPickupRequestDetailsScreenState
    extends BaseStatefulState<_CollectorPickupRequestDetailsScreen> {
  PickupRequestModel? pickupRequestDetails;
  int currentIndex = 0;
  bool isLoading = true;
  bool updateRequestStatus = false;
  final pickupRequestStatus = DropDownItems.requestDropdownItems;
  bool isCompleted = false;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    initialLoad();
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
  EdgeInsets bottomNavigationBarPadding() {
    if (isCompleted || pickupRequestDetails == null) {
      return EdgeInsets.zero;
    }
    return super.bottomNavigationBarPadding();
  }

  @override
  Widget bottomNavigationBar() {
    if (isLoading || pickupRequestDetails == null) {
      return SizedBox.shrink();
    }
    return getButtonBasedOnStatus(
      status: pickupRequestDetails?.pickupRequestStatus ?? '',
    );
  }

  @override
  Widget body() {
    pickupRequestDetails = context.select(
      (PickupRequestViewModel vm) => vm.pickupRequestDetails,
    );

    isCompleted =
        pickupRequestDetails?.pickupRequestStatus == pickupRequestStatus[5];

    final userDetails = context.select((UserViewModel vm) => vm.userDetails);
    final backgroundColor = WidgetUtil.getPickupRequestStatusColor(
      pickupRequestDetails?.pickupRequestStatus ?? '',
    );

    if (pickupRequestDetails == null || isLoading) {
      return SizedBox.shrink();
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getRequestIdAndStatus(
            pickupRequestID: pickupRequestDetails?.pickupRequestID ?? '',
            status: pickupRequestDetails?.pickupRequestStatus ?? '',
            backgroundColor: backgroundColor,
          ),
          SizedBox(height: 10),
          getImageSlider(
            imgItems: pickupRequestDetails?.pickupItemImageURL ?? [],
          ),
          SizedBox(height: 10),
          getDotIndicator(
            imgItems: pickupRequestDetails?.pickupItemImageURL ?? [],
          ),
          if (isCompleted) ...[
            SizedBox(height: 20),
            getCompletionDate(
              completedDate:
                  pickupRequestDetails?.completedDate ?? DateTime.now(),
            ),
          ],
          if (isCompleted) ...[
            SizedBox(height: 10),
          ] else ...[
            SizedBox(height: 20),
          ],
          getRequestDetails(
            pickupRequestDetails: pickupRequestDetails ?? PickupRequestModel(),
            userDetails: userDetails ?? UserModel(),
            isCompleted: isCompleted,
          ),
        ],
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CollectorPickupRequestDetailsScreenState {
  void onBackButtonPressed() {
    context.router.maybePop(updateRequestStatus);
  }

  void onImageChanged(int index, dynamic reason) {
    _setState(() {
      currentIndex = index;
    });
  }

  void onStatusButtonPressed({
    required PickupRequestModel pickupRequestDetails,
  }) {
    WidgetUtil.showAlertDialog(
      context,
      title: 'Pickup Request Confirmation',
      content: WidgetUtil.getAlertDialogContentLabel(
        pickupRequestDetails.pickupRequestStatus ?? '',
      ),
      actions: [
        (dialogContext) => getAlertDialogTextButton(
          onPressed: () {
            Navigator.of(dialogContext).pop();
          },
          text: 'No',
        ),
        (dialogContext) => getAlertDialogTextButton(
          onPressed: () async {
            Navigator.of(dialogContext).pop();
            onButtonPressed(pickupRequestDetails: pickupRequestDetails);
          },
          text: 'Yes',
        ),
      ],
    );
  }

  void onButtonPressed({required PickupRequestModel pickupRequestDetails}) {
    if (pickupRequestDetails.pickupRequestStatus == pickupRequestStatus[1]) {
      onAcceptPickupRequestPressed(pickupRequestDetails: pickupRequestDetails);
    } else if (pickupRequestDetails.pickupRequestStatus ==
        pickupRequestStatus[2]) {
      onOnMyWayPressed(pickupRequestDetails: pickupRequestDetails);
    } else if (pickupRequestDetails.pickupRequestStatus ==
        pickupRequestStatus[3]) {
      onArrivedPressed(pickupRequestDetails: pickupRequestDetails);
    } else if (pickupRequestDetails.pickupRequestStatus ==
        pickupRequestStatus[4]) {
      onCompletePickupPressed(pickupRequestDetails: pickupRequestDetails);
    } else {
      () {};
    }
  }

  void onOnMyWayPressed({
    required PickupRequestModel pickupRequestDetails,
  }) async {
    await updatePickupRequestStatus(
      pickupRequestDetails: pickupRequestDetails,
      pickupRequestStatus: pickupRequestStatus[3],
      acceptPickupRequest: false,
    );
    final result = mounted
        ? await tryLoad(
                context,
                () =>
                    context.read<LocationViewModel>().insertCollectorLocations(
                      collectorUserID:
                          pickupRequestDetails.collectorUserID ?? '',
                    ),
              ) ??
              false
        : false;

    if (result) {
      await initializeService();
      if (mounted) {
        await sendPushNotification(
          customerUserID: pickupRequestDetails.userID ?? '',
          title: 'Pickup Request',
          body: 'Your collector is on the way to your location.',
          pickupRequestID: pickupRequestDetails.pickupRequestID ?? '',
        );
        context.read<LocationViewModel>().startTrackingService(
          collectorUserID: pickupRequestDetails.collectorUserID ?? '',
        );
      }
    }
  }

  void onArrivedPressed({
    required PickupRequestModel pickupRequestDetails,
  }) async {
    await updatePickupRequestStatus(
      pickupRequestDetails: pickupRequestDetails,
      pickupRequestStatus: pickupRequestStatus[4],
      acceptPickupRequest: false,
    );
    await sendPushNotification(
      customerUserID: pickupRequestDetails.userID ?? '',
      title: 'Pickup Request',
      body: 'Your collector has arrived.',
      pickupRequestID: pickupRequestDetails.pickupRequestID ?? '',
    );
    if (mounted) {
      context.read<LocationViewModel>().stopBackgroundTrackingService();
    }
  }

  void onCompletePickupPressed({
    required PickupRequestModel pickupRequestDetails,
  }) async {
    final result = await context.router.push(
      CompletePickupRoute(pickupRequestDetails: pickupRequestDetails),
    );

    if (result == true && mounted) {
      _setState(() {
        updateRequestStatus = true;
      });
      await initialLoad();
    }
  }

  void onAcceptPickupRequestPressed({
    required PickupRequestModel pickupRequestDetails,
  }) async {
    await updatePickupRequestStatus(
      pickupRequestDetails: pickupRequestDetails,
      pickupRequestStatus: pickupRequestStatus[2],
      acceptPickupRequest: true,
    );
    await sendPushNotification(
      customerUserID: pickupRequestDetails.userID ?? '',
      title: 'Pickup Request',
      body: 'Your pickup request has been accepted.',
      pickupRequestID: pickupRequestDetails.pickupRequestID ?? '',
    );
  }

  Future<void> sendPushNotification({
    required String customerUserID,
    required String title,
    required String body,
    required String pickupRequestID,
  }) async {
    final fcmToken = await tryLoad(
      context,
      () => context.read<UserViewModel>().getFcmTokenWithUserID(
        userID: customerUserID,
      ),
    );

    if (mounted) {
      await tryCatch(
        context,
        () => context.read<NotificationViewModel>().sendPushNotification(
          fcmToken: fcmToken?.token ?? '',
          title: title,
          body: body,
          deeplink: 'request-details/$pickupRequestID',
        ),
      );
    }
  }

  Future<void> updatePickupRequestStatus({
    required PickupRequestModel pickupRequestDetails,
    required String pickupRequestStatus,
    required bool acceptPickupRequest,
  }) async {
    final result =
        await tryLoad(
          context,
          () => context.read<PickupRequestViewModel>().updatePickupRequest(
            pickupRequestDetails: pickupRequestDetails,
            pickupRequestStatus: pickupRequestStatus,
            isCollectorUpdate: true,
          ),
        ) ??
        false;

    if (result) {
      _setState(() {
        updateRequestStatus = true;
      });
      unawaited(
        WidgetUtil.showSnackBar(
          text: acceptPickupRequest
              ? 'You\'ve accepted the pickup request'
              : 'Updated successfully',
        ),
      );
      await initialLoad();
    }
  }

  Future<void> initialLoad() async {
    _setState(() {
      isLoading = true;
    });
    await tryLoad(
      context,
      () => context.read<PickupRequestViewModel>().getPickupRequestDetails(
        pickupRequestID: widget.pickupRequestID,
      ),
    );

    if (mounted) {
      await tryCatch(
        context,
        () => context.read<UserViewModel>().getUserDetails(
          userID: pickupRequestDetails?.userID ?? '',
          noNeedUpdateUserSharedPreference: true,
        ),
      );
    }

    _setState(() {
      isLoading = false;
    });
  }

  Future<void> onGoogleMapsPressed({
    required double latitude,
    required double longitude,
  }) async {
    final isAvailable = await MapLauncher.isMapAvailable(MapType.google);
    if (isAvailable == true) {
      await MapLauncher.showDirections(
        mapType: MapType.google,
        destination: Coords(latitude, longitude),
      );
    } else {
      if (Platform.isAndroid || Platform.isIOS) {
        final appId = Platform.isAndroid
            ? MapConstants.googleMapPlayStoreID
            : MapConstants.googleMapAppStoreID;
        final url = Uri.parse(
          Platform.isAndroid
              ? '${MapConstants.playStoreURL}$appId'
              : '${MapConstants.appStoreURL}$appId',
        );
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    }
  }

  Future<void> onWazePressed({
    required double latitude,
    required double longitude,
  }) async {
    final isAvailable = await MapLauncher.isMapAvailable(MapType.waze);
    if (isAvailable == true) {
      await MapLauncher.showDirections(
        mapType: MapType.waze,
        destination: Coords(latitude, longitude),
      );
    } else {
      if (Platform.isAndroid || Platform.isIOS) {
        final appId = Platform.isAndroid
            ? MapConstants.wazePlayStoreID
            : MapConstants.wazeAppStoreID;
        final url = Uri.parse(
          Platform.isAndroid
              ? '${MapConstants.playStoreURL}$appId'
              : '${MapConstants.appStoreURL}$appId',
        );
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    }
  }

  void onCallButtonPressed({required String phoneNum}) async {
    await WidgetUtil.dialPhoneNum(phoneNum: phoneNum);
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CollectorPickupRequestDetailsScreenState {
  Widget getRequestIdAndStatus({
    required String pickupRequestID,
    required String status,
    required Color backgroundColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('#$pickupRequestID', style: _Styles.greenTextStyle),
        CustomStatusBar(text: status, backgroundColor: backgroundColor),
      ],
    );
  }

  Widget getImageSlider({required List<String> imgItems}) {
    return ImageSlider(
      items: imgItems,
      imageBorderRadius: _Styles.sliderImageBorderRadius,
      carouselHeight: _Styles.carouselHeight,
      containerMargin: _Styles.containerMargin,
      onImageChanged: onImageChanged,
    );
  }

  Widget getDotIndicator({required List<String> imgItems}) {
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

  Widget getCompletionDate({required DateTime completedDate}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Completed on: ${WidgetUtil.dateTimeFormatter(completedDate)}',
          style: _Styles.smallGreyTextStyle,
        ),
      ],
    );
  }

  Widget getRequestDetails({
    required bool isCompleted,
    required PickupRequestModel pickupRequestDetails,
    required UserModel userDetails,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTitleDescription(
          title: 'Pickup Location',
          description: pickupRequestDetails.pickupLocation ?? '-',
        ),
        if (!isCompleted) ...[
          SizedBox(height: 15),
          getNavigationOptions(
            latitude: pickupRequestDetails.pickupLatitude ?? 0,
            longitude: pickupRequestDetails.pickupLongtitude ?? 0,
          ),
        ],
        getDivider(),
        getTitleDescription(
          title: 'Pickup Date & Time',
          description:
              '${WidgetUtil.dateFormatter(pickupRequestDetails.pickupDate ?? DateTime.now())}, ${pickupRequestDetails.pickupTimeRange}',
        ),
        getDivider(),
        getTitleDescription(
          title: 'Item Description',
          description: pickupRequestDetails.pickupItemDescription ?? '-',
        ),
        getDivider(),
        getTitleDescription(
          title: 'Category',
          description: pickupRequestDetails.pickupItemCategory ?? '-',
        ),
        getDivider(),
        getTitleDescription(
          title: 'Quantity',
          description: '${pickupRequestDetails.pickupItemQuantity ?? 0}',
        ),
        getDivider(),
        getTitleDescription(
          title: 'Condition & Usage Info',
          description: pickupRequestDetails.pickupItemCondition ?? '-',
        ),
        getDivider(),
        getRequestedBy(userDetails: userDetails, isCompleted: isCompleted),
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

  Widget getNavigationOptions({
    required double latitude,
    required double longitude,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: getNavigationButton(
            image: Images.wazeLogo,
            text: 'Waze',
            onPressed: () =>
                onWazePressed(latitude: latitude, longitude: longitude),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: getNavigationButton(
            image: Images.googleMapLogo,
            text: 'Google Map',
            onPressed: () =>
                onGoogleMapsPressed(latitude: latitude, longitude: longitude),
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

  Widget getRequestedBy({
    required UserModel userDetails,
    required bool isCompleted,
  }) {
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
              CustomProfileImage(
                imageSize: _Styles.imageSize,
                imageURL: userDetails.profileImageURL ?? '',
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${userDetails.firstName} ${userDetails.lastName}',
                      style: _Styles.usernameTextStyle,
                      maxLines: _Styles.maxTextLines,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      userDetails.phoneNumber ?? '',
                      style: _Styles.phoneNumTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (!isCompleted) ...[
                IconButton(
                  onPressed: () => onCallButtonPressed(
                    phoneNum: userDetails.phoneNumber ?? '',
                  ),
                  icon: Icon(
                    Icons.call,
                    color: ColorManager.primary,
                    size: _Styles.iconSize,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget getButtonBasedOnStatus({required String status}) {
    if (status == pickupRequestStatus[5]) {
      return SizedBox.shrink();
    }
    return CustomButton(
      text: WidgetUtil.getButtonLabel(status),
      textColor: ColorManager.whiteColor,
      onPressed: () => onStatusButtonPressed(
        pickupRequestDetails: pickupRequestDetails ?? PickupRequestModel(),
      ),
    );
  }

  Widget getAlertDialogTextButton({
    required void Function()? onPressed,
    required String text,
  }) {
    return TextButton(
      style: _Styles.textButtonStyle,
      onPressed: onPressed,
      child: Text(text, style: _Styles.textButtonTextStyle),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const imageSize = 70.0;
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

  static const smallGreyTextStyle = TextStyle(
    fontSize: 13,
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

  static final textButtonStyle = ButtonStyle(
    overlayColor: WidgetStateProperty.all(ColorManager.lightGreyColor2),
  );

  static const textButtonTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );
}
