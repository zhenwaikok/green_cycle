import 'dart:async';
import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/pickup_request/pickup_request_model.dart';
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
import 'package:green_cycle_fyp/view/collector/my_pickup/my_pickup_tab.dart';
import 'package:green_cycle_fyp/viewmodel/location_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/notification_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/pickup_request_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_tab_bar.dart';
import 'package:green_cycle_fyp/widget/no_data_label.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';

@RoutePage()
class MyPickupScreen extends StatelessWidget {
  const MyPickupScreen({super.key});

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
      child: _MyPickupScreen(),
    );
  }
}

class _MyPickupScreen extends BaseStatefulPage {
  @override
  State<_MyPickupScreen> createState() => _MyPickupScreenState();
}

class _MyPickupScreenState extends BaseStatefulState<_MyPickupScreen> {
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
    fetchData();
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(title: 'My Pickup', isBackButtonVisible: false);
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  Widget body() {
    final collectorUserID = context.read<PickupRequestViewModel>().user?.userID;

    final pickupRequestList = context.select(
      (PickupRequestViewModel vm) => vm.pickupRequestList
          .where((request) => request.collectorUserID == collectorUserID)
          .toList(),
    );

    final ongoingPickupRequestList = pickupRequestList.where((request) {
      return request.pickupRequestStatus != pickupRequestStatus[1] &&
          request.pickupRequestStatus != pickupRequestStatus[2] &&
          request.pickupRequestStatus != pickupRequestStatus[5];
    }).toList();

    final upcomingPickupRequestList = pickupRequestList
        .where(
          (request) => request.pickupRequestStatus == pickupRequestStatus[2],
        )
        .toList();

    final loadingPickupRequestList = List.generate(
      5,
      (_) => PickupRequestModel(
        pickupRequestID: 'Loading...',
        pickupItemDescription: 'Loading...',
        pickupItemCategory: 'Loading...',
      ),
    );

    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          getTabBar(),
          SizedBox(height: 10),
          Expanded(
            child: TabBarView(
              children: [
                buildTabContent(
                  pickupRequestList: isLoading
                      ? loadingPickupRequestList
                      : ongoingPickupRequestList,
                ),
                buildTabContent(
                  pickupRequestList: isLoading
                      ? loadingPickupRequestList
                      : upcomingPickupRequestList,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _MyPickupScreenState {
  void onRequestCardPressed({required String pickupRequestID}) async {
    final result = await context.router.push(
      CollectorPickupRequestDetailsRoute(pickupRequestID: pickupRequestID),
    );

    if (result == true && mounted) {
      await fetchData();
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
        getAlertDialogTextButton(
          onPressed: () {
            context.router.maybePop();
          },
          text: 'No',
        ),
        getAlertDialogTextButton(
          onPressed: () async {
            await context.router.maybePop();
            onButtonPressed(pickupRequestDetails: pickupRequestDetails);
          },
          text: 'Yes',
        ),
      ],
    );
  }

  void onButtonPressed({required PickupRequestModel pickupRequestDetails}) {
    if (pickupRequestDetails.pickupRequestStatus == pickupRequestStatus[2]) {
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
      await sendPushNotification(
        customerUserID: pickupRequestDetails.userID ?? '',
        title: 'Pickup Request',
        body: 'Your collector is on the way to your location.',
        pickupRequestID: pickupRequestDetails.pickupRequestID ?? '',
      );
      await initializeService();
      if (mounted) {
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
      await fetchData();
    }
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
      await fetchData();
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

  Future<void> fetchData() async {
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
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _MyPickupScreenState {
  Widget getTabBar() {
    return CustomTabBar(tabs: [Text('Ongoing'), Text('Upcoming')]);
  }

  Widget buildTabContent({
    required List<PickupRequestModel> pickupRequestList,
  }) {
    return AdaptiveWidgets.buildRefreshableScrollView(
      context,
      onRefresh: fetchData,
      refreshIndicatorBackgroundColor: ColorManager.whiteColor,
      color: ColorManager.blackColor,
      slivers: getRequestList(pickupRequestList: pickupRequestList),
    );
  }

  List<Widget> getRequestList({
    required List<PickupRequestModel> pickupRequestList,
  }) {
    if (pickupRequestList.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: NoDataAvailableLabel(noDataText: 'No Pickup Requests Found'),
          ),
        ),
      ];
    } else {
      return [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final pickupRequestDetails = pickupRequestList[index];
            return TouchableOpacity(
              onPressed: () => onRequestCardPressed(
                pickupRequestID: pickupRequestDetails.pickupRequestID ?? '',
              ),
              child: MyPickupTab(
                onPressed: () => onStatusButtonPressed(
                  pickupRequestDetails: pickupRequestDetails,
                ),
                pickupRequestDetails: pickupRequestDetails,
                isLoading: isLoading,
              ),
            );
          }, childCount: pickupRequestList.length),
        ),
      ];
    }
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

  static final textButtonStyle = ButtonStyle(
    overlayColor: WidgetStateProperty.all(ColorManager.lightGreyColor2),
  );

  static const textButtonTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );
}
