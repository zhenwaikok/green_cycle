import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/view/customer/points/earned_points_tab.dart';
import 'package:green_cycle_fyp/view/customer/points/used_points_tab.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_tab_bar.dart';

@RoutePage()
class PointsScreen extends StatelessWidget {
  const PointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PointsScreen();
  }
}

class _PointsScreen extends BaseStatefulPage {
  @override
  State<_PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends BaseStatefulState<_PointsScreen> {
  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Points',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
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
  Widget body() {
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: _Styles.screenPadding,
        child: Column(
          children: [
            getCurrentPoints(),
            SizedBox(height: 20),
            getTabBar(),
            SizedBox(height: 15),
            Expanded(
              child: TabBarView(children: [EarnedPointsTab(), UsedPointsTab()]),
            ),
          ],
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _PointsScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _PointsScreenState {
  Widget getCurrentPoints() {
    return CustomCard(
      child: Row(
        children: [
          Icon(
            FontAwesomeIcons.coins,
            color: ColorManager.blackColor,
            size: _Styles.coinIconSize,
          ),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              'Current Points',
              style: _Styles.currentPointsTextStyle,
            ),
          ),
          Text('1522', style: _Styles.pointsTextStyle),
        ],
      ),
    );
  }

  Widget getTabBar() {
    return CustomTabBar(tabs: [Text('Earned'), Text('Used')]);
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 40,
  );

  static const coinIconSize = 28.0;
  static const currentPointsTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const pointsTextStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );
}
