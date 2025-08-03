import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/reward/reward_model.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/reward_repository.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/reward_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_sort_by.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class ManageRewardsScreen extends StatelessWidget {
  const ManageRewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RewardViewModel(
        rewardRepository: RewardRepository(),
        firebaseRepository: FirebaseRepository(
          firebaseServices: FirebaseServices(),
        ),
      ),
      child: _ManageRewardsScreen(),
    );
  }
}

class _ManageRewardsScreen extends BaseStatefulPage {
  @override
  State<_ManageRewardsScreen> createState() => _ManageRewardsScreenState();
}

class _ManageRewardsScreenState
    extends BaseStatefulState<_ManageRewardsScreen> {
  final sortByItems = DropDownItems.sortByItems;
  String? selectedSort;
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
    selectedSort = sortByItems.first;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialLoad();
    });
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Rewards Management',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
      actions: [getPlusIconButton()],
    );
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  Widget body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getSortBy(),
        SizedBox(height: 15),
        Expanded(
          child: getRewardList(
            rewardList: _isLoading
                ? List.generate(5, (_) => RewardModel(rewardName: 'Loading...'))
                : _rewardList,
            isLoading: _isLoading,
          ),
        ),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ManageRewardsScreenState {
  Future<void> initialLoad() async {
    final rewardList = await tryLoad(
      context,
      () => context.read<RewardViewModel>().getRewardList(),
    );

    _setState(() {
      _isLoading = true;
    });

    if (rewardList != null) {
      _setState(() {
        _rewardList = rewardList;
      });
    }

    _setState(() {
      _isLoading = false;
    });
  }

  void onBackButtonPressed() {
    context.router.maybePop();
  }

  void onSortByChanged(String? value) {
    _setState(() {
      selectedSort = value;
    });
  }

  void onPlusButtonPressed() {
    context.router.push(AddOrEditRewardRoute(isEdit: false));
  }

  void onDeleteButtonPressed() {
    WidgetUtil.showAlertDialog(
      context,
      title: 'Delete Confirmation',
      content: 'Are you sure to delete this reward?',
      actions: [
        getAlertDialogTextButton(onPressed: () {}, text: 'Cancel'),
        getAlertDialogTextButton(onPressed: () {}, text: 'Yes'),
      ],
    );
  }

  void onRewardCardPressed({required RewardModel rewardDetails}) async {
    showModalBottomSheet(
      backgroundColor: ColorManager.whiteColor,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return getRewardDetailsBottomSheet(rewardDetails: rewardDetails);
      },
    );
  }

  void onEditButtonPressed({required int rewardId}) async {
    await context.router.maybePop();
    if (mounted) {
      final result = await context.router.push(
        AddOrEditRewardRoute(isEdit: true, rewardId: rewardId),
      );

      if (result == true && mounted) {
        initialLoad();
      }
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ManageRewardsScreenState {
  Widget getPlusIconButton() {
    return IconButton(
      onPressed: onPlusButtonPressed,
      icon: Icon(Icons.add, color: Colors.white),
    );
  }

  Widget getSortBy() {
    return CustomSortBy(
      sortByItems: sortByItems,
      selectedValue: selectedSort,
      onChanged: (value) {
        onSortByChanged(value);
      },
    );
  }

  Widget getRewardList({
    required List<RewardModel> rewardList,
    required bool isLoading,
  }) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: rewardList.length,
      itemBuilder: (context, index) {
        return TouchableOpacity(
          onPressed: () =>
              onRewardCardPressed(rewardDetails: rewardList[index]),
          child: getRewardCard(reward: rewardList[index], isLoading: isLoading),
        );
      },
    );
  }

  Widget getRewardCard({required RewardModel reward, required bool isLoading}) {
    return Padding(
      padding: _Styles.cardPadding,
      child: CustomCard(
        padding: _Styles.customCardPadding,
        child: Skeletonizer(
          enabled: isLoading,
          child: Row(
            children: [
              getRewardImage(imageURL: reward.rewardImageURL ?? ''),
              SizedBox(width: 20),
              Expanded(
                child: getRewardDetails(
                  rewardName: reward.rewardName ?? '',
                  pointsRequired: reward.pointsRequired ?? 0,
                ),
              ),
              SizedBox(width: 15),
              IconButton(
                onPressed: onDeleteButtonPressed,
                icon: Icon(Icons.delete, color: ColorManager.redColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getRewardImage({required String imageURL}) {
    return CustomImage(
      imageSize: _Styles.imageSize,
      borderRadius: _Styles.imageBorderRadius,
      imageURL: imageURL,
    );
  }

  Widget getRewardDetails({
    required String rewardName,
    required int pointsRequired,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          rewardName,
          style: _Styles.rewardNameTextStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 10),
        Text(
          'Required: $pointsRequired pts',
          style: _Styles.pointRequiredTextStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
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

  Widget getRewardDetailsBottomSheet({required RewardModel rewardDetails}) {
    return Padding(
      padding: _Styles.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImage(
            borderRadius: _Styles.imageBorderRadius,
            imageSize: _Styles.detailsImageSize,
            imageWidth: double.infinity,
            imageURL: rewardDetails.rewardImageURL ?? '',
          ),
          SizedBox(height: 15),
          Text(
            rewardDetails.rewardName ?? '',
            style: _Styles.rewardDetailsNameTextStyle,
          ),
          Text(
            '${rewardDetails.pointsRequired} pts required',
            style: _Styles.pointRequiredTextStyle,
          ),
          SizedBox(height: 20),
          Text(
            rewardDetails.rewardDescription ?? '',
            style: _Styles.descriptionTextStyle,
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getBottomSheetActionButton(
                color: ColorManager.primary,
                icon: Icon(
                  Icons.edit,
                  color: ColorManager.whiteColor,
                  size: _Styles.iconButtonSize,
                ),
                onPressed: () =>
                    onEditButtonPressed(rewardId: rewardDetails.rewardID ?? 0),
              ),
              getBottomSheetActionButton(
                color: ColorManager.redColor,
                icon: Icon(
                  Icons.delete,
                  color: ColorManager.whiteColor,
                  size: _Styles.iconButtonSize,
                ),
                onPressed: onDeleteButtonPressed,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getBottomSheetActionButton({
    required Color color,
    required Icon icon,
    required void Function() onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: IconButton(onPressed: onPressed, icon: icon),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const imageSize = 60.0;
  static const detailsImageSize = 150.0;
  static const imageBorderRadius = 10.0;
  static const iconButtonSize = 20.0;

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const customCardPadding = EdgeInsets.all(10);
  static const cardPadding = EdgeInsets.symmetric(vertical: 10, horizontal: 5);

  static const rewardNameTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const pointRequiredTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static final textButtonStyle = ButtonStyle(
    overlayColor: WidgetStateProperty.all(ColorManager.lightGreyColor2),
  );

  static const textButtonTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const rewardDetailsNameTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const descriptionTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );
}
