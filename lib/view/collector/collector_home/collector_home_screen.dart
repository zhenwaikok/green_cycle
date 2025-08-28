import 'dart:async';

import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/constant/images_manager.dart';
import 'package:green_cycle_fyp/model/api_model/pickup_request/pickup_request_model.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/pickup_request_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/pickup_request_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:green_cycle_fyp/widget/no_data_label.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class CollectorHomeScreen extends StatelessWidget {
  const CollectorHomeScreen({super.key});

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
      child: _CollectorHomeScreen(),
    );
  }
}

class _CollectorHomeScreen extends BaseStatefulPage {
  @override
  State<_CollectorHomeScreen> createState() => _CollectorHomeScreenState();
}

class _CollectorHomeScreenState
    extends BaseStatefulState<_CollectorHomeScreen> {
  bool isLoading = true;
  final pickupRequestStatus = DropDownItems.requestDropdownItems;

  void _setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    initialLoad();
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  EdgeInsets defaultPadding() {
    return EdgeInsets.zero;
  }

  @override
  Widget body() {
    final userVM = context.read<UserViewModel>();
    final collectorName = userVM.user?.fullName ?? '';
    final collectorUserID = userVM.user?.userID ?? '';
    final pickupRequestList = context.select(
      (PickupRequestViewModel vm) => vm.pickupRequestList,
    );

    final completedPickupRequest = completedTodayPickupRequest(
      pickupRequestList: pickupRequestList,
      collectorUserID: collectorUserID,
    );

    final availableRequest = availablePickupRequest(
      pickupRequestList: pickupRequestList,
      collectorUserID: collectorUserID,
    );

    final ongoingPickupRequestList = ongoingPickupRequest(
      pickupRequestList: pickupRequestList,
      collectorUserID: collectorUserID,
    ).take(5).toList();

    final loadingList = List.generate(
      5,
      (index) => PickupRequestModel(
        pickupRequestID: 'Loading...',
        pickupItemDescription: 'Loading...',
        pickupItemCategory: 'Loading...',
        pickupLocation: 'Loading...',
        pickupDate: DateTime.now(),
        pickupTimeRange: 'Loading...',
      ),
    );

    return AdaptiveWidgets.buildRefreshableScrollView(
      context,
      onRefresh: initialLoad,
      color: ColorManager.blackColor,
      refreshIndicatorBackgroundColor: ColorManager.whiteColor,
      slivers: [
        SliverMainAxisGroup(
          slivers: [
            SliverToBoxAdapter(
              child: getTopBarInfo(
                collectorName: collectorName,
                numberOfCompleted: completedPickupRequest.length,
              ),
            ),

            SliverPadding(
              padding: _Styles.screenPadding,
              sliver: SliverMainAxisGroup(
                slivers: [
                  SliverToBoxAdapter(child: SizedBox(height: 20)),
                  SliverToBoxAdapter(
                    child: Skeletonizer(
                      enabled: isLoading,
                      child: getAvailablePickupRequestSection(
                        numberOfAvailable: availableRequest.length,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 30)),
                  SliverToBoxAdapter(child: getOngoingPickupRequestSection()),
                  SliverToBoxAdapter(child: SizedBox(height: 10)),
                  if (ongoingPickupRequestList.isEmpty && !isLoading) ...[
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: NoDataAvailableLabel(
                          noDataText: 'No Ongoing Pickup Requests Found',
                        ),
                      ),
                    ),
                  ] else ...[
                    SliverToBoxAdapter(
                      child: getOngoingPickupRequestList(
                        ongoingPickupRequestList: isLoading
                            ? loadingList
                            : ongoingPickupRequestList,
                        isLoading: isLoading,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// * ---------------------------- Helpers ----------------------------
extension _Helpers on _CollectorHomeScreenState {
  List<PickupRequestModel> completedTodayPickupRequest({
    required List<PickupRequestModel> pickupRequestList,
    required String collectorUserID,
  }) {
    return pickupRequestList.where((request) {
      final completionDate = request.completedDate ?? DateTime.now();
      final todayDate = DateTime.now();

      final completionDateOnly = DateTime(
        completionDate.year,
        completionDate.month,
        completionDate.day,
      );

      final todayDateOnly = DateTime(
        todayDate.year,
        todayDate.month,
        todayDate.day,
      );

      return completionDateOnly.isAtSameMomentAs(todayDateOnly) &&
          request.collectorUserID == collectorUserID &&
          request.pickupRequestStatus == DropDownItems.requestDropdownItems[5];
    }).toList();
  }

  List<PickupRequestModel> availablePickupRequest({
    required List<PickupRequestModel> pickupRequestList,
    required String collectorUserID,
  }) {
    return pickupRequestList.where((request) {
      return request.pickupRequestStatus ==
          DropDownItems.requestDropdownItems[1];
    }).toList();
  }

  List<PickupRequestModel> ongoingPickupRequest({
    required List<PickupRequestModel> pickupRequestList,
    required String collectorUserID,
  }) {
    return pickupRequestList.where((request) {
      return (request.pickupRequestStatus ==
                  DropDownItems.requestDropdownItems[3] ||
              request.pickupRequestStatus ==
                  DropDownItems.requestDropdownItems[4]) &&
          request.collectorUserID == collectorUserID;
    }).toList();
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CollectorHomeScreenState {
  void onAvailablePickupRequestPressed() {
    AutoTabsRouter.of(context).setActiveIndex(1);
  }

  void onShowMoreButtonPressed() {
    AutoTabsRouter.of(context).setActiveIndex(2);
  }

  void onOngoingPickupRequestPressed({required String pickupRequestID}) async {
    final result = await context.router.push(
      CollectorPickupRequestDetailsRoute(pickupRequestID: pickupRequestID),
    );

    if (result == true && mounted) {
      initialLoad();
    }
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
    if (pickupRequestDetails.pickupRequestStatus == pickupRequestStatus[3]) {
      onArrivedPressed(pickupRequestDetails: pickupRequestDetails);
    } else if (pickupRequestDetails.pickupRequestStatus ==
        pickupRequestStatus[4]) {
      onCompletePickupPressed(pickupRequestDetails: pickupRequestDetails);
    } else {
      () {};
    }
  }

  void onArrivedPressed({
    required PickupRequestModel pickupRequestDetails,
  }) async {
    await updatePickupRequestStatus(
      pickupRequestDetails: pickupRequestDetails,
      pickupRequestStatus: pickupRequestStatus[4],
    );
  }

  void onCompletePickupPressed({
    required PickupRequestModel pickupRequestDetails,
  }) async {
    final result = await context.router.push(
      CompletePickupRoute(pickupRequestDetails: pickupRequestDetails),
    );

    if (result == true && mounted) {
      await initialLoad();
    }
  }

  Future<void> initialLoad() async {
    _setState(() {
      isLoading = true;
    });

    await tryCatch(
      context,
      () => context.read<PickupRequestViewModel>().getAllPickupRequests(),
    );
    _setState(() {
      isLoading = false;
    });
  }

  Future<void> updatePickupRequestStatus({
    required PickupRequestModel pickupRequestDetails,
    required String pickupRequestStatus,
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
      unawaited(WidgetUtil.showSnackBar(text: 'Updated successfully'));
      await initialLoad();
    } else {
      unawaited(
        WidgetUtil.showSnackBar(
          text:
              'Failed to update pickup request status, please try again later',
        ),
      );
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CollectorHomeScreenState {
  Widget getTopBarInfo({
    required String collectorName,
    required int numberOfCompleted,
  }) {
    return Container(
      width: double.infinity,
      height: _Styles.welcomeContainerHeight,
      decoration: BoxDecoration(color: ColorManager.primaryLight),
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: _Styles.rightPadding,
              child: Align(
                alignment: Alignment.centerLeft,
                child: getCollectorInfo(
                  collectorName: collectorName,
                  numberOfCompleted: numberOfCompleted,
                ),
              ),
            ),
          ),

          Positioned(
            right: -17,
            bottom: -6,
            child: Image.asset(
              Images.collectorImage,
              height: _Styles.collectorImageHeight,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget getCollectorInfo({
    required String collectorName,
    required int numberOfCompleted,
  }) {
    return Padding(
      padding: _Styles.collectorInfoPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomStatusBar(text: 'Welcome'),
              SizedBox(height: 5),
              Text(
                collectorName,
                style: _Styles.collectorNameTextStyle,
                maxLines: _Styles.max1Line,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Completed Today', style: _Styles.titleTextStyle),
              Text(
                numberOfCompleted <= 1
                    ? '$numberOfCompleted Request'
                    : '$numberOfCompleted Requests',
                style: _Styles.infoTextStyle,
                maxLines: _Styles.max1Line,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getAvailablePickupRequestSection({required int numberOfAvailable}) {
    return TouchableOpacity(
      onPressed: onAvailablePickupRequestPressed,
      child: CustomCard(
        padding: _Styles.customCardPadding,
        child: Row(
          children: [
            Image.asset(
              Images.ewasteItemImage,
              width: _Styles.ewasteItemImageSize,
              height: _Styles.ewasteItemImageSize,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                children: [
                  Text(
                    numberOfAvailable > 0
                        ? numberOfAvailable == 1
                              ? '$numberOfAvailable Available Pickup Request Found!'
                              : '$numberOfAvailable Available Pickup Requests Found!'
                        : 'No Available Pickup Request Found!',
                    style: _Styles.availablePickupTextStyle,
                  ),
                  Row(
                    children: [
                      Text('View Details', style: _Styles.titleTextStyle),
                      Icon(
                        Icons.keyboard_arrow_right_outlined,
                        color: ColorManager.primary,
                        size: _Styles.iconSize,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getOngoingPickupRequestSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ongoing Pickup Requests',
              style: _Styles.ongoingTitleTextStyle,
            ),
            TextButton(
              style: _Styles.showAllButtonStyle,
              onPressed: onShowMoreButtonPressed,
              child: Text(
                'See More',
                style: _Styles.moreTextStyle,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getOngoingPickupRequestList({
    required List<PickupRequestModel> ongoingPickupRequestList,
    required bool isLoading,
  }) {
    return SizedBox(
      height: _Styles.listHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: ongoingPickupRequestList.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: getPickupCard(
              pickupRequestDetails: ongoingPickupRequestList[index],
              isLoading: isLoading,
            ),
          );
        },
      ),
    );
  }

  Widget getPickupCard({
    required PickupRequestModel pickupRequestDetails,
    required bool isLoading,
  }) {
    return TouchableOpacity(
      onPressed: () => onOngoingPickupRequestPressed(
        pickupRequestID: pickupRequestDetails.pickupRequestID ?? '',
      ),
      child: Padding(
        padding: _Styles.cardPadding,
        child: CustomCard(
          padding: _Styles.onGoingPickupRequestCustomCardPadding,
          child: Skeletonizer(
            enabled: isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getRequestID(
                      pickupRequestID:
                          pickupRequestDetails.pickupRequestID ?? '',
                    ),
                    getRequestStatus(
                      pickupRequestStatus:
                          pickupRequestDetails.pickupRequestStatus ?? '',
                    ),
                  ],
                ),
                getDivider(),
                getItemDetails(pickupRequestDetails: pickupRequestDetails),
                getDivider(),
                getRequestDetails(
                  pickupLocation: pickupRequestDetails.pickupLocation ?? '',
                  pickupDate: pickupRequestDetails.pickupDate ?? DateTime.now(),
                  pickupTimeRange: pickupRequestDetails.pickupTimeRange ?? '',
                ),
                SizedBox(height: 20),
                getButton(pickupRequestDetails: pickupRequestDetails),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getRequestDetails({
    required String pickupLocation,
    required DateTime pickupDate,
    required String pickupTimeRange,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        getRequestDetailsText(
          icon: Icons.location_on,
          title: 'Pickup Location: ',
          text: pickupLocation,
        ),

        SizedBox(height: 10),

        getRequestDetailsText(
          icon: Icons.access_time,
          title: 'Pickup Date: ',
          text: '${WidgetUtil.dateFormatter(pickupDate)}, $pickupTimeRange',
          maxLines: 1,
        ),
      ],
    );
  }

  Widget getRequestDetailsText({
    required IconData icon,
    required String title,
    required String text,
    int? maxLines,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: ColorManager.blackColor,
          size: _Styles.onGoingPickupRequestIconSize,
        ),
        SizedBox(width: 5),
        Expanded(
          child: RichText(
            maxLines: maxLines ?? 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: title,
              style: _Styles.blackTextStyle,
              children: [TextSpan(text: text, style: _Styles.greyTextStyle)],
            ),
          ),
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

  Widget getRequestID({required String pickupRequestID}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Request ID', style: _Styles.requestIDTitleTextStyle),
        Text('#$pickupRequestID', style: _Styles.requestIDTextStyle),
      ],
    );
  }

  Widget getRequestStatus({required String pickupRequestStatus}) {
    final backgroundColor = WidgetUtil.getPickupRequestStatusColor(
      pickupRequestStatus,
    );

    return CustomStatusBar(
      text: pickupRequestStatus,
      backgroundColor: backgroundColor,
    );
  }

  Widget getItemDetails({required PickupRequestModel pickupRequestDetails}) {
    return Row(
      children: [
        getItemImage(
          imageURL: pickupRequestDetails.pickupItemImageURL?.first ?? '',
        ),
        SizedBox(width: 15),
        Expanded(
          child: getItemDescription(
            itemDescription: pickupRequestDetails.pickupItemDescription ?? '',
            itemCategory: pickupRequestDetails.pickupItemCategory ?? '',
            itemQuantity: pickupRequestDetails.pickupItemQuantity ?? 0,
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
                maxLines: _Styles.max2Lines,
                overflow: TextOverflow.ellipsis,
                style: _Styles.itemDescriptionTextStyle,
              ),
              Text(
                itemCategory,
                style: _Styles.itemDescriptionTextStyle,
                maxLines: _Styles.max1Line,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Text('Quantity: $itemQuantity', style: _Styles.quantityTextStyle),
        ],
      ),
    );
  }

  Widget getButton({required PickupRequestModel pickupRequestDetails}) {
    return CustomButton(
      text: WidgetUtil.getButtonLabel(
        pickupRequestDetails.pickupRequestStatus ?? '',
      ),
      textColor: ColorManager.whiteColor,
      onPressed: () =>
          onStatusButtonPressed(pickupRequestDetails: pickupRequestDetails),
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

  static const listHeight = 350.0;

  static const max1Line = 1;
  static const iconSize = 20.0;

  static const welcomeContainerHeight = 210.0;
  static const collectorImageHeight = 180.0;
  static const ewasteItemImageSize = 80.0;

  static const collectorInfoPadding = EdgeInsets.only(left: 15);
  static const rightPadding = EdgeInsets.only(
    right: 20 + _Styles.collectorImageHeight,
  );

  static const customCardPadding = EdgeInsets.all(10);

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const titleTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.primary,
  );

  static const collectorNameTextStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const infoTextStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const availablePickupTextStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const imageSize = 100.0;
  static const imageBorderRadius = 5.0;
  static const max2Lines = 2;
  static const onGoingPickupRequestIconSize = 15.0;

  static const dividerPadding = EdgeInsets.symmetric(vertical: 6);

  static const cardPadding = EdgeInsets.only(
    bottom: 10,
    top: 10,
    right: 20,
    left: 5,
  );
  static const onGoingPickupRequestCustomCardPadding = EdgeInsets.symmetric(
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

  static const blackTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const greyTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const ongoingTitleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static final showAllButtonStyle = ButtonStyle(
    overlayColor: WidgetStateProperty.all(Colors.transparent),
  );

  static const moreTextStyle = TextStyle(
    fontSize: 15,
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
