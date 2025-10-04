import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/reward_redemption/reward_redemption_model.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:green_cycle_fyp/widget/reward_bottom_sheet.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyRewardsTab extends StatefulWidget {
  const MyRewardsTab({
    super.key,
    required this.rewardRedemptionDetails,
    required this.isLoading,
    required this.onUseButtonPressed,
  });

  final RewardRedemptionModel rewardRedemptionDetails;
  final bool isLoading;
  final void Function()? onUseButtonPressed;

  @override
  State<MyRewardsTab> createState() => _MyRewardsTabState();
}

class _MyRewardsTabState extends State<MyRewardsTab> {
  @override
  Widget build(BuildContext context) {
    final isUsed = WidgetUtil.isRewardUsed(
      rewardRedemptionDetails: widget.rewardRedemptionDetails,
    );

    final isExpired = WidgetUtil.isRewardDateExpired(
      expiryDate: widget.rewardRedemptionDetails.expiryDate ?? DateTime.now(),
    );

    return TouchableOpacity(
      isLoading: widget.isLoading,
      onPressed: () => showRewardBottomSheet(
        rewardRedemptionDetails: widget.rewardRedemptionDetails,
        isRewardUsed: isUsed,
        isRewardExpired: isExpired,
      ),
      child: getMyRewardsCard(
        rewardRedemptionDetails: widget.rewardRedemptionDetails,
        isLoading: widget.isLoading,
        isRewardUsed: isUsed,
        isRewardExpired: isExpired,
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _MyRewardsTabState {
  void showRewardBottomSheet({
    required RewardRedemptionModel rewardRedemptionDetails,
    required bool isRewardUsed,
    required bool isRewardExpired,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorManager.whiteColor,
      builder: (context) {
        return getBottomSheetCard(
          rewardRedemptionDetails: rewardRedemptionDetails,
          isRewardUsed: isRewardUsed,
          isRewardExpired: isRewardExpired,
        );
      },
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _MyRewardsTabState {
  Widget getMyRewardsCard({
    required RewardRedemptionModel rewardRedemptionDetails,
    required bool isLoading,
    required bool isRewardUsed,
    required bool isRewardExpired,
  }) {
    return Padding(
      padding: _Styles.gapPadding,
      child: SizedBox(
        height: _Styles.rewardCardHeight,
        child: CustomCard(
          padding: _Styles.myRewardsCardPadding,
          child: Skeletonizer(
            enabled: isLoading,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    getRewardImage(
                      imageURL: rewardRedemptionDetails.rewardImageURL ?? '',
                    ),
                    Positioned(
                      top: 5,
                      left: 5,
                      child: getStatusBar(
                        isUsed: isRewardUsed,
                        isExpired: isRewardExpired,
                        backgroundColor: isRewardUsed
                            ? ColorManager.greyColor
                            : isRewardExpired
                            ? ColorManager.greyColor
                            : ColorManager.primary,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: _Styles.rewardNamePadding,
                  child: getRewardName(
                    rewardName: rewardRedemptionDetails.rewardName ?? '',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getRewardImage({required String imageURL}) {
    return CustomImage(
      imageWidth: double.infinity,
      imageSize: _Styles.rewardImageHeight,
      imageURL: imageURL,
      borderRadius: _Styles.borderRadius,
    );
  }

  Widget getStatusBar({
    required bool isUsed,
    required bool isExpired,
    required Color backgroundColor,
  }) {
    return CustomStatusBar(
      text: WidgetUtil.getRewardStatus(isUsed: isUsed, isExpired: isExpired),
      backgroundColor: backgroundColor,
    );
  }

  Widget getRewardName({required String rewardName}) {
    return Text(
      rewardName,
      style: _Styles.rewardNameTextStyle,
      textAlign: TextAlign.justify,
      maxLines: _Styles.maxTextLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget getBottomSheetCard({
    required RewardRedemptionModel rewardRedemptionDetails,
    required bool isRewardUsed,
    required bool isRewardExpired,
  }) {
    return Padding(
      padding: _Styles.screenPadding,
      child: RewardBottomSheet(
        imageURL: rewardRedemptionDetails.rewardImageURL ?? '',
        rewardName: rewardRedemptionDetails.rewardName ?? '',
        expiryDate: rewardRedemptionDetails.expiryDate ?? DateTime.now(),

        descriptionText: rewardRedemptionDetails.rewardDescription ?? '',
        buttonText: isRewardExpired && !isRewardUsed
            ? 'Expired'
            : isRewardUsed || (isRewardUsed && isRewardExpired)
            ? 'Used'
            : 'Use',
        onPressed: widget.onUseButtonPressed,
        buttonTextColor: (isRewardExpired || isRewardUsed)
            ? ColorManager.blackColor
            : ColorManager.whiteColor,
        buttonBackgroundColor: ColorManager.primary,
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const borderRadius = 0.0;
  static const maxTextLines = 2;
  static const rewardImageHeight = 100.0;
  static const rewardCardHeight = 160.0;

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const gapPadding = EdgeInsets.symmetric(vertical: 10, horizontal: 10);
  static const myRewardsCardPadding = EdgeInsets.all(0);

  static const rewardNamePadding = EdgeInsets.all(10);

  static const rewardNameTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );
}
