import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/pickup_request/pickup_request_model.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/pickup_request_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/pickup_request_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:green_cycle_fyp/widget/dot_indicator.dart';
import 'package:green_cycle_fyp/widget/image_slider.dart';
import 'package:provider/provider.dart';

@RoutePage()
class PickupRequestDetailsScreen extends StatelessWidget {
  const PickupRequestDetailsScreen({super.key, required this.pickupRequestID});

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
      child: _PickupRequestDetailsScreen(pickupRequestID: pickupRequestID),
    );
  }
}

class _PickupRequestDetailsScreen extends BaseStatefulPage {
  const _PickupRequestDetailsScreen({required this.pickupRequestID});

  final String pickupRequestID;

  @override
  State<_PickupRequestDetailsScreen> createState() =>
      _PickupRequestDetailsScreenState();
}

class _PickupRequestDetailsScreenState
    extends BaseStatefulState<_PickupRequestDetailsScreen> {
  int currentIndex = 0;
  String? collectorName;
  String? requesterName;
  bool isLoading = true;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Request Details',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
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

    if (isLoading) {
      return Center(child: SizedBox.shrink());
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getRequestStatusAndRequestDetails(
            status: pickupRequestDetails?.pickupRequestStatus ?? '',
            requesterName: requesterName ?? '',
          ),
          SizedBox(height: 10),
          getImageSlider(
            imgItems: pickupRequestDetails?.pickupItemImageURL ?? [],
          ),
          SizedBox(height: 10),
          getDotIndicator(
            imgItems: pickupRequestDetails?.pickupItemImageURL ?? [],
          ),
          SizedBox(height: 20),
          getRequestDetails(
            pickupRequestDetails: pickupRequestDetails ?? PickupRequestModel(),
            collectorName: collectorName ?? '',
          ),
        ],
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

  Future<void> fetchData() async {
    _setState(() => isLoading = true);
    final pickupRequestVM = context.read<PickupRequestViewModel>();

    await tryLoad(
      context,
      () => pickupRequestVM.getPickupRequestDetails(
        pickupRequestID: widget.pickupRequestID,
      ),
    );

    final fetchedCollectorName = await getName(
      userID: pickupRequestVM.pickupRequestDetails?.collectorUserID ?? '',
      isCollectorName: true,
    );

    final fetchedRequesterName = await getName(
      userID: pickupRequestVM.pickupRequestDetails?.userID ?? '',
      isCollectorName: false,
    );

    _setState(() {
      collectorName = fetchedCollectorName;
      requesterName = fetchedRequesterName;
      isLoading = false;
    });
  }

  Future<String> getName({
    required String userID,
    required bool isCollectorName,
  }) async {
    final userVM = context.read<UserViewModel>();
    await tryCatch(
      context,
      () => userVM.getUserDetails(
        userID: userID,
        noNeedUpdateUserSharedPreference: true,
      ),
    );

    return isCollectorName
        ? userVM.userDetails?.fullName ?? ''
        : '${userVM.userDetails?.firstName} ${userVM.userDetails?.lastName}';
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _PickupRequestDetailsScreenState {
  Widget getRequestStatusAndRequestDetails({
    required String status,
    required String requesterName,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomStatusBar(text: status),
        SizedBox(width: 40),
        Expanded(
          child: Text(
            'Requested by $requesterName',
            style: _Styles.smallGreyTextStyle,
            textAlign: TextAlign.right,
            maxLines: _Styles.maxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
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

  Widget getRequestDetails({
    required PickupRequestModel pickupRequestDetails,
    required String collectorName,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (pickupRequestDetails.pickupRequestStatus == 'Completed') ...[
          Text(
            'Picked Up by $collectorName: ${WidgetUtil.dateTimeFormatter(pickupRequestDetails.completedDate ?? DateTime.now())}',
            style: _Styles.smallGreyTextStyle,
            textAlign: TextAlign.right,
            maxLines: _Styles.maxLines,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 15),
        ],
        getTitleDescription(
          title: 'Request ID',
          description: '#${pickupRequestDetails.pickupRequestID}',
        ),
        getDivider(),
        getTitleDescription(
          title: 'Pickup Location',
          description: pickupRequestDetails.pickupLocation ?? '',
        ),
        getDivider(),
        getTitleDescription(
          title: 'Pickup Date & Time',
          description:
              '${WidgetUtil.dateFormatter(pickupRequestDetails.pickupDate ?? DateTime.now())}, ${pickupRequestDetails.pickupTimeRange}',
        ),
        getDivider(),
        getTitleDescription(
          title: 'Item Description',
          description: pickupRequestDetails.pickupItemDescription ?? '',
        ),
        getDivider(),
        getTitleDescription(
          title: 'Category',
          description: pickupRequestDetails.pickupItemCategory ?? '',
        ),
        getDivider(),
        getTitleDescription(
          title: 'Quantity',
          description: '${pickupRequestDetails.pickupItemQuantity ?? 0}',
        ),
        getDivider(),
        getTitleDescription(
          title: 'Condition & Usage Info',
          description: pickupRequestDetails.pickupItemCondition ?? '',
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
    fontSize: 12,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );
}
