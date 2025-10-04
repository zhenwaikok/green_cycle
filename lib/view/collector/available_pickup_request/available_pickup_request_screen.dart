import 'dart:async';

import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/pickup_request/pickup_request_model.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/location_repository.dart';
import 'package:green_cycle_fyp/repository/pickup_request_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
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
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_sort_by.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:green_cycle_fyp/widget/no_data_label.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class AvailablePickupRequestScreen extends StatelessWidget {
  const AvailablePickupRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        PickupRequestViewModel(
          firebaseRepository: FirebaseRepository(
            firebaseServices: FirebaseServices(),
          ),
          pickupRequestRepository: PickupRequestRepository(),
          userRepository: UserRepository(
            sharePreferenceHandler: SharedPreferenceHandler(),
            userServices: UserServices(),
          ),
        );
        LocationViewModel(locationRepository: LocationRepository());
      },
      child: _AvailablePickupRequestScreen(),
    );
  }
}

class _AvailablePickupRequestScreen extends BaseStatefulPage {
  @override
  State<_AvailablePickupRequestScreen> createState() =>
      _AvailablePickupRequestScreenState();
}

class _AvailablePickupRequestScreenState
    extends BaseStatefulState<_AvailablePickupRequestScreen> {
  final sortByItems = DropDownItems.availablePickupRequestSortByItems;
  String? selectedSort;
  bool isLoading = true;
  LatLng? collectorLatLng;
  Map<String, int> requestDistance = {};

  late final tabsRouter = AutoTabsRouter.of(context);

  @override
  void didChangeDependencies() {
    tabsRouter.addListener(_onTabChanged);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    tabsRouter.removeListener(_onTabChanged);
  }

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    setUp();
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Available Pickup Requests',
      isBackButtonVisible: false,
    );
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  Widget body() {
    final availablePickupRequestList = context.select(
      (PickupRequestViewModel vm) => vm.pickupRequestList
          .where((request) => request.pickupRequestStatus == 'Pending')
          .toList(),
    );

    final loadingList = List.generate(
      5,
      (_) => PickupRequestModel(
        pickupItemDescription: 'Loading...',
        pickupItemCategory: 'Loading...',
        pickupLocation: 'Loading...',
        pickupDate: DateTime.now(),
        pickupTimeRange: 'Loading...',
      ),
    );

    sortAvailablePickupRequestList(
      availablePickupRequestList: availablePickupRequestList,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        getSortBy(),
        SizedBox(height: 20),
        Expanded(
          child: AdaptiveWidgets.buildRefreshableScrollView(
            context,
            onRefresh: setUp,
            color: ColorManager.blackColor,
            refreshIndicatorBackgroundColor: ColorManager.whiteColor,
            slivers: [
              ...getCompletedRequestList(
                availablePickupRequestList: isLoading
                    ? loadingList
                    : availablePickupRequestList,
                isLoading: isLoading,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _AvailablePickupRequestScreenState {
  void _onTabChanged() {
    if (tabsRouter.activeIndex == 1) {
      _setState(() {
        selectedSort = sortByItems.first;
      });
    }
  }

  void onSortByChanged(String? value) {
    _setState(() {
      selectedSort = value;
    });
  }

  void onPickUpItemPressed({required String pickupRequestID}) async {
    final result = await context.router.push(
      CollectorPickupRequestDetailsRoute(pickupRequestID: pickupRequestID),
    );

    if (result == true && mounted) {
      await setUp();
    }
  }

  void onAcceptJobButtonPressed({
    required PickupRequestModel pickupRequestDetails,
  }) async {
    final isCollectorProfileApproved = await checkIfCollectorProfileApproved();

    if (!isCollectorProfileApproved) {
      if (mounted) {
        WidgetUtil.showAlertDialog(
          context,
          title: 'Account Approval',
          content:
              'Your account is still under review or not approved so you cannot accept this pickup request.',
          actions: [
            (dialogContext) => getAlertDialogTextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              text: 'OK',
            ),
          ],
        );
      }
    } else {
      if (mounted) {
        WidgetUtil.showAlertDialog(
          context,
          title: 'Accept Confirmation',
          content: 'Are you sure to accept this pickup request?',
          actions: [
            (dialogContext) => getAlertDialogTextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              text: 'No',
            ),
            (dialogContext) => getAlertDialogTextButton(
              onPressed: () => acceptPickuprequest(
                pickupRequestDetails: pickupRequestDetails,
              ),
              text: 'Yes',
            ),
          ],
        );
      }
    }
  }

  Future<void> acceptPickuprequest({
    required PickupRequestModel pickupRequestDetails,
  }) async {
    await context.router.maybePop();

    if (mounted) {
      final result =
          await tryLoad(
            context,
            () => context.read<PickupRequestViewModel>().updatePickupRequest(
              pickupRequestDetails: pickupRequestDetails,
              pickupRequestStatus: 'Accepted',
              isCollectorUpdate: true,
            ),
          ) ??
          false;

      if (result) {
        unawaited(
          WidgetUtil.showSnackBar(
            text: 'You have accepted this pickup request.',
          ),
        );

        await sendPushNotification(
          customerUserID: pickupRequestDetails.userID ?? '',
          title: 'Pickup Request',
          body: 'Your pickup request has been accepted.',
          pickupRequestID: pickupRequestDetails.pickupRequestID ?? '',
        );

        await setUp();
      }
    }
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

  Future<bool> checkIfCollectorProfileApproved() async {
    final userVM = context.read<UserViewModel>();
    final userID = userVM.user?.userID ?? '';
    await tryCatch(
      context,
      () => userVM.getUserDetails(
        userID: userID,
        noNeedUpdateUserSharedPreference: true,
      ),
    );

    return userVM.userDetails?.approvalStatus == 'Approved';
  }

  Future<void> setUp() async {
    _setState(() {
      isLoading = true;
      selectedSort = sortByItems.first;
    });
    await getCollectorCurrentLocation();
    await fetchData();
    _setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchData() async {
    final pickupRequestVM = context.read<PickupRequestViewModel>();
    final locationVM = context.read<LocationViewModel>();
    final collectorLocation = collectorLatLng ?? LatLng(0, 0);

    await tryCatch(context, () => pickupRequestVM.getAllPickupRequests());

    if (collectorLatLng != LatLng(0, 0)) {
      for (var request in pickupRequestVM.pickupRequestList) {
        final pickupRequestID = request.pickupRequestID ?? '';

        final destinationLocation = LatLng(
          request.pickupLatitude ?? 0,
          request.pickupLongtitude ?? 0,
        );

        if (mounted) {
          final distance = await tryCatch(
            context,
            () => locationVM.calculateDistance(
              originLatLng: collectorLocation,
              destinationLatLng: destinationLocation,
            ),
          );

          requestDistance[pickupRequestID] = distance ?? 0;
        }
      }
    } else {
      WidgetUtil.showSnackBar(
        text: 'Enable GPS to check which pickup request near you',
      );
    }
  }

  Future<void> getCollectorCurrentLocation() async {
    Position? position = await tryCatch(
      context,
      () => context.read<LocationViewModel>().currentLocation(),
    );

    _setState(() {
      collectorLatLng = LatLng(
        position?.latitude ?? 0,
        position?.longitude ?? 0,
      );
    });
  }

  void sortAvailablePickupRequestList({
    required List<PickupRequestModel> availablePickupRequestList,
  }) {
    if (selectedSort == sortByItems[1]) {
      availablePickupRequestList.sort((a, b) {
        final distanceA = requestDistance[a.pickupRequestID] ?? 0;
        final distanceB = requestDistance[b.pickupRequestID] ?? 0;
        return distanceA.compareTo(distanceB);
      });
    } else if (selectedSort == sortByItems[2]) {
      availablePickupRequestList.sort(
        (a, b) => (a.requestedDate ?? DateTime.now()).compareTo(
          b.requestedDate ?? DateTime.now(),
        ),
      );
    } else if (selectedSort == sortByItems[3]) {
      availablePickupRequestList.sort((a, b) {
        final pickupDateTimeA = WidgetUtil.getEarliestPickupDateTime(
          date: a.pickupDate ?? DateTime.now(),
          timeRange: a.pickupTimeRange ?? '',
        );
        final pickupDateTimeB = WidgetUtil.getEarliestPickupDateTime(
          date: b.pickupDate ?? DateTime.now(),
          timeRange: b.pickupTimeRange ?? '',
        );

        return pickupDateTimeA.compareTo(pickupDateTimeB);
      });
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _AvailablePickupRequestScreenState {
  Widget getSortBy() {
    return CustomSortBy(
      sortByItems: sortByItems,
      selectedValue: selectedSort,
      onChanged: onSortByChanged,
    );
  }

  List<Widget> getCompletedRequestList({
    required List<PickupRequestModel> availablePickupRequestList,
    required bool isLoading,
  }) {
    if (availablePickupRequestList.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: NoDataAvailableLabel(
              noDataText: 'No Available Pickup Requests Found',
            ),
          ),
        ),
      ];
    } else {
      return [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return getAvailablePickupRequestItem(
              request: availablePickupRequestList[index],
              isLoading: isLoading,
            );
          }, childCount: availablePickupRequestList.length),
        ),
      ];
    }
  }

  Widget getAvailablePickupRequestItem({
    required PickupRequestModel request,
    required bool isLoading,
  }) {
    final distance = WidgetUtil.distanceFormatter(
      requestDistance[request.pickupRequestID] ?? 0,
    );

    return TouchableOpacity(
      isLoading: isLoading,
      onPressed: () =>
          onPickUpItemPressed(pickupRequestID: request.pickupRequestID ?? ''),
      child: Padding(
        padding: _Styles.cardPadding,
        child: CustomCard(
          padding: _Styles.customCardPadding,
          child: Skeletonizer(
            enabled: isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                getDistance(distance: '$distance away'),
                SizedBox(height: 15),
                getItemDetails(
                  imageURL: request.pickupItemImageURL?.first ?? '',
                  itemDescription: request.pickupItemDescription ?? '',
                  itemCategory: request.pickupItemCategory ?? '',
                  itemQuantity: request.pickupItemQuantity ?? 0,
                ),
                getDivider(),
                getLocationAndTime(
                  location: request.pickupLocation ?? '',
                  pickupDate: request.pickupDate ?? DateTime.now(),
                  pickupTimeRange: request.pickupTimeRange ?? '',
                ),
                SizedBox(height: 15),
                getButton(pickupRequestDetails: request),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getDistance({required String distance}) {
    return CustomStatusBar(text: distance);
  }

  Widget getItemDetails({
    required String imageURL,
    required String itemDescription,
    required String itemCategory,
    required int itemQuantity,
  }) {
    return Row(
      children: [
        getItemImage(imageURL: imageURL),
        SizedBox(width: 15),
        Expanded(
          child: getItemDescription(
            itemDescription: itemDescription,
            itemCategory: itemCategory,
            itemQuantity: itemQuantity,
          ),
        ),
      ],
    );
  }

  Widget getItemImage({required String imageURL}) {
    return CustomImage(
      imageSize: _Styles.imageSize,
      imageURL: imageURL,
      borderRadius: _Styles.imageBorderRadius,
    );
  }

  Widget getItemDescription({
    required String itemDescription,
    required String itemCategory,
    required int itemQuantity,
  }) {
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
                itemDescription,
                maxLines: _Styles.maxTextLines,
                overflow: TextOverflow.ellipsis,
                style: _Styles.itemDescriptionTextStyle,
              ),
              Text(itemCategory, style: _Styles.itemDescriptionTextStyle),
            ],
          ),
          Text('Quantity: $itemQuantity', style: _Styles.quantityTextStyle),
        ],
      ),
    );
  }

  Widget getLocationAndTime({
    required String location,
    required DateTime pickupDate,
    required String pickupTimeRange,
  }) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: getLocationAndTimeItem(icon: Icons.pin_drop, text: location),
          ),
          VerticalDivider(
            color: ColorManager.greyColor,
            thickness: 1,
            width: 30,
          ),
          Expanded(
            child: getLocationAndTimeItem(
              icon: Icons.access_time_rounded,
              text:
                  '${WidgetUtil.dateFormatter(pickupDate)}, \n$pickupTimeRange',
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

  Widget getButton({required PickupRequestModel pickupRequestDetails}) {
    return CustomButton(
      text: 'Accept Job',
      textColor: ColorManager.whiteColor,
      onPressed: () =>
          onAcceptJobButtonPressed(pickupRequestDetails: pickupRequestDetails),
      backgroundColor: ColorManager.primary,
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

  static const imageSize = 80.0;
  static const imageBorderRadius = 5.0;
  static const maxTextLines = 2;
  static const iconSize = 25.0;

  static const dividerPadding = EdgeInsets.symmetric(vertical: 10);

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

  static final textButtonStyle = ButtonStyle(
    overlayColor: WidgetStateProperty.all(ColorManager.lightGreyColor2),
  );

  static const textButtonTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );
}
