import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/widget/card.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/reward_bottom_sheet.dart';

class ToRedeemTab extends StatefulWidget {
  const ToRedeemTab({super.key});

  @override
  State<ToRedeemTab> createState() => _ToRedeemTabState();
}

class _ToRedeemTabState extends State<ToRedeemTab> {
  @override
  Widget build(BuildContext context) {
    return getToRedeemRewards();
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ToRedeemTabState {
  void showRewardBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return getBottomSheetCard();
      },
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ToRedeemTabState {
  Widget getToRedeemRewards() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Padding(
              padding: _Styles.rewardPadding,
              child: Row(
                children: [
                  getRewardImage(),
                  SizedBox(width: 10),
                  getRewardDetails(),
                  getClaimButton(),
                ],
              ),
            ),

            Divider(color: ColorManager.lightGreyColor),
          ],
        );
      },
    );
  }

  Widget getClaimButton() {
    return SizedBox(
      width: _Styles.claimButtonSize,
      child: CustomButton(
        text: 'Claim',
        textColor: ColorManager.primary,
        onPressed: showRewardBottomSheet,
        backgroundColor: ColorManager.whiteColor,
        borderColor: ColorManager.primary,
      ),
    );
  }

  Widget getRewardDetails() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reward Name',
            style: _Styles.rewardNameTextStyle,
            maxLines: _Styles.maxTextLines,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10),
          Text('123 points', style: _Styles.pointsTextStyle),
        ],
      ),
    );
  }

  Widget getRewardImage() {
    return CustomImage(
      imageURL:
          'https://img.freepik.com/free-photo/purple-open-gift-box-with-voucher-bonus-surprise-minimal-present-greeting-celebration-promotion-discount-sale-reward-icon-3d-illustration_56104-2100.jpg?semt=ais_hybrid&w=740',
      imageSize: _Styles.rewardImageSize,
      borderRadius: _Styles.borderRadius,
    );
  }

  Widget getBottomSheetCard() {
    return RewardBottomSheet(
      imageURL:
          'https://img.freepik.com/free-photo/purple-open-gift-box-with-voucher-bonus-surprise-minimal-present-greeting-celebration-promotion-discount-sale-reward-icon-3d-illustration_56104-2100.jpg?semt=ais_hybrid&w=740',
      rewardName: 'Reward name aslkdjklajdajjsd',
      descriptionText:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc varius urna eu ultricies egestas.',
      buttonText: 'Claim with xxx points',
      onPressed: () {},
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
