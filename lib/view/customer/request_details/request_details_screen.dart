import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
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
  bool isLoading = true;
  bool isDelete = false;
  bool isPending = false;
  bool showTrackingButton = false;
  bool isCompleted = false;
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
      actions: [isPending ? getDeleteButton() : SizedBox.shrink()],
    );
  }

  @override
  Widget? bottomNavigationBar() {
    return showTrackingButton ? getTrackLocatorButton() : null;
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

    if (pickupRequestDetails == null || isLoading) {
      return SizedBox.shrink();
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getRequestStatus(
            status: pickupRequestDetails.pickupRequestStatus ?? '',
            requestedDate: pickupRequestDetails.requestedDate ?? DateTime.now(),
          ),
          SizedBox(height: 10),
          getImageSlider(
            imgItems: pickupRequestDetails.pickupItemImageURL ?? [],
          ),
          SizedBox(height: 10),
          getDotIndicator(
            imgItems: pickupRequestDetails.pickupItemImageURL ?? [],
          ),
          if (isCompleted) ...[
            SizedBox(height: 20),
            getCompletionDate(
              completedDate:
                  pickupRequestDetails.completedDate ?? DateTime.now(),
            ),
            SizedBox(height: 10),
          ] else ...[
            SizedBox(height: 20),
          ],

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
            collectionProofImageURL:
                pickupRequestDetails.collectionProofImageURL ?? '',
            isCompleted: isCompleted,
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

  void onTrackButtonPressed({required String pickupRequestID}) async {
    context.router.push(
      RequestLocationTrackingRoute(pickupRequestID: pickupRequestID),
    );
  }

  Future<void> initialLoad() async {
    _setState(() {
      isLoading = true;
    });
    final vm = context.read<PickupRequestViewModel>();

    await tryLoad(
      context,
      () => vm.getPickupRequestDetails(pickupRequestID: widget.pickupRequestID),
    );

    _setState(() {
      showTrackingButton =
          vm.pickupRequestDetails?.pickupRequestStatus == 'Ongoing';
      isCompleted = vm.pickupRequestDetails?.pickupRequestStatus == 'Completed';
      isPending = vm.pickupRequestDetails?.pickupRequestStatus == 'Pending';
      isAccepted = vm.pickupRequestDetails?.pickupRequestStatus == 'Accepted';
      isLoading = false;
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

  Widget getRequestStatus({
    required String status,
    required DateTime requestedDate,
  }) {
    Color color = WidgetUtil.getPickupRequestStatusColor(status);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomStatusBar(text: status, backgroundColor: color),
        SizedBox(width: 20),
        getRequestedOn(requestedDate: requestedDate),
      ],
    );
  }

  Widget getRequestedOn({required DateTime requestedDate}) {
    return Text(
      'Requested on: ${WidgetUtil.dateTimeFormatter(requestedDate)}',
      style: _Styles.smallGreyTextStyle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
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
    required String pickupRequestID,
    required String pickupLocation,
    required DateTime pickupDate,
    required String pickupTimeRange,
    required String pickupItemDescription,
    required String pickupItemCategory,
    required int pickupItemQuantity,
    required String pickupItemCondition,
    required DateTime pickupCreatedAt,
    required String collectionProofImageURL,
    required bool isCompleted,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTitleDescription(
          title: 'Request ID',
          description: '#$pickupRequestID',
        ),
        getDivider(),
        if (isCompleted) ...[
          getCollectionProofSection(
            collectionProofImageURL: collectionProofImageURL,
          ),
          SizedBox(height: 10),
          getDivider(),
        ],
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
      ],
    );
  }

  Widget getCollectionProofSection({required String collectionProofImageURL}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Proof of Collection', style: _Styles.greenTextStyle),
        SizedBox(height: 10),
        CustomImage(
          imageSize: _Styles.collectionProofImageSize,
          imageURL: collectionProofImageURL,
        ),
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
          onPressed: () =>
              onTrackButtonPressed(pickupRequestID: widget.pickupRequestID),
          backgroundColor: ColorManager.primary,
        ),
      ),
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
  static const collectionProofImageSize = 180.0;

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

  static const smallGreyTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.regular,
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
