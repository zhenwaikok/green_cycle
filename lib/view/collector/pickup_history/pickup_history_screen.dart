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
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/pickup_request_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_date_filter.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:green_cycle_fyp/widget/no_data_label.dart';
import 'package:green_cycle_fyp/widget/search_bar.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class PickupHistoryScreen extends StatelessWidget {
  const PickupHistoryScreen({super.key});

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
      child: _PickupHistoryScreen(),
    );
  }
}

class _PickupHistoryScreen extends BaseStatefulPage {
  @override
  State<_PickupHistoryScreen> createState() => _PickupHistoryScreenState();
}

class _PickupHistoryScreenState
    extends BaseStatefulState<_PickupHistoryScreen> {
  DateTimeRange? selectedRange;
  bool isLoading = true;
  String? searchQuery;
  TextEditingController searchController = TextEditingController();

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
      title: 'Pickup History',
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
    final colletorUserID = context.read<UserViewModel>().user?.userID;

    final completedPickupRequestList = context.select(
      (PickupRequestViewModel vm) => vm.pickupRequestList
          .where(
            (request) =>
                request.pickupRequestStatus ==
                    DropDownItems.requestDropdownItems[5] &&
                request.collectorUserID == colletorUserID,
          )
          .toList(),
    );

    final seachedCompletedPickupRequestList = completedPickupRequestList
        .where((request) => isMatch(request))
        .toList();

    final filteredList = filteredCompletedPickupRequestList(
      pickupRequestList: seachedCompletedPickupRequestList,
    );

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: getCompletedPickups(
            completedCount: completedPickupRequestList.length,
          ),
        ),
        SizedBox(height: 50),
        getSearchBar(),
        SizedBox(height: 20),
        getDateRangePicker(),
        SizedBox(height: 35),
        Expanded(
          child: AdaptiveWidgets.buildRefreshableScrollView(
            context,
            onRefresh: fetchData,
            refreshIndicatorBackgroundColor: ColorManager.whiteColor,
            color: ColorManager.blackColor,
            slivers: [
              ...getCompletedRequestList(
                pickupRequestList: isLoading ? loadingList : filteredList,
                isLoading: isLoading,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// * ---------------------------- Helpers ----------------------------
extension _Helpers on _PickupHistoryScreenState {
  bool isMatch(PickupRequestModel request) {
    final query = searchQuery?.toLowerCase().trim() ?? '';
    final matchesSearch =
        query.isEmpty ||
        (request.pickupItemDescription?.toLowerCase().contains(query) ??
            false) ||
        (request.pickupItemCategory?.toLowerCase().contains(query) ?? false) ||
        (request.pickupRequestID?.toLowerCase().contains(query) ?? false);

    return matchesSearch;
  }

  List<PickupRequestModel> filteredCompletedPickupRequestList({
    required List<PickupRequestModel> pickupRequestList,
  }) {
    return pickupRequestList.where((request) {
      if (selectedRange == null) return true;

      final completionDate = request.completedDate ?? DateTime.now();

      final completionDateOnly = DateTime(
        completionDate.year,
        completionDate.month,
        completionDate.day,
      );
      final startDateOnly = DateTime(
        selectedRange?.start.year ?? 0,
        selectedRange?.start.month ?? 0,
        selectedRange?.start.day ?? 0,
      );
      final endDateOnly = DateTime(
        selectedRange?.end.year ?? 0,
        selectedRange?.end.month ?? 0,
        selectedRange?.end.day ?? 0,
      );

      return (completionDateOnly.isAtSameMomentAs(startDateOnly) ||
          completionDateOnly.isAtSameMomentAs(endDateOnly) ||
          (completionDateOnly.isAfter(startDateOnly) &&
              completionDateOnly.isBefore(endDateOnly)));
    }).toList();
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _PickupHistoryScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  void onDateRangeChanged(DateTimeRange range) {
    _setState(() {
      selectedRange = range;
    });
  }

  void clearDateRange() {
    _setState(() {
      selectedRange = null;
    });
  }

  void onSearchChanged(String? value) {
    _setState(() {
      searchQuery = value;
    });
  }

  void removeSearchText() {
    _setState(() {
      searchQuery = null;
      searchController.clear();
    });
  }

  void onPickupRequestCardPressed({required String pickupRequestID}) {
    context.router.push(
      CollectorPickupRequestDetailsRoute(pickupRequestID: pickupRequestID),
    );
  }

  Future<void> fetchData() async {
    _setState(() {
      isLoading = true;
    });
    await tryLoad(
      context,
      () => context.read<PickupRequestViewModel>().getAllPickupRequests(),
    );
    _setState(() {
      isLoading = false;
    });
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _PickupHistoryScreenState {
  Widget getCompletedPickups({required int completedCount}) {
    return Column(
      children: [
        Text('You\'ve completed', style: _Styles.titleTextStyle),
        SizedBox(height: 10),
        Text(
          completedCount <= 1
              ? '$completedCount Pickup'
              : '$completedCount Pickups',
          style: _Styles.pickUpTextStyle,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget getSearchBar() {
    return CustomSearchBar(
      hintText: 'Search request here',
      controller: searchController,
      onChanged: (value) {
        onSearchChanged(value);
      },
      onPressed: removeSearchText,
    );
  }

  Widget getDateRangePicker() {
    return Row(
      children: [
        CustomDateRangeFilter(
          selectedRange: selectedRange,
          onDateRangeChanged: onDateRangeChanged,
          hintText: 'Completion Date',
        ),
        if (selectedRange != null) ...[
          SizedBox(width: 10),
          TouchableOpacity(
            onPressed: clearDateRange,
            child: Text('Reset', style: _Styles.clearTextStyle),
          ),
        ],
      ],
    );
  }

  List<Widget> getCompletedRequestList({
    required List<PickupRequestModel> pickupRequestList,
    required bool isLoading,
  }) {
    if (pickupRequestList.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: NoDataAvailableLabel(
              noDataText: 'No Completed Pickups Found',
            ),
          ),
        ),
      ];
    }
    return [
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return getRequestCard(
            pickupRequestDetails: pickupRequestList[index],
            isLoading: isLoading,
          );
        }, childCount: pickupRequestList.length),
      ),
    ];
  }

  Widget getRequestCard({
    required PickupRequestModel pickupRequestDetails,
    required bool isLoading,
  }) {
    return TouchableOpacity(
      onPressed: () => onPickupRequestCardPressed(
        pickupRequestID: pickupRequestDetails.pickupRequestID ?? '',
      ),
      child: Padding(
        padding: _Styles.cardPadding,
        child: CustomCard(
          padding: _Styles.customCardPadding,
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
                      status: pickupRequestDetails.pickupRequestStatus ?? '',
                    ),
                  ],
                ),
                getDivider(),
                getItemDetails(pickupRequestDetails: pickupRequestDetails),
                getDivider(),
                getRequestDetailsDate(
                  text:
                      'Pickup Date: ${WidgetUtil.dateFormatter(pickupRequestDetails.pickupDate ?? DateTime.now())}, ${pickupRequestDetails.pickupTimeRange}',
                  style: _Styles.requestedTextStyle,
                ),
                SizedBox(height: 5),
                getRequestDetailsDate(
                  text:
                      'Completed: ${WidgetUtil.dateTimeFormatter(pickupRequestDetails.completedDate ?? DateTime.now())}',
                  style: _Styles.completedTextStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getRequestDetailsDate({
    required String text,
    required TextStyle style,
  }) {
    return Text(text, style: style);
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

  Widget getRequestStatus({required String status}) {
    return CustomStatusBar(text: status);
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
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const titleTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: ColorManager.blackColor,
  );

  static const pickUpTextStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: ColorManager.primary,
  );

  static const imageSize = 100.0;
  static const imageBorderRadius = 5.0;
  static const maxTextLines = 2;

  static const dividerPadding = EdgeInsets.symmetric(vertical: 6);

  static const cardPadding = EdgeInsets.symmetric(vertical: 15, horizontal: 5);
  static const customCardPadding = EdgeInsets.symmetric(
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

  static const requestedTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const completedTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.primary,
  );

  static const clearTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
    decoration: TextDecoration.underline,
  );
}
