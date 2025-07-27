import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_sort_by.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';

@RoutePage()
class ManageRewardsScreen extends StatefulWidget {
  const ManageRewardsScreen({super.key});

  @override
  State<ManageRewardsScreen> createState() => _ManageRewardsScreenState();
}

class _ManageRewardsScreenState extends State<ManageRewardsScreen> {
  final List<String> sortByItems = ['All', 'Oldest', 'Latest'];

  String? selectedSort;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    selectedSort = sortByItems.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Rewards Management',
        isBackButtonVisible: true,
        onPressed: onBackButtonPressed,
        actions: [getPlusIconButton()],
      ),

      body: SafeArea(
        child: Padding(
          padding: _Styles.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getSortBy(),
              SizedBox(height: 15),
              Expanded(child: getRewardList()),
            ],
          ),
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ManageRewardsScreenState {
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

  void onRewardCardPressed() async {
    showModalBottomSheet(
      backgroundColor: ColorManager.whiteColor,
      context: context,
      builder: (context) {
        return getRewardDetailsBottomSheet();
      },
    );
  }

  void onEditButtonPressed() {
    context.router.push(AddOrEditRewardRoute(isEdit: true));
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

  Widget getRewardList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return TouchableOpacity(
          onPressed: onRewardCardPressed,
          child: getRewardCard(),
        );
      },
    );
  }

  Widget getRewardCard() {
    return Padding(
      padding: _Styles.cardPadding,
      child: CustomCard(
        padding: _Styles.customCardPadding,
        child: Row(
          children: [
            getRewardImage(),
            SizedBox(width: 20),
            Expanded(child: getRewardDetails()),
            SizedBox(width: 15),
            IconButton(
              onPressed: onDeleteButtonPressed,
              icon: Icon(Icons.delete, color: ColorManager.redColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget getRewardImage() {
    return CustomImage(
      imageSize: _Styles.imageSize,
      borderRadius: _Styles.imageBorderRadius,
      imageURL:
          'https://img.freepik.com/free-photo/purple-open-gift-box-with-voucher-bonus-surprise-minimal-present-greeting-celebration-promotion-discount-sale-reward-icon-3d-illustration_56104-2100.jpg?semt=ais_hybrid&w=740',
    );
  }

  Widget getRewardDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reward Name',
          style: _Styles.rewardNameTextStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          'Required: 100 pts',
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

  Widget getRewardDetailsBottomSheet() {
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
            imageURL:
                'https://img.freepik.com/free-photo/purple-open-gift-box-with-voucher-bonus-surprise-minimal-present-greeting-celebration-promotion-discount-sale-reward-icon-3d-illustration_56104-2100.jpg?semt=ais_hybrid&w=740',
          ),
          SizedBox(height: 15),
          Text(
            'Reward Name asdasdasda',
            style: _Styles.rewardDetailsNameTextStyle,
          ),
          Text('150 pts required', style: _Styles.pointRequiredTextStyle),
          SizedBox(height: 20),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc varius urna eu ultricies egestas.',
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
                onPressed: onEditButtonPressed,
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
