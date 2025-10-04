import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/pickup_request/pickup_request_model.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/pickup_request_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/view/admin/manage_requests/manage_request_tab.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/pickup_request_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_tab_bar.dart';
import 'package:green_cycle_fyp/widget/no_data_label.dart';
import 'package:green_cycle_fyp/widget/search_bar.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ManageRequestsScreen extends StatelessWidget {
  const ManageRequestsScreen({super.key});

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
      child: _ManageRequestsScreen(),
    );
  }
}

class _ManageRequestsScreen extends BaseStatefulPage {
  @override
  State<_ManageRequestsScreen> createState() => _ManageRequestsScreenState();
}

class _ManageRequestsScreenState
    extends BaseStatefulState<_ManageRequestsScreen> {
  bool isLoading = true;
  String? searchQuery;
  TextEditingController searchController = TextEditingController();
  late final tabsRouter = AutoTabsRouter.of(context);

  void _setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

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

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(title: 'Pickup Request', isBackButtonVisible: false);
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  Widget body() {
    final allPickupRequestList = context.select(
      (PickupRequestViewModel vm) => vm.pickupRequestList,
    );

    final filteredPickupRequestList = context.select(
      (PickupRequestViewModel vm) =>
          vm.pickupRequestList.where(isMatch).toList(),
    );

    final pendingPickupRequestList = filteredPickupRequestList
        .where((request) => request.pickupRequestStatus == 'Pending')
        .toList();

    final ongoingPickupRequestList = filteredPickupRequestList
        .where((request) => request.pickupRequestStatus == 'Ongoing')
        .toList();

    final completedPickupRequestList = filteredPickupRequestList
        .where((request) => request.pickupRequestStatus == 'Completed')
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
      length: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          getTotalRequestCard(totalRequests: allPickupRequestList.length),
          SizedBox(height: 60),
          getSearchBar(controller: searchController),
          SizedBox(height: 20),
          getTabBar(),
          SizedBox(height: 10),
          Expanded(
            child: TabBarView(
              children: [
                buildTabContent(
                  pickupRequestList: isLoading
                      ? loadingPickupRequestList
                      : filteredPickupRequestList,
                ),
                buildTabContent(
                  pickupRequestList: isLoading
                      ? loadingPickupRequestList
                      : pendingPickupRequestList,
                ),
                buildTabContent(
                  pickupRequestList: isLoading
                      ? loadingPickupRequestList
                      : ongoingPickupRequestList,
                ),
                buildTabContent(
                  pickupRequestList: isLoading
                      ? loadingPickupRequestList
                      : completedPickupRequestList,
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
extension _Helpers on _ManageRequestsScreenState {
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
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ManageRequestsScreenState {
  void onRequestCardPressed({required String pickupRequestID}) {
    context.router.push(
      PickupRequestDetailsRoute(pickupRequestID: pickupRequestID),
    );
  }

  void _onTabChanged() {
    if (tabsRouter.activeIndex == 2) {
      resetAll();
    }
  }

  void resetAll() {
    _setState(() {
      searchQuery = null;
      searchController.clear();
    });
  }

  void onSearchChanged(String? value) {
    _setState(() {
      searchQuery = value;
    });
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
extension _WidgetFactories on _ManageRequestsScreenState {
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
            child: NoDataAvailableLabel(noDataText: 'No Requests Found'),
          ),
        ),
      ];
    } else {
      return [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return ManageRequestTab(
              isLoading: isLoading,
              onTap: () => onRequestCardPressed(
                pickupRequestID: pickupRequestList[index].pickupRequestID ?? '',
              ),
              request: pickupRequestList[index],
            );
          }, childCount: pickupRequestList.length),
        ),
      ];
    }
  }

  Widget getTabBar() {
    return CustomTabBar(
      tabs: [Text('All'), Text('Pending'), Text('Ongoing'), Text('Completed')],
    );
  }

  Widget getTotalRequestCard({required int totalRequests}) {
    return CustomCard(
      padding: _Styles.customCardPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total Request', style: _Styles.blackTextStyle),
          Text(totalRequests.toString(), style: _Styles.primaryTextStyle),
        ],
      ),
    );
  }

  Widget getSearchBar({required TextEditingController controller}) {
    return CustomSearchBar(
      controller: controller,
      hintText: 'Search request here',
      onChanged: (value) {
        onSearchChanged(value);
      },
      onPressed: resetAll,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();
  static const customCardPadding = EdgeInsets.all(10);

  static const blackTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const primaryTextStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );
}
