import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/reward/reward_model.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/reward_bottom_sheet.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ToRedeemTab extends StatefulWidget {
  const ToRedeemTab({
    super.key,
    required this.rewardDetails,
    required this.isLoading,
    required this.onPressed,
  });

  final RewardModel rewardDetails;
  final bool isLoading;
  final Function() onPressed;

  @override
  State<ToRedeemTab> createState() => _ToRedeemTabState();
}

class _ToRedeemTabState extends State<ToRedeemTab> {
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: widget.isLoading,
      child: getToRedeemRewards(rewardDetails: widget.rewardDetails),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ToRedeemTabState {
  void showRewardBottomSheet({required RewardModel rewardDetails}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorManager.whiteColor,
      builder: (context) {
        return getBottomSheetCard(rewardDetails: rewardDetails);
      },
    );
  }

  void onClaimButtonPressed() async {
    showRewardBottomSheet(rewardDetails: widget.rewardDetails);
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ToRedeemTabState {
  Widget getToRedeemRewards({required RewardModel rewardDetails}) {
    return Column(
      children: [
        Padding(
          padding: _Styles.rewardPadding,
          child: Row(
            children: [
              getRewardImage(imageURL: rewardDetails.rewardImageURL ?? ''),
              SizedBox(width: 10),
              getRewardDetails(
                rewardName: rewardDetails.rewardName ?? '-',
                pointsRequired: rewardDetails.pointsRequired?.toString() ?? '0',
              ),
              getClaimButton(rewardID: rewardDetails.rewardID ?? 0),
            ],
          ),
        ),

        Divider(color: ColorManager.lightGreyColor),
      ],
    );
  }

  Widget getClaimButton({required int rewardID}) {
    return SizedBox(
      width: _Styles.claimButtonSize,
      child: CustomButton(
        text: 'Claim',
        textColor: ColorManager.primary,
        onPressed: onClaimButtonPressed,
        backgroundColor: ColorManager.whiteColor,
        borderColor: ColorManager.primary,
      ),
    );
  }

  Widget getRewardDetails({
    required String rewardName,
    required String pointsRequired,
  }) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            rewardName,
            style: _Styles.rewardNameTextStyle,
            maxLines: _Styles.maxTextLines,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10),
          Text('$pointsRequired points', style: _Styles.pointsTextStyle),
        ],
      ),
    );
  }

  Widget getRewardImage({required String imageURL}) {
    return CustomImage(
      imageURL: imageURL,
      imageSize: _Styles.rewardImageSize,
      borderRadius: _Styles.borderRadius,
    );
  }

  Widget getBottomSheetCard({required RewardModel rewardDetails}) {
    return Padding(
      padding: _Styles.screenPadding,
      child: RewardBottomSheet(
        imageURL: rewardDetails.rewardImageURL ?? '',
        rewardName: rewardDetails.rewardName ?? '',
        expiryDate: rewardDetails.expiryDate ?? DateTime.now(),
        descriptionText: rewardDetails.rewardDescription ?? '',
        buttonText: 'Claim with ${rewardDetails.pointsRequired} points',
        onPressed: widget.onPressed,
        buttonBackgroundColor: ColorManager.primary,
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const rewardPadding = EdgeInsetsGeometry.symmetric(vertical: 15);
  static const rewardImageSize = 70.0;
  static const borderRadius = 5.0;
  static const maxTextLines = 3;
  static const claimButtonSize = 90.0;

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const rewardNameTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const pointsTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.greyColor,
  );
}
