import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/view/customer/reward/my_rewards_tab.dart';
import 'package:green_cycle_fyp/view/customer/reward/toredeem_tab.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';

@RoutePage()
class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardSreenState();
}

class _RewardSreenState extends State<RewardScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Rewards',
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
                  child: TabBarView(children: [ToRedeemTab(), MyRewardsTab()]),
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
extension _Actions on _RewardSreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _RewardSreenState {
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
      tabs: [Text('To Redeem'), Text('My Rewards')],
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

  static const coinIconSize = 28.0;

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 40,
  );

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
