import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/user/user_model.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_sort_by.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:green_cycle_fyp/widget/no_data_label.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class ManageCollectorsScreen extends StatelessWidget {
  const ManageCollectorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserViewModel(
        userRepository: UserRepository(
          sharePreferenceHandler: SharedPreferenceHandler(),
          userServices: UserServices(),
        ),
        firebaseRepository: FirebaseRepository(
          firebaseServices: FirebaseServices(),
        ),
      ),
      child: _ManageCollectorsScreen(),
    );
  }
}

class _ManageCollectorsScreen extends BaseStatefulPage {
  @override
  State<_ManageCollectorsScreen> createState() =>
      _ManageCollectorsScreenState();
}

class _ManageCollectorsScreenState
    extends BaseStatefulState<_ManageCollectorsScreen> {
  final sortByItems = DropDownItems.collectorManagementSortByItems;
  final statusItems = DropDownItems.collectorManagementStatusSortByItems;
  String? selectedSort;
  String? selectedStatus;
  bool _isLoading = true;
  late final tabsRouter = AutoTabsRouter.of(context);

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
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Collectors Management',
      isBackButtonVisible: false,
    );
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  Widget body() {
    final rawCollectorList = context.select((UserViewModel vm) => vm.userList);

    final filteredCollectorList = rawCollectorList
        .where((user) => user.userRole == 'Collector' && isMatch(user))
        .toList();

    sortCollectorList(collectorList: filteredCollectorList);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getFilterOptions(),
        SizedBox(height: 15),
        Expanded(
          child: AdaptiveWidgets.buildRefreshableScrollView(
            context,
            onRefresh: fetchData,
            color: ColorManager.blackColor,
            refreshIndicatorBackgroundColor: ColorManager.whiteColor,
            slivers: [
              if (filteredCollectorList.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: NoDataAvailableLabel(
                      noDataText: 'No Collectors Found',
                    ),
                  ),
                )
              else
                ...getCollectorList(
                  collectorList: _isLoading
                      ? List.generate(
                          5,
                          (index) => UserModel(
                            fullName: 'Loading...',
                            companyName: 'Loading...',
                          ),
                        )
                      : filteredCollectorList,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

// * ---------------------------- Helpers ----------------------------
extension _Helpers on _ManageCollectorsScreenState {
  bool isMatch(UserModel collector) {
    if (selectedStatus == statusItems[0]) return true;
    return collector.approvalStatus == selectedStatus;
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ManageCollectorsScreenState {
  void _onTabChanged() {
    if (tabsRouter.activeIndex == 1) {
      _setState(() {
        selectedSort = sortByItems.first;
        selectedStatus = statusItems.first;
      });
    }
  }

  void onSortByChanged(String? value) {
    _setState(() {
      selectedSort = value;
    });
  }

  void onStatusChanged(String? value) {
    _setState(() {
      selectedStatus = value;
    });
  }

  void onCollectorCardPressed({required String collectorID}) async {
    final result = await context.router.push(
      CollectorDetailsRoute(collectorID: collectorID),
    );

    if (result == true && mounted) {
      fetchData();
    }
  }

  void sortCollectorList({required List<UserModel> collectorList}) {
    if (selectedSort == sortByItems[1]) {
      collectorList.sort(
        (a, b) => (a.fullName?.toLowerCase() ?? '').compareTo(
          (b.fullName?.toLowerCase() ?? ''),
        ),
      );
    } else if (selectedSort == sortByItems[2]) {
      collectorList.sort(
        (a, b) => (b.fullName?.toLowerCase() ?? '').compareTo(
          (a.fullName?.toLowerCase() ?? ''),
        ),
      );
    } else if (selectedSort == sortByItems[3]) {
      collectorList.sort(
        (a, b) => (b.createdDate ?? DateTime.now()).compareTo(
          a.createdDate ?? DateTime.now(),
        ),
      );
    }
  }

  Future<void> fetchData() async {
    _setState(() {
      _isLoading = true;
      selectedSort = sortByItems.first;
      selectedStatus = statusItems.first;
    });
    await tryLoad(context, () => context.read<UserViewModel>().getAllUsers());
    _setState(() => _isLoading = false);
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ManageCollectorsScreenState {
  Widget getFilterOptions() {
    return Row(
      children: [
        getFilterDetails(
          text: 'Sort By',
          filterItems: sortByItems,
          selectedValue: selectedSort ?? '',
          onChanged: (value) {
            onSortByChanged(value);
          },
        ),
        SizedBox(width: 10),
        getFilterDetails(
          text: 'Status',
          filterItems: statusItems,
          selectedValue: selectedStatus ?? '',
          onChanged: (value) {
            onStatusChanged(value);
          },
        ),
      ],
    );
  }

  Widget getFilterDetails({
    required String text,
    required List<String> filterItems,
    required String selectedValue,
    required void Function(String?)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: _Styles.sortByTextStyle),
        SizedBox(height: 5),
        CustomSortBy(
          sortByItems: filterItems,
          selectedValue: selectedValue,
          onChanged: onChanged,
          isExpanded: false,
        ),
      ],
    );
  }

  Widget getAccountStatusBar({required String approvalStatus}) {
    final statusStyles = {
      'Approved': ColorManager.primary,
      'Pending': ColorManager.orangeColor,
      'Rejected': ColorManager.redColor,
    };

    return CustomStatusBar(
      text: approvalStatus,
      backgroundColor: statusStyles[approvalStatus],
    );
  }

  List<Widget> getCollectorList({required List<UserModel> collectorList}) {
    return [
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return getCollectorCard(user: collectorList[index]);
        }, childCount: collectorList.length),
      ),
    ];
  }

  Widget getCollectorCard({required UserModel user}) {
    return TouchableOpacity(
      onPressed: () => onCollectorCardPressed(collectorID: user.userID ?? ''),
      child: Padding(
        padding: _Styles.cardPadding,
        child: CustomCard(
          padding: _Styles.customCardPadding,
          needBoxShadow: false,
          needBorder: true,
          child: Skeletonizer(
            enabled: _isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                getAccountStatusBar(approvalStatus: user.approvalStatus ?? ''),
                Row(
                  children: [
                    getCollectorImage(imageURL: user.profileImageURL ?? ''),
                    SizedBox(width: 20),
                    Expanded(
                      child: getCollectorDetails(
                        collectorName: user.fullName ?? '',
                        companyName: user.companyName ?? '',
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: ColorManager.greyColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getCollectorImage({required String imageURL}) {
    return CustomImage(
      imageSize: _Styles.imageSize,
      borderRadius: _Styles.imageBorderRadius,
      imageURL: imageURL,
    );
  }

  Widget getCollectorDetails({
    required String collectorName,
    required String companyName,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          collectorName,
          style: _Styles.collectorNameTextStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 5),
        Text(
          companyName,
          style: _Styles.companyTextStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const imageSize = 60.0;
  static const imageBorderRadius = 40.0;

  static const customCardPadding = EdgeInsets.all(10);
  static const cardPadding = EdgeInsets.symmetric(vertical: 5);

  static const collectorNameTextStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const companyTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const sortByTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );
}
