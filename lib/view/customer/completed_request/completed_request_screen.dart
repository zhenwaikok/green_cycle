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
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_date_filter.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/no_data_label.dart';
import 'package:green_cycle_fyp/widget/search_bar.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class CompletedRequestScreen extends StatelessWidget {
  const CompletedRequestScreen({super.key});

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
      child: _CompletedRequestScreen(),
    );
  }
}

class _CompletedRequestScreen extends BaseStatefulPage {
  @override
  State<_CompletedRequestScreen> createState() =>
      _CompletedRequestScreenState();
}

class _CompletedRequestScreenState
    extends BaseStatefulState<_CompletedRequestScreen> {
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
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Completed Request',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  Widget body() {
    final completedPickupRequestList = context.select(
      (PickupRequestViewModel vm) => vm.pickupRequestList
          .where(
            (request) =>
                request.pickupRequestStatus ==
                DropDownItems.requestDropdownItems[5],
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
      (_) => PickupRequestModel(
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
        getSearchBar(),
        SizedBox(height: 20),
        getDateRangePicker(),
        SizedBox(height: 30),
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
extension _Helpers on _CompletedRequestScreenState {
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
extension _Actions on _CompletedRequestScreenState {
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
    context.router.push(RequestDetailsRoute(pickupRequestID: pickupRequestID));
  }

  Future<void> fetchData() async {
    _setState(() {
      isLoading = true;
    });
    await tryCatch(
      context,
      () =>
          context.read<PickupRequestViewModel>().getPickupRequestsWithUserID(),
    );
    _setState(() {
      isLoading = false;
    });
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CompletedRequestScreenState {
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
              noDataText: 'No Completed Requests Found',
            ),
          ),
        ),
      ];
    } else {
      return [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return getCompletedRequestCard(
              pickupRequest: pickupRequestList[index],
              isLoading: isLoading,
            );
          }, childCount: pickupRequestList.length),
        ),
      ];
    }
  }

  Widget getCompletedRequestCard({
    required PickupRequestModel pickupRequest,
    required bool isLoading,
  }) {
    return Padding(
      padding: _Styles.cardPadding,
      child: TouchableOpacity(
        onPressed: () => onPickupRequestCardPressed(
          pickupRequestID: pickupRequest.pickupRequestID ?? '',
        ),
        child: CustomCard(
          padding: _Styles.customCardPadding,
          child: Skeletonizer(
            enabled: isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getRequestID(
                  pickupRequestID: pickupRequest.pickupRequestID ?? '',
                ),
                getDivider(),
                getItemDetails(pickupRequest: pickupRequest),
                getDivider(),
                getCompletedDetails(
                  completedDate: pickupRequest.completedDate ?? DateTime.now(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getCompletedDetails({required DateTime completedDate}) {
    return Text(
      'Completed: ${WidgetUtil.dateTimeFormatter(completedDate)}',
      style: _Styles.completedTextStyle,
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

  Widget getItemDetails({required PickupRequestModel pickupRequest}) {
    return Row(
      children: [
        getItemImage(imageURL: pickupRequest.pickupItemImageURL?.first ?? ''),
        SizedBox(width: 15),
        Expanded(
          child: getItemDescription(
            itemDescription: pickupRequest.pickupItemDescription ?? '',
            itemCategory: pickupRequest.pickupItemCategory ?? '',
            itemQuantity: pickupRequest.pickupItemQuantity ?? 0,
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

  static const completedTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const clearTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
    decoration: TextDecoration.underline,
  );
}
