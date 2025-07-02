import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/view/customer/points/earned_points_tab.dart';
import 'package:green_cycle_fyp/view/customer/points/used_points_tab.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';

@RoutePage()
class PointsScreen extends StatefulWidget {
  const PointsScreen({super.key});

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Points',
          isBackButtonVisible: true,
          onPressed: onBackButtonPressed,
        ),
        body: SafeArea(
          child: Padding(
            padding: _Styles.screenPadding,
            child: Column(
              children: [
                getCurrentPoints(),
                getTabBar(),
                Expanded(
                  child: TabBarView(
                    children: [EarnedPointsTab(), UsedPointsTab()],
                  ),
                ),
              ],
            ),
          ),
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
      children: [
        Row(
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
      ],
    );
  }

  Widget getTabBar() {
    return TabBar(
      tabs: [Text('Earned'), Text('Used')],
      dividerColor: Colors.transparent,
      indicatorColor: ColorManager.primary,
      labelColor: ColorManager.primary,
      unselectedLabelColor: ColorManager.greyColor,
      labelStyle: _Styles.tabLabelTextStyle,
      padding: _Styles.tabBarPadding,
      labelPadding: _Styles.tabBarLabelPadding,
      overlayColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.pressed)) {
          return ColorManager.lightGreyColor2;
        }
        return null;
      }),
    );
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

  static const tabLabelTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
  );

  static const tabBarPadding = EdgeInsets.symmetric(vertical: 30);

  static const tabBarLabelPadding = EdgeInsets.symmetric(vertical: 10);
}
