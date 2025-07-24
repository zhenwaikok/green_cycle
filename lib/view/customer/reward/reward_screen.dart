import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/view/customer/reward/my_rewards_tab.dart';
import 'package:green_cycle_fyp/view/customer/reward/toredeem_tab.dart';
import 'package:green_cycle_fyp/viewmodel/reward_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_tab_bar.dart';
import 'package:provider/provider.dart';

@RoutePage()
class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardSreenState();
}

class _RewardSreenState extends State<RewardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RewardViewModel>().getRewardList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final rewardVM = context.watch<RewardViewModel>();
    final rewardList = rewardVM.rewardList;

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
                SizedBox(height: 20),
                getTabBar(),
                Expanded(
                  child: TabBarView(
                    children: [
                      ToRedeemTab(rewardList: rewardList),
                      MyRewardsTab(),
                    ],
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
extension _Actions on _RewardSreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _RewardSreenState {
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
    return CustomTabBar(tabs: [Text('To Redeem'), Text('My Rewards')]);
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
}
