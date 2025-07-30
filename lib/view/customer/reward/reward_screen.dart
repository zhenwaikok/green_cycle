import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/reward/reward_model.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/reward_repository.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/utils/mixins/error_handling_mixin.dart';
import 'package:green_cycle_fyp/view/customer/reward/my_rewards_tab.dart';
import 'package:green_cycle_fyp/view/customer/reward/toredeem_tab.dart';
import 'package:green_cycle_fyp/viewmodel/reward_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_tab_bar.dart';
import 'package:provider/provider.dart';

@RoutePage()
class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RewardViewModel(
        rewardRepository: RewardRepository(),
        firebaseRepository: FirebaseRepository(
          firebaseServices: FirebaseServices(),
        ),
      ),
      child: _RewardScreen(),
    );
  }
}

class _RewardScreen extends StatefulWidget {
  @override
  State<_RewardScreen> createState() => _RewardSreenState();
}

class _RewardSreenState extends State<_RewardScreen> with ErrorHandlingMixin {
  List<RewardModel> _rewardList = [];
  bool _isLoading = true;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialLoad();
    });
  }

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
                SizedBox(height: 20),
                getTabBar(),
                Expanded(
                  child: TabBarView(
                    children: [
                      ToRedeemTab(
                        rewardList: _rewardList,
                        isLoading: _isLoading,
                      ),
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
  Future<void> initialLoad() async {
    _setState(() => _isLoading = true);
    final rewardList = await tryCatch(
      context,
      () => context.read<RewardViewModel>().getRewardList(),
    );

    if (rewardList != null) {
      _setState(() => _rewardList = rewardList);
    }

    _setState(() => _isLoading = false);
  }

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
