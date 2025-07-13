import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/reward_bottom_sheet.dart';

class MyRewardsTab extends StatefulWidget {
  const MyRewardsTab({super.key});

  @override
  State<MyRewardsTab> createState() => _MyRewardsTabState();
}

class _MyRewardsTabState extends State<MyRewardsTab> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: showRewardBottomSheet,
          child: getMyRewards(),
        );
      },
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _MyRewardsTabState {
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
extension _WidgetFactories on _MyRewardsTabState {
  Widget getMyRewards() {
    return getMyRewardsCard();
  }

  Widget getMyRewardsCard() {
    return Padding(
      padding: _Styles.gridViewBuilderPadding,
      child: CustomCard(
        padding: _Styles.myRewardsCardPadding,
        child: Center(
          child: Column(
            children: [
              getRewardImage(),
              Padding(
                padding: _Styles.rewardNameButtonPadding,
                child: getRewardName(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getRewardImage() {
    return CustomImage(
      imageWidth: double.infinity,
      imageSize: _Styles.rewardImageHeight,
      imageURL:
          'https://img.freepik.com/free-photo/purple-open-gift-box-with-voucher-bonus-surprise-minimal-present-greeting-celebration-promotion-discount-sale-reward-icon-3d-illustration_56104-2100.jpg?semt=ais_hybrid&w=740',
      borderRadius: _Styles.borderRadius,
    );
  }

  Widget getRewardName() {
    return Text(
      'Reward Name asdadasdsdasdasdasdaaaaaaaaaaaaaaaaaaaa',
      style: _Styles.rewardNameTextStyle,
      textAlign: TextAlign.justify,
      maxLines: _Styles.maxTextLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget getBottomSheetCard() {
    return RewardBottomSheet(
      imageURL:
          'https://img.freepik.com/free-photo/purple-open-gift-box-with-voucher-bonus-surprise-minimal-present-greeting-celebration-promotion-discount-sale-reward-icon-3d-illustration_56104-2100.jpg?semt=ais_hybrid&w=740',
      rewardName: 'Reward name aslkdjklajdajjsd',
      descriptionText:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc varius urna eu ultricies egestas.',
      buttonText: 'Use',
      onPressed: () {},
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const borderRadius = 0.0;
  static const maxTextLines = 2;
  static const rewardImageHeight = 80.0;

  static const gridViewBuilderPadding = EdgeInsets.symmetric(
    vertical: 10,
    horizontal: 10,
  );
  static const myRewardsCardPadding = EdgeInsets.all(0);

  static const rewardNameButtonPadding = EdgeInsets.symmetric(
    vertical: 15,
    horizontal: 20,
  );

  static const rewardNameTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );
}
