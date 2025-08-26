import 'dart:async';

import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/reward/reward_model.dart';
import 'package:green_cycle_fyp/model/api_model/reward_redemption/reward_redemption_model.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/point_transaction_repository.dart';
import 'package:green_cycle_fyp/repository/reward_redemption_repository.dart';
import 'package:green_cycle_fyp/repository/reward_repository.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/view/customer/reward/my_rewards_tab.dart';
import 'package:green_cycle_fyp/view/customer/reward/toredeem_tab.dart';
import 'package:green_cycle_fyp/viewmodel/point_transaction_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/reward_redemption_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/reward_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_tab_bar.dart';
import 'package:green_cycle_fyp/widget/no_data_label.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        RewardViewModel(
          rewardRepository: RewardRepository(),
          firebaseRepository: FirebaseRepository(
            firebaseServices: FirebaseServices(),
          ),
        );
        RewardRedemptionViewModel(
          rewardRedemptionRepository: RewardRedemptionRepository(),
        );
        PointTransactionViewModel(
          pointTransactionRepository: PointTransactionRepository(),
        );
      },
      child: _RewardScreen(),
    );
  }
}

class _RewardScreen extends BaseStatefulPage {
  @override
  State<_RewardScreen> createState() => _RewardSreenState();
}

class _RewardSreenState extends BaseStatefulState<_RewardScreen> {
  List<RewardModel> _rewardList = [];
  bool _isLoading = true;
  bool claimReward = false;
  String? userID;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Rewards',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  EdgeInsets defaultPadding() {
    return _Styles.screenPadding;
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  Widget body() {
    final userCurrentPoint =
        context.read<UserViewModel>().userDetails?.currentPoint ?? 0;

    final rewardRedemptionList = context.select(
      (RewardRedemptionViewModel vm) => vm.rewardRedemptionList
          .where((redemption) => redemption.userID == userID)
          .toList(),
    );

    final redeemedRewardIDs = rewardRedemptionList
        .map((redemption) => redemption.rewardID)
        .toSet();

    final availableRewardList = _rewardList.where((reward) {
      return !redeemedRewardIDs.contains(reward.rewardID) &&
          !WidgetUtil.isRewardDateExpired(
            expiryDate: reward.expiryDate ?? DateTime.now(),
          ) &&
          reward.isActive == true;
    }).toList();

    final loadingRewardList = List.generate(
      5,
      (index) => RewardModel(rewardName: 'Loading...'),
    );

    final loadingRewardRedemptionList = List.generate(
      5,
      (index) => RewardRedemptionModel(rewardName: 'Loading...'),
    );

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Skeletonizer(
            enabled: _isLoading,
            child: getCurrentPoints(currentPoints: userCurrentPoint),
          ),
          SizedBox(height: 20),
          getTabBar(),
          Expanded(
            child: TabBarView(
              children: [
                buildTabContent(
                  rewardList: _isLoading
                      ? loadingRewardList
                      : availableRewardList,
                  isLoading: _isLoading,
                  showMyRewards: false,
                ),
                buildTabContent(
                  rewardRedemptionList: _isLoading
                      ? loadingRewardRedemptionList
                      : rewardRedemptionList,
                  isLoading: _isLoading,
                  showMyRewards: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _RewardSreenState {
  Future<void> fetchData() async {
    final userID = context.read<UserViewModel>().user?.userID ?? '';
    _setState(() {
      _isLoading = true;
      this.userID = userID;
    });

    await tryCatch(
      context,
      () => context.read<UserViewModel>().getUserDetails(userID: userID),
    );

    final rewardList = mounted
        ? await tryCatch(
            context,
            () => context.read<RewardViewModel>().getRewardList(),
          )
        : null;

    if (rewardList != null) {
      _setState(() => _rewardList = rewardList);
    }

    if (mounted) {
      await tryCatch(
        context,
        () => context
            .read<RewardRedemptionViewModel>()
            .getRewardRedemptionsWithUserID(userID: this.userID ?? ''),
      );
    }
    _setState(() => _isLoading = false);
  }

  Future<void> onBottomSheetClaimButtonPressed({
    required RewardModel reward,
  }) async {
    final userCurrentPoint =
        context.read<UserViewModel>().user?.currentPoint ?? 0;

    if ((reward.pointsRequired ?? 0) > userCurrentPoint) {
      unawaited(
        WidgetUtil.showDefaultErrorDialog(
          context,
          'Insufficient points, earn more points by requesting for pickup services!',
        ),
      );
    } else {
      final userID = context.read<UserViewModel>().user?.userID ?? '';

      await tryCatch(
        context,
        () => context.read<UserViewModel>().getUserDetails(userID: userID),
      );

      final insertRewardRedemptionResult = await insertRewardRedemption(
        userID: userID,
        reward: reward,
      );

      if (insertRewardRedemptionResult) {
        final updateUserPointResult = await updateUserPoint(
          pointsRequired: reward.pointsRequired ?? 0,
        );

        if (updateUserPointResult) {
          _setState(() => claimReward = true);
          await insertPointTransaction(userID: userID, rewardDetails: reward);
        }
      }
    }
  }

  Future<bool> insertRewardRedemption({
    required String userID,
    required RewardModel reward,
  }) async {
    final result =
        await tryLoad(
          context,
          () => context
              .read<RewardRedemptionViewModel>()
              .insertRewardRedemption(userID: userID, reward: reward),
        ) ??
        false;

    return result;
  }

  Future<bool> updateUserPoint({required int pointsRequired}) async {
    final result =
        await tryLoad(
          context,
          () => context.read<UserViewModel>().updateUser(
            noNeedUpdateUserSharedPreference: true,
            userID: userID,
            point: pointsRequired,
            isAddPoint: false,
          ),
        ) ??
        false;

    return result;
  }

  Future<void> insertPointTransaction({
    required String userID,
    required RewardModel rewardDetails,
  }) async {
    final result =
        await tryLoad(
          context,
          () =>
              context.read<PointTransactionViewModel>().insertPointTransaction(
                userID: userID,
                point: rewardDetails.pointsRequired ?? 0,
                type: 'used',
                description: 'Redeemed reward',
                createdAt: DateTime.now(),
              ),
        ) ??
        false;

    if (result) {
      unawaited(WidgetUtil.showSnackBar(text: 'Reward claimed successfully'));
      if (mounted) await context.router.maybePop();
      await fetchData();
    }
  }

  Future<void> onUseButtonPressed({
    required RewardRedemptionModel rewardRedemptionDetails,
    required String userID,
  }) async {
    final result =
        await tryLoad(
          context,
          () =>
              context.read<RewardRedemptionViewModel>().updateRewardRedemption(
                userID: userID,
                isUsed: true,
                rewardRedemptionDetails: rewardRedemptionDetails,
              ),
        ) ??
        false;

    if (result) {
      if (mounted) {
        await context.router.maybePop();
      }
      await fetchData();

      showQRDialog(rewardRedemptionDetails: rewardRedemptionDetails);
    }
  }

  void showQRDialog({required RewardRedemptionModel rewardRedemptionDetails}) {
    WidgetUtil.showAlertDialog(
      context,
      title: rewardRedemptionDetails.rewardName,
      customizeContent: getQrCodeDialogContent(
        rewardRedemptionDetails: rewardRedemptionDetails,
      ),
      actions: [
        (dialogContext) => getAlertDialogTextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          text: 'Done',
        ),
      ],
    );
  }

  void onBackButtonPressed() {
    context.router.maybePop(claimReward);
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _RewardSreenState {
  Widget getCurrentPoints({required int currentPoints}) {
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
          Text('$currentPoints', style: _Styles.pointsTextStyle),
        ],
      ),
    );
  }

  Widget getTabBar() {
    return CustomTabBar(tabs: [Text('To Redeem'), Text('My Rewards')]);
  }

  Widget buildTabContent({
    List<RewardModel>? rewardList,
    List<RewardRedemptionModel>? rewardRedemptionList,
    required bool showMyRewards,
    required bool isLoading,
  }) {
    return AdaptiveWidgets.buildRefreshableScrollView(
      context,
      onRefresh: fetchData,
      color: ColorManager.blackColor,
      refreshIndicatorBackgroundColor: ColorManager.whiteColor,
      slivers: showMyRewards
          ? getMyRewardGridList(
              rewardRedemptionList: rewardRedemptionList ?? [],
              isLoading: isLoading,
            )
          : getToRedeemRewardList(
              rewardList: rewardList ?? [],
              isLoading: isLoading,
            ),
    );
  }

  List<Widget> getToRedeemRewardList({
    required List<RewardModel> rewardList,
    required bool isLoading,
  }) {
    if (rewardList.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: NoDataAvailableLabel(noDataText: 'No Reward Found'),
          ),
        ),
      ];
    }

    return [
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return ToRedeemTab(
            rewardDetails: rewardList[index],
            isLoading: isLoading,
            onPressed: () =>
                onBottomSheetClaimButtonPressed(reward: rewardList[index]),
          );
        }, childCount: rewardList.length),
      ),
    ];
  }

  List<Widget> getMyRewardGridList({
    required List<RewardRedemptionModel> rewardRedemptionList,
    required bool isLoading,
  }) {
    if (rewardRedemptionList.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: NoDataAvailableLabel(noDataText: 'No Reward Found'),
          ),
        ),
      ];
    }

    return [
      SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final isUsed = WidgetUtil.isRewardUsed(
            rewardRedemptionDetails: rewardRedemptionList[index],
          );

          final isExpired = WidgetUtil.isRewardDateExpired(
            expiryDate:
                rewardRedemptionList[index].expiryDate ?? DateTime.now(),
          );

          return MyRewardsTab(
            rewardRedemptionDetails: rewardRedemptionList[index],
            isLoading: isLoading,
            onUseButtonPressed: isUsed || isExpired
                ? null
                : () => onUseButtonPressed(
                    rewardRedemptionDetails: rewardRedemptionList[index],
                    userID: rewardRedemptionList[index].userID ?? '',
                  ),
          );
        }, childCount: rewardRedemptionList.length),
      ),
    ];
  }

  Widget getQrCodeDialogContent({
    required RewardRedemptionModel rewardRedemptionDetails,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Show this QR code to scan:', style: _Styles.qrTitleTextStyle),
          SizedBox(height: 10),
          Center(
            child: QrImageView(
              data:
                  'Use reward ${rewardRedemptionDetails.rewardID}: ${rewardRedemptionDetails.rewardName}',
              version: QrVersions.auto,
              size: _Styles.qrCodeSize,
            ),
          ),
        ],
      ),
    );
  }

  Widget getAlertDialogTextButton({
    required void Function()? onPressed,
    required String text,
  }) {
    return TextButton(
      style: _Styles.textButtonStyle,
      onPressed: onPressed,
      child: Text(text, style: _Styles.textButtonTextStyle),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const coinIconSize = 28.0;
  static const qrCodeSize = 200.0;

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

  static const qrTitleTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static final textButtonStyle = ButtonStyle(
    overlayColor: WidgetStateProperty.all(ColorManager.lightGreyColor2),
  );

  static const textButtonTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );
}
