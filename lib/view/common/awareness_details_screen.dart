import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/bottom_sheet_action.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';

@RoutePage()
class AwarenessDetailsScreen extends StatefulWidget {
  const AwarenessDetailsScreen({super.key, required this.userRole});

  final String userRole;

  @override
  State<AwarenessDetailsScreen> createState() => _AwarenessDetailsScreenState();
}

class _AwarenessDetailsScreenState extends State<AwarenessDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Awareness Details',
        isBackButtonVisible: true,
        onPressed: onBackButtonPressed,
        actions: [
          if (widget.userRole == 'Admin')
            IconButton(
              onPressed: onMoreButtonPressed,
              icon: Icon(Icons.more_horiz, color: ColorManager.whiteColor),
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: _Styles.screenPadding,
            child: getAwarenessDetails(),
          ),
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _AwarenessDetailsScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  void onEditButtonPressed() {
    context.router.push(AddOrEditAwarenessRoute(isEdit: true));
  }

  void onMoreButtonPressed() async {
    showModalBottomSheet(
      backgroundColor: ColorManager.whiteColor,
      context: context,
      builder: (context) {
        return getMoreBottomSheet();
      },
    );
  }

  void onRemovePressed() async {
    WidgetUtil.showAlertDialog(
      context,
      title: 'Delete Confirmation',
      content: 'Are you sure you want to delete this awareness content?',
      actions: [
        getAlertDialogTextButton(onPressed: () {}, text: 'Cancel'),
        getAlertDialogTextButton(onPressed: () {}, text: 'Confirm'),
      ],
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _AwarenessDetailsScreenState {
  Widget getAwarenessDetails() {
    return Column(
      children: [
        getImage(),
        SizedBox(height: 25),
        getTitleDate(),
        SizedBox(height: 30),
        getDescription(),
      ],
    );
  }

  Widget getImage() {
    return CustomImage(
      imageURL:
          'https://images.pexels.com/photos/1667088/pexels-photo-1667088.jpeg',
      borderRadius: _Styles.borderRadius,
      imageWidth: double.infinity,
      imageSize: MediaQuery.of(context).size.height * 0.4,
    );
  }

  Widget getTitleDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MyGOV Malaysia Mobile App Set To Transform Public Service Delivery',
          style: _Styles.awarenessTitleTextStyle,
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Icon(
              Icons.access_time,
              color: ColorManager.greyColor,
              size: _Styles.iconSize,
            ),
            SizedBox(width: 5),
            Text('21/2/2025', style: _Styles.dateTextStyle),
          ],
        ),
      ],
    );
  }

  Widget getDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description:', style: _Styles.descTitleTextStyle),
        SizedBox(height: 5),
        Text(
          'ISLAMABAD: Prime Minister Shehbaz Sharif on Sunday inaugurated a mobile application that allows power consumers in Pakistan to record and submit their meter readings themselves, with the government saying the initiative will introduce more transparency in the electricity system and reduce overbilling. Electricity bills are generated in Pakistan every month by readings obtained from power meters installed at homes and businesses. These readings show the number of electricity units consumed during a monthly cycle and are taken by meter readers employed by power companies. ',
          style: _Styles.descTextStyle,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget getMoreBottomSheet() {
    return Padding(
      padding: _Styles.screenPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetAction(
            icon: Icons.edit,
            color: ColorManager.blackColor,
            text: 'Edit',
            onTap: onEditButtonPressed,
          ),
          SizedBox(height: 10),
          BottomSheetAction(
            icon: Icons.delete_outline,
            color: ColorManager.redColor,
            text: 'Remove',
            onTap: onRemovePressed,
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

  static const borderRadius = 15.0;
  static const iconSize = 20.0;

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const awarenessTitleTextStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const dateTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const descTitleTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const descTextStyle = TextStyle(
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
