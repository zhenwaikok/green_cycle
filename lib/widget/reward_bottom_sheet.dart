import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';

class RewardBottomSheet extends StatefulWidget {
  const RewardBottomSheet({
    super.key,
    required this.imageURL,
    required this.rewardName,
    required this.expiryDate,
    required this.descriptionText,
    required this.buttonText,
    required this.onPressed,
    required this.buttonBackgroundColor,
  });

  final String imageURL;
  final String rewardName;
  final DateTime expiryDate;
  final String descriptionText;
  final String buttonText;
  final Color buttonBackgroundColor;
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

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _RewardBottomSheetState {
  Widget getBottomSheetCard() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: getBottomSheetCardImageName(
            imageURL: widget.imageURL,
            rewardName: widget.rewardName,
          ),
        ),
        SizedBox(height: 20),
        getExpiryDate(expiryDate: widget.expiryDate),
        SizedBox(height: 20),
        getDescription(descriptionText: widget.descriptionText),
        SizedBox(height: 60),
        getBottomSheetCardClaimButton(
          buttonText: widget.buttonText,
          onPressed: widget.onPressed,
        ),
      ],
    );
  }

  Widget getBottomSheetCardImageName({
    required String imageURL,
    required String rewardName,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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

  Widget getExpiryDate({required DateTime expiryDate}) {
    return Row(
      children: [
        Icon(
          Icons.calendar_today,
          color: ColorManager.greyColor,
          size: _Styles.iconSize,
        ),
        SizedBox(width: 5),
        Text(
          'Expiry Date: ${WidgetUtil.dateFormatter(expiryDate)}',
          style: _Styles.expiryDateTextStyle,
        ),
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
      backgroundColor: widget.buttonBackgroundColor,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const bottomSheetImageSize = 120.0;
  static const borderRadius = 5.0;
  static const iconSize = 20.0;

  static const botomSheetRewardNameTextStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const expiryDateTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
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
