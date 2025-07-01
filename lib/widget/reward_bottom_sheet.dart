import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/widget/card.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';

class RewardBottomSheet extends StatefulWidget {
  const RewardBottomSheet({
    super.key,
    required this.imageURL,
    required this.rewardName,
    required this.descriptionText,
    required this.buttonText,
    required this.onPressed,
  });

  final String imageURL;
  final String rewardName;
  final String descriptionText;
  final String buttonText;
  final void Function() onPressed;

  @override
  State<RewardBottomSheet> createState() => _RewardBottomSheetState();
}

class _RewardBottomSheetState extends State<RewardBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return getBottomSheetCard();
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _RewardBottomSheetState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _RewardBottomSheetState {
  Widget getBottomSheetCard() {
    final height = MediaQuery.of(context).size.height * 0.5;

    return CustomCard(
      children: [
        SizedBox(
          height: height,
          child: Column(
            children: [
              getBottomSheetCardImageName(
                imageURL: widget.imageURL,
                rewardName: widget.rewardName,
              ),
              SizedBox(height: 40),
              getDescription(descriptionText: widget.descriptionText),
              Spacer(),
              getBottomSheetCardClaimButton(
                buttonText: widget.buttonText,
                onPressed: widget.onPressed,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getBottomSheetCardImageName({
    required String imageURL,
    required String rewardName,
  }) {
    return Column(
      children: [
        CustomImage(
          imageURL: imageURL,
          imageSize: _Styles.bottomSheetImageSize,
          borderRadius: _Styles.borderRadius,
        ),
        SizedBox(height: 10),
        Text(rewardName, style: _Styles.botomSheetRewardNameTextStyle),
      ],
    );
  }

  Widget getDescription({required String descriptionText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: _Styles.descriptionTitleTextStyle),
        Text(
          descriptionText,
          style: _Styles.descriptionTextStyle,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget getBottomSheetCardClaimButton({
    required String buttonText,
    required void Function() onPressed,
  }) {
    return CustomButton(
      text: buttonText,
      textColor: ColorManager.whiteColor,
      onPressed: onPressed,
      backgroundColor: ColorManager.primary,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const bottomSheetImageSize = 120.0;
  static const borderRadius = 5.0;

  static const botomSheetRewardNameTextStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const descriptionTitleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const descriptionTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );
}
