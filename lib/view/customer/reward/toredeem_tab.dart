import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/reward/reward_model.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/reward_view_model.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/reward_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ToRedeemTab extends BaseStatefulPage {
  const ToRedeemTab({
    super.key,
    required this.rewardList,
    required this.isLoading,
  });

  final List<RewardModel> rewardList;
  final bool isLoading;

  @override
  State<ToRedeemTab> createState() => _ToRedeemTabState();
}

class _ToRedeemTabState extends BaseStatefulState<ToRedeemTab> {
  RewardModel _rewardDetails = RewardModel();

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  Widget body() {
    return Skeletonizer(
      enabled: widget.isLoading,
      child: getToRedeemRewards(
        rewardList: widget.isLoading
            ? List.generate(5, (_) => RewardModel(rewardName: 'Loading...'))
            : widget.rewardList,
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ToRedeemTabState {
  void showRewardBottomSheet({required RewardModel rewardDetails}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return getBottomSheetCard(rewardDetails: rewardDetails);
      },
    );
  }

  void onClaimButtonPressed(int rewardID) async {
    final rewardDetails = await tryLoad(
      context,
      () =>
          context.read<RewardViewModel>().getRewardDetails(rewardID: rewardID),
    );

    _setState(() {
      _rewardDetails = rewardDetails ?? RewardModel();
    });

    showRewardBottomSheet(rewardDetails: _rewardDetails);
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ToRedeemTabState {
  Widget getToRedeemRewards({required List<RewardModel> rewardList}) {
    return ListView.builder(
      itemCount: rewardList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Padding(
              padding: _Styles.rewardPadding,
              child: Row(
                children: [
                  getRewardImage(
                    imageURL: rewardList[index].rewardImageURL ?? '',
                  ),
                  SizedBox(width: 10),
                  getRewardDetails(
                    rewardName: rewardList[index].rewardName ?? '-',
                    pointsRequired:
                        rewardList[index].pointsRequired?.toString() ?? '0',
                  ),
                  getClaimButton(rewardID: rewardList[index].rewardID ?? 0),
                ],
              ),
            ),

            Divider(color: ColorManager.lightGreyColor),
          ],
        );
      },
    );
  }

  Widget getClaimButton({required int rewardID}) {
    return SizedBox(
      width: _Styles.claimButtonSize,
      child: CustomButton(
        text: 'Claim',
        textColor: ColorManager.primary,
        onPressed: () => onClaimButtonPressed(rewardID),
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
    return RewardBottomSheet(
      imageURL: rewardDetails.rewardImageURL ?? '',
      rewardName: rewardDetails.rewardName ?? '',
      descriptionText: rewardDetails.rewardDescription ?? '',
      buttonText: 'Claim with ${rewardDetails.pointsRequired} points',
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
