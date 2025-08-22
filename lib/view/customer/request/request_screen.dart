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
import 'package:green_cycle_fyp/widget/custom_floating_action_button.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_sort_by.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:green_cycle_fyp/widget/no_data_label.dart';
import 'package:green_cycle_fyp/widget/search_bar.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});

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
      child: _RequestScreen(),
    );
  }
}

class _RequestScreen extends BaseStatefulPage {
  @override
  State<_RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends BaseStatefulState<_RequestScreen> {
  final requestItems = DropDownItems.requestDropdownItems;
  String? selectedValue;
  bool _isLoading = true;
  late final tabsRouter = AutoTabsRouter.of(context);
  List<PickupRequestModel> filteredPickupRequestList = [];
  TextEditingController searchController = TextEditingController();
  String? searchQuery;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabsRouter.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    tabsRouter.removeListener(_onTabChanged);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    selectedValue = requestItems.first;
  }

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  EdgeInsets defaultPadding() {
    return EdgeInsets.zero;
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(title: 'Request', isBackButtonVisible: false);
  }

  @override
  Widget floatingActionButton() {
    return CustomFloatingActionButton(
      icon: Icon(Icons.add, color: ColorManager.whiteColor),
      onPressed: onAddButtonPressed,
      heroTag: 'request_fab',
    );
  }

