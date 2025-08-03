import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';

@RoutePage()
class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _AdminDashboardScreen();
  }
}

class _AdminDashboardScreen extends BaseStatefulPage {
  @override
  State<_AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState
    extends BaseStatefulState<_AdminDashboardScreen> {
  final List<String> dashboardCardTitle = [
    'Total Collectors',
    'Total Users',
    'Request Completed',
    'Articles',
  ];

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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getWelcomeMessage(),
          SizedBox(height: 35),
          getDashboarDetails(),
          SizedBox(height: 30),
          getQuickActionSection(),
        ],
      ),
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
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _AdminDashboardScreenState {
  Widget getWelcomeMessage() {
    return Text('Welcome, Admin', style: _Styles.welcomeMessageTextStyle);
  }

  Widget getDashboarDetails() {
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
        return getDashboardCard(title: dashboardCardTitle[index], number: '5');
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
          Text(number, style: _Styles.dashboardCardNumberTextStyle),
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
