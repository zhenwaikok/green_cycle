import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/awareness/awareness_model.dart';
import 'package:green_cycle_fyp/repository/awareness_repository.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/pickup_request_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/services/awareness_services.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/awareness_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/pickup_request_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        UserViewModel(
          userRepository: UserRepository(
            sharePreferenceHandler: SharedPreferenceHandler(),
            userServices: UserServices(),
          ),
          firebaseRepository: FirebaseRepository(
            firebaseServices: FirebaseServices(),
          ),
        );
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
        AwarenessViewModel(
          awarenessRepository: AwarenessRepository(
            awarenessServices: AwarenessServices(),
          ),
          firebaseRepository: FirebaseRepository(
            firebaseServices: FirebaseServices(),
          ),
        );
      },
      child: _AdminDashboardScreen(),
    );
  }
}

class _AdminDashboardScreen extends BaseStatefulPage {
  @override
  State<_AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState
    extends BaseStatefulState<_AdminDashboardScreen> {
  bool isLoading = true;
  List<AwarenessModel> awarenessList = [];
  final List<String> dashboardCardTitle = [
    'Total Collectors',
    'Total Customers',
    'Completed Requests',
    'Articles',
  ];

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
    return CustomAppBar(title: 'Admin Dashboard', isBackButtonVisible: false);
  }

  @override
  Widget body() {
    final allUsers = context.select((UserViewModel vm) => vm.userList);
    final collectors = allUsers
        .where((user) => user.userRole == DropDownItems.roles[1])
        .toList();
    final customers = allUsers
        .where((user) => user.userRole == DropDownItems.roles[0])
        .toList();
    final pickupRequest = context.select(
      (PickupRequestViewModel vm) => vm.pickupRequestList.where(
        (requet) =>
            requet.pickupRequestStatus == DropDownItems.requestDropdownItems[5],
      ),
    );
    final awareness = awarenessList;

    final dashboardNumbers = [
      collectors.length.toString(),
      customers.length.toString(),
      pickupRequest.length.toString(),
      awareness.length.toString(),
    ];

    return AdaptiveWidgets.buildRefreshableScrollView(
      context,
      onRefresh: fetchData,
      refreshIndicatorBackgroundColor: ColorManager.whiteColor,
      color: ColorManager.blackColor,
      slivers: [
        SliverMainAxisGroup(
          slivers: [
            SliverToBoxAdapter(child: getWelcomeMessage()),
            SliverToBoxAdapter(child: SizedBox(height: 35)),
            SliverToBoxAdapter(
              child: getDashboarDetails(dashboardNumbers: dashboardNumbers),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 30)),
            SliverToBoxAdapter(child: getQuickActionSection()),
          ],
        ),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _AdminDashboardScreenState {
  void onViewCollectorApplicationPressed() {
    AutoTabsRouter.of(context).setActiveIndex(1);
  }

  void onManageNewsContentPressed() {
    AutoTabsRouter.of(context).setActiveIndex(3);
  }

  void onManageRewardsPressed() {
    context.router.push(ManageRewardsRoute());
  }

  Future<void> fetchData() async {
    _setState(() => isLoading = true);
    await tryCatch(context, () => context.read<UserViewModel>().getAllUsers());
    mounted
        ? await tryCatch(
            context,
            () => context.read<PickupRequestViewModel>().getAllPickupRequests(),
          )
        : null;
    final awarenessList = mounted
        ? await tryCatch(
            context,
            () => context.read<AwarenessViewModel>().getAwarenessList(),
          )
        : null;
    _setState(() {
      this.awarenessList = awarenessList ?? [];
      isLoading = false;
    });
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _AdminDashboardScreenState {
  Widget getWelcomeMessage() {
    return Text('Welcome, Admin', style: _Styles.welcomeMessageTextStyle);
  }

  Widget getDashboarDetails({required List<String>? dashboardNumbers}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 2,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return getDashboardCard(
          title: dashboardCardTitle[index],
          number: dashboardNumbers?[index] ?? '0',
        );
      },
    );
  }

  Widget getDashboardCard({required String title, required String number}) {
    return CustomCard(
      padding: _Styles.customCardPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: _Styles.dashboardCardTitleTextStyle),
          Skeletonizer(
            enabled: isLoading,
            child: Text(number, style: _Styles.dashboardCardNumberTextStyle),
          ),
        ],
      ),
    );
  }

  Widget getQuickActionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Actions', style: _Styles.quickActionTitleTextStyle),
        SizedBox(height: 15),
        getQuickActionCard(
          icon: Icons.description,
          actionText: 'View Collector Application',
          onTap: onViewCollectorApplicationPressed,
        ),
        SizedBox(height: 20),
        getQuickActionCard(
          icon: Icons.campaign,
          actionText: 'Manage Awareness Content',
          onTap: onManageNewsContentPressed,
        ),
        SizedBox(height: 20),
        getQuickActionCard(
          icon: Icons.card_giftcard_outlined,
          actionText: 'Manage Rewards',
          onTap: onManageRewardsPressed,
        ),
      ],
    );
  }

  Widget getQuickActionCard({
    required IconData icon,
    required String actionText,
    required void Function() onTap,
  }) {
    return TouchableOpacity(
      onPressed: onTap,
      isLoading: isLoading,
      child: Skeletonizer(
        enabled: isLoading,
        child: CustomCard(
          padding: _Styles.customCardPadding,
          backgroundColor: ColorManager.primary,
          needBoxShadow: false,
          child: Row(
            children: [
              Icon(
                icon,
                color: ColorManager.whiteColor,
                size: _Styles.actionIconSize,
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(actionText, style: _Styles.quickActionTextStyle),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: ColorManager.whiteColor,
                size: _Styles.arrowIconSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const actionIconSize = 35.0;
  static const arrowIconSize = 20.0;

  static const customCardPadding = EdgeInsets.all(10);

  static const welcomeMessageTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const dashboardCardTitleTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const dashboardCardNumberTextStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const quickActionTitleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const quickActionTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.whiteColor,
  );
}