  @override
  Widget body() {
    filteredPickupRequestList = context.select(
      (PickupRequestViewModel vm) =>
          vm.pickupRequestList.where(isMatch).toList(),
    );

    return Padding(
      padding: _Styles.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getSearchBar(),
          SizedBox(height: 15),
          getFilterOption(),
          SizedBox(height: 20),
          Expanded(
            child: AdaptiveWidgets.buildRefreshableScrollView(
              context,
              onRefresh: fetchData,
              color: ColorManager.blackColor,
              refreshIndicatorBackgroundColor: ColorManager.whiteColor,
              slivers: [
                ...getPickupRequestList(
                  pickupRequestModel: _isLoading
                      ? List.generate(
                          5,
                          (_) => PickupRequestModel(
                            pickupRequestID: 'Loading...',
                            pickupItemDescription: 'Loading...',
                            pickupItemCategory: 'Loading...',
                            pickupLocation: 'Loading...',
                            pickupDate: DateTime.now(),
                            pickupTimeRange: 'Loading...',
                          ),
                        )
                      : filteredPickupRequestList,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// * ---------------------------- Helpers ----------------------------
extension _Helpers on _RequestScreenState {
  bool isMatch(PickupRequestModel request) {
    final query = searchQuery?.toLowerCase().trim() ?? '';

    final matchesSearch =
        query.isEmpty ||
        (request.pickupItemDescription?.toLowerCase().contains(query) ??
            false) ||
        (request.pickupItemCategory?.toLowerCase().contains(query) ?? false) ||
        (request.pickupRequestID?.toLowerCase().contains(query) ?? false);

    final matchesFilter =
        selectedValue == null ||
        selectedValue == requestItems.first ||
        request.pickupRequestStatus == selectedValue;

    return matchesSearch && matchesFilter;
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _RequestScreenState {
  void _onTabChanged() {
    if (tabsRouter.activeIndex == 1) {
      _setState(() {
        selectedValue = requestItems.first;
      });
      resetAll();
    }
  }

  void resetAll({bool? clearSearchText}) {
    _setState(() {
      searchQuery = null;
      searchController.clear();
      if (!(clearSearchText ?? false)) {
        selectedValue = requestItems.first;
      }
    });
  }

  void onFilterChanged(String? value) {
    _setState(() {
      selectedValue = value;
    });
  }

  void onSearchChanged(String? value) {
    _setState(() {
      searchQuery = value;
    });
  }

  void onRequestCardPressed({required String pickupRequestID}) async {
    final result = await context.router.push(
      RequestDetailsRoute(pickupRequestID: pickupRequestID),
    );

    if (result == true && mounted) {
      fetchData();
    }
  }

  void onAddButtonPressed() {
    context.router.push(SelectLocationRoute(isEdit: false));
  }

  Future<void> fetchData() async {
    _setState(() {
      _isLoading = true;
    });
    await tryCatch(
      context,
      () =>
          context.read<PickupRequestViewModel>().getPickupRequestsWithUserID(),
    );
    _setState(() {
      _isLoading = false;
    });
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _RequestScreenState {
  Widget getSearchBar() {
    return CustomSearchBar(
      controller: searchController,
      onChanged: (value) {
        onSearchChanged(value);
      },
      onPressed: () => resetAll(clearSearchText: true),
      hintText: 'Search request here',
    );
  }

  Widget getFilterOption() {
    return CustomSortBy(
      sortByItems: requestItems,
      selectedValue: selectedValue,
      onChanged: (String? value) {
        onFilterChanged(value);
      },
      isExpanded: false,
      needBorder: false,
    );
  }

  List<Widget> getPickupRequestList({
    required List<PickupRequestModel> pickupRequestModel,
    required bool isLoading,
  }) {
    if (pickupRequestModel.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: NoDataAvailableLabel(noDataText: 'No Requests Found'),
          ),
        ),
      ];
    }

    return [
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final request = pickupRequestModel[index];
          return getRequestCard(
            isLoading: _isLoading,
            requestID: request.pickupRequestID ?? '',
            pickupItemImageURL: request.pickupItemImageURL?.first ?? '',
            itemDescription: request.pickupItemDescription ?? '',
            category: request.pickupItemCategory ?? '',
            quantity: request.pickupItemQuantity ?? 0,
            pickupDate: request.pickupDate ?? DateTime.now(),
            pickupTimeRange: request.pickupTimeRange ?? '',
            status: request.pickupRequestStatus ?? '',
          );
        }, childCount: pickupRequestModel.length),
      ),
    ];
  }

  Widget getRequestCard({
    required String requestID,
    required String pickupItemImageURL,
    required String itemDescription,
    required String category,
    required int quantity,
    required DateTime pickupDate,
    required String pickupTimeRange,
    required String status,
    required bool isLoading,
  }) {
    return TouchableOpacity(
      onPressed: () => onRequestCardPressed(pickupRequestID: requestID),
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
                    getRequestID(requestID: requestID),
                    getRequestStatus(status: status),
                  ],
                ),
                getDivider(),
                getItemDetails(
                  pickupItemImageURL: pickupItemImageURL,
                  itemDescription: itemDescription,
                  category: category,
                  quantity: quantity,
                ),
                getDivider(),
                getPickupDateDetails(
                  pickupDate: pickupDate,
                  pickupTimeRange: pickupTimeRange,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getPickupDateDetails({
    required DateTime pickupDate,
    required String pickupTimeRange,
  }) {
    return Text(
      'Pickup Date: ${WidgetUtil.dateFormatter(pickupDate)}, $pickupTimeRange',
      style: _Styles.completedTextStyle,
    );
  }

  Widget getDivider() {
    return Padding(
      padding: _Styles.dividerPadding,
      child: Divider(color: ColorManager.lightGreyColor),
    );
  }

  Widget getRequestID({required String requestID}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Request ID', style: _Styles.requestIDTitleTextStyle),
        Text('#$requestID', style: _Styles.requestIDTextStyle),
      ],
    );
  }

  Widget getRequestStatus({required String status}) {
    Color color = WidgetUtil.getPickupRequestStatusColor(status);

    return CustomStatusBar(text: status, backgroundColor: color);
  }

  Widget getItemDetails({
    required String pickupItemImageURL,
    required String itemDescription,
    required String category,
    required int quantity,
  }) {
    return Row(
      children: [
        getItemImage(pickupItemImageURL: pickupItemImageURL),
        SizedBox(width: 15),
        Expanded(
          child: getItemDescription(
            pickupItemDescription: itemDescription,
            category: category,
            quantity: quantity,
          ),
        ),
      ],
    );
  }

  Widget getItemImage({required String pickupItemImageURL}) {
    return CustomImage(
      imageSize: _Styles.imageSize,
      imageURL: pickupItemImageURL,
      borderRadius: _Styles.imageBorderRadius,
    );
  }

  Widget getItemDescription({
    required String pickupItemDescription,
    required String category,
    required int quantity,
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
                pickupItemDescription,
                maxLines: _Styles.maxTextLines,
                overflow: TextOverflow.ellipsis,
                style: _Styles.itemDescriptionTextStyle,
              ),
              Text(category, style: _Styles.itemDescriptionTextStyle),
            ],
          ),
          Text(
            'Quantity: ${quantity.toString()}',
            style: _Styles.quantityTextStyle,
          ),
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

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

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
}
