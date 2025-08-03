import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/pickup_request_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/pickup_request_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:green_cycle_fyp/widget/dot_indicator.dart';
import 'package:green_cycle_fyp/widget/image_slider.dart';
import 'package:provider/provider.dart';

@RoutePage()
class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({super.key, required this.pickupRequestID});

  final String pickupRequestID;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PickupRequestViewModel(
        firebaseRepository: FirebaseRepository(
          firebaseServices: FirebaseServices(),
        ),
        pickupRequestRepository: PickupRequestRepository(),
        userRepository: UserRepository(
          sharePreferenceHandler: SharedPreferenceHandler(),
          userServices: UserServices(),
        ),
      ),
      child: _RequestDetailsScreen(pickupRequestID: pickupRequestID),
    );
  }
}

class _RequestDetailsScreen extends BaseStatefulPage {
  const _RequestDetailsScreen({required this.pickupRequestID});
  final String pickupRequestID;

  @override
  State<_RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState
    extends BaseStatefulState<_RequestDetailsScreen> {
  int currentIndex = 0;
  bool isDelete = false;
  bool isAccepted = false;

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
      title: 'Request Details',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
      actions: [getDeleteButton()],
    );
  }

  @override
  Widget? bottomNavigationBar() {
    return isAccepted ? getTrackLocatorButton() : null;
  }

  @override
  bool bottomSafeAreaEnabled() {
    return false;
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  Widget body() {
    final pickupRequestDetails = context.select(
      (PickupRequestViewModel vm) => vm.pickupRequestDetails,
    );

    if (pickupRequestDetails == null) {
      return SizedBox.shrink();
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getRequestStatus(
            status: pickupRequestDetails.pickupRequestStatus ?? '',
          ),
          SizedBox(height: 10),
          getImageSlider(
            imgItems: pickupRequestDetails.pickupItemImageURL ?? [],
          ),
          SizedBox(height: 10),
          getDotIndicator(
            imgItems: pickupRequestDetails.pickupItemImageURL ?? [],
          ),
          SizedBox(height: 20),
          getRequestDetails(
            pickupRequestID: pickupRequestDetails.pickupRequestID ?? '',
            pickupLocation: pickupRequestDetails.pickupLocation ?? '',
            pickupDate: pickupRequestDetails.pickupDate ?? DateTime.now(),
            pickupTimeRange: pickupRequestDetails.pickupTimeRange ?? '',
            pickupItemDescription:
                pickupRequestDetails.pickupItemDescription ?? '',
            pickupItemCategory: pickupRequestDetails.pickupItemCategory ?? '',
            pickupItemQuantity: pickupRequestDetails.pickupItemQuantity ?? 0,
            pickupItemCondition: pickupRequestDetails.pickupItemCondition ?? '',
            pickupCreatedAt:
                pickupRequestDetails.requestedDate ?? DateTime.now(),
          ),
          if (isAccepted) ...[getNote()],
        ],
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _RequestDetailsScreenState {
  void onBackButtonPressed() {
    context.router.maybePop(isDelete);
  }

  void onDeleteButtonPressed() {
    WidgetUtil.showAlertDialog(
      context,
      title: 'Delete Confirmation',
      content: 'Are you sure you want to delete this pickup request?',
      actions: [
        getAlertDialogTextButton(onPressed: onBackButtonPressed, text: 'No'),
        getAlertDialogTextButton(
          onPressed: onYesAlertDialogPressed,
          text: 'Yes',
        ),
      ],
    );
  }

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
        return SingleChildScrollView(child: getBottomSheet());
      },
    );
  }

  Future<void> initialLoad() async {
    final vm = context.read<PickupRequestViewModel>();

    await tryLoad(
      context,
      () => vm.getPickupRequestDetails(pickupRequestID: widget.pickupRequestID),
    );

    _setState(() {
      isAccepted = vm.pickupRequestDetails?.pickupRequestStatus == 'Accepted';
    });
  }

  Future<void> onYesAlertDialogPressed() async {
    await context.router.maybePop();

    final result = mounted
        ? await tryLoad(
                context,
                () =>
                    context.read<PickupRequestViewModel>().deletePickupRequest(
                      pickupRequestID: widget.pickupRequestID,
                    ),
              ) ??
              false
        : false;

    if (result) {
      _setState(() {
        isDelete = true;
      });
      unawaited(
        WidgetUtil.showSnackBar(text: 'Pickup request deleted successfully'),
      );
      if (mounted) {
        await context.router.maybePop(isDelete);
      }
    } else {
      unawaited(
        WidgetUtil.showSnackBar(text: 'Failed to delete pickup request'),
      );
    }
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

  Widget getRequestStatus({required String status}) {
    Color color = WidgetUtil.getPickupRequestStatusColor(status);

    return CustomStatusBar(text: status, backgroundColor: color);
  }

  Widget getImageSlider({required List<String> imgItems}) {
    return ImageSlider(
      items: imgItems,
      imageBorderRadius: _Styles.imageBorderRadius,
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

  Widget getRequestDetails({
    required String pickupRequestID,
    required String pickupLocation,
    required DateTime pickupDate,
    required String pickupTimeRange,
    required String pickupItemDescription,
    required String pickupItemCategory,
    required int pickupItemQuantity,
    required String pickupItemCondition,
    required DateTime pickupCreatedAt,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTitleDescription(
          title: 'Request ID',
          description: '#$pickupRequestID',
        ),
        getDivider(),
        getTitleDescription(
          title: 'Pickup Location',
          description: pickupLocation,
        ),
        getDivider(),
        getTitleDescription(
          title: 'Pickup Date & Time',
          description:
              '${WidgetUtil.dateFormatter(pickupDate)}, $pickupTimeRange',
        ),
        getDivider(),
        getTitleDescription(
          title: 'Item Description',
          description: pickupItemDescription,
        ),
        getDivider(),
        getTitleDescription(title: 'Category', description: pickupItemCategory),
        getDivider(),
        getTitleDescription(
          title: 'Quantity',
          description: pickupItemQuantity.toString(),
        ),
        getDivider(),
        getTitleDescription(
          title: 'Condition & Usage Info',
          description: pickupItemCondition,
        ),
        getDivider(),
        getTitleDescription(
          title: 'Requested At',
          description: WidgetUtil.dateTimeFormatter(pickupCreatedAt),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Location Tracking', style: _Styles.greenTextStyle),
        //TODO: integrate google map
        SizedBox(height: 20),
        getGoogleMap(),
      ],
    );
  }

  Widget getGoogleMap() {
    return SizedBox(
      height: 400,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          //TODO: Change to current location of user later
          target: LatLng(3.0551, 101.7006),
          zoom: 18,
        ),
        markers: {
          Marker(
            markerId: MarkerId("currentLocation"),
            position: LatLng(3.0551, 101.7006),
            icon: BitmapDescriptor.defaultMarker,
          ),
        },
      ),
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

  static final textButtonStyle = ButtonStyle(
    overlayColor: WidgetStateProperty.all(ColorManager.lightGreyColor2),
  );

  static const textButtonTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );
}
