import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';

@RoutePage()
class CollectorDetailsScreen extends StatefulWidget {
  const CollectorDetailsScreen({super.key});

  @override
  State<CollectorDetailsScreen> createState() => _CollectorDetailsScreenState();
}

class _CollectorDetailsScreenState extends State<CollectorDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Collector Details',
        isBackButtonVisible: true,
        onPressed: onBackButtonPressed,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: _Styles.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getCollectorImage(),
                SizedBox(height: 20),
                getCollectorNameOrganization(),
                SizedBox(height: 60),
                getCollectorDetails(),
                SizedBox(height: 40),
                getRejectApproveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CollectorDetailsScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  void onApproveButtonPressed() {
    WidgetUtil.showAlertDialog(
      context,
      title: 'Approval Confirmation',
      content: 'Are you sure to approve this collector\'s profile?',
      actions: [
        getAlertDialogTextButton(onPressed: () {}, text: 'Cancel'),
        getAlertDialogTextButton(onPressed: () {}, text: 'Submit'),
      ],
    );
  }

  void onDeleteButtonPressed() {
    WidgetUtil.showAlertDialog(
      context,
      title: 'Please provide the reason for rejecting this collector',
      maxLines: _Styles.maxLines,
      needTextField: true,
      actions: [
        getAlertDialogTextButton(onPressed: () {}, text: 'Cancel'),
        getAlertDialogTextButton(onPressed: () {}, text: 'Submit'),
      ],
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CollectorDetailsScreenState {
  Widget getCollectorImage() {
    return Center(
      child: CustomImage(
        imageSize: _Styles.imageSize,
        borderRadius: _Styles.borderRadius,
        imageURL:
            'https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D',
      ),
    );
  }

  Widget getCollectorNameOrganization() {
    return Center(
      child: Column(
        children: [
          Text('Collector Name', style: _Styles.collectorNameTextStyle),
          Text('Company/Organization', style: _Styles.companyTextStyle),
        ],
      ),
    );
  }

  Widget getCollectorDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTitleDescription(
          title: 'Email Address',
          description: 'xxx@gmail.com',
        ),
        SizedBox(height: 30),
        getTitleDescription(title: 'Gender', description: 'Male'),
        SizedBox(height: 30),
        getTitleDescription(
          title: 'Phone Number',
          description: '+601919162626',
        ),
        SizedBox(height: 30),
        getTitleDescription(title: 'Vehicle Type', description: 'Van'),
        SizedBox(height: 30),
        getTitleDescription(
          title: 'Vehicle Plate Number',
          description: 'WWX 4451',
        ),
      ],
    );
  }

  Widget getTitleDescription({
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: _Styles.titleTextStyle),
        Text(description, style: _Styles.descriptionTextStyle),
      ],
    );
  }

  Widget getRejectApproveButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: CustomButton(
            text: 'Reject',
            textColor: ColorManager.redColor,
            onPressed: onDeleteButtonPressed,
            borderColor: ColorManager.redColor,
            backgroundColor: ColorManager.whiteColor,
            icon: Icon(
              Icons.close,
              color: ColorManager.redColor,
              size: _Styles.iconSize,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: CustomButton(
            text: 'Approve',
            textColor: ColorManager.primary,
            onPressed: onApproveButtonPressed,
            borderColor: ColorManager.primary,
            backgroundColor: ColorManager.whiteColor,
            icon: Icon(
              Icons.check_rounded,
              color: ColorManager.primary,
              size: _Styles.iconSize,
            ),
          ),
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
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const imageSize = 130.0;
  static const borderRadius = 70.0;
  static const iconSize = 25.0;
  static const maxLines = 6;

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const collectorNameTextStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const companyTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const titleTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const descriptionTextStyle = TextStyle(
    fontSize: 18,
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
