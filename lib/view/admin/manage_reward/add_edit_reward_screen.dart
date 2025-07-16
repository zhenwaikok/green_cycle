import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/enums/form_type.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_text_field.dart';
import 'package:green_cycle_fyp/widget/image_picker_widget.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class AddOrEditRewardScreen extends StatefulWidget {
  const AddOrEditRewardScreen({super.key, required this.isEdit});

  final bool isEdit;

  @override
  State<AddOrEditRewardScreen> createState() => _AddEditRewardScreenState();
}

class _AddEditRewardScreenState extends State<AddOrEditRewardScreen> {
  File? selectedImage;
  double sliderValue = 100;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.isEdit ? 'Edit Reward Content' : 'Add Reward Content',
        isBackButtonVisible: true,
        onPressed: onBackButtonPressed,
      ),
      bottomNavigationBar: Padding(
        padding: _Styles.screenPadding,
        child: getAddButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: _Styles.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!widget.isEdit) ...[
                  getTitleDescription(),
                  SizedBox(height: 35),
                ],
                getPhotoField(),
                SizedBox(height: 25),
                getRewardTitleField(),
                SizedBox(height: 25),
                getRewardDescriptionField(),
                SizedBox(height: 25),
                getPointsRequiredField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _AddEditRewardScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  Future<void> onPhotoUploadPressed() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      _setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  void onSliderChanged(double value) {
    _setState(() {
      sliderValue = value;
    });
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _AddEditRewardScreenState {
  Widget getTitleDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Add Reward', style: _Styles.titleTextStyle),
        Text(
          'Fill in the details below to add reward.',
          style: _Styles.descriptionTextStyle,
        ),
      ],
    );
  }

  Widget getPhotoField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Reward Photo', style: _Styles.titleTextStyle),
        SizedBox(height: 10),
        PhotoPicker(
          borderRadius: _Styles.borderRadius,
          onTap: () {
            onPhotoUploadPressed();
          },
          selectedImage: selectedImage ?? File(''),
        ),
      ],
    );
  }

  Widget getRewardTitleField() {
    return CustomTextField(
      title: 'Reward Title',
      fontSize: 18,
      color: ColorManager.primary,
      formName: AddEditRewardFormFieldsEnum.rewardTitle.name,
    );
  }

  Widget getRewardDescriptionField() {
    return CustomTextField(
      title: 'Reward Description',
      maxLines: 3,
      fontSize: 18,
      color: ColorManager.primary,
      formName: AddEditRewardFormFieldsEnum.rewardDescription.name,
    );
  }

  Widget getAddButton() {
    return CustomButton(
      text: widget.isEdit ? 'Save' : 'Add',
      textColor: ColorManager.whiteColor,
      onPressed: () {},
    );
  }

  Widget getPointsRequiredField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Points Required: ',
            style: _Styles.titleTextStyle,
            children: [
              TextSpan(
                text: '${sliderValue.round()}',
                style: _Styles.pointsTextStyle,
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Slider(
          padding: _Styles.sliderPadding,
          activeColor: ColorManager.primary,
          value: sliderValue,
          min: 0,
          max: 500,
          onChanged: (value) {
            onSliderChanged(value);
          },
        ),
      ],
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const borderRadius = 15.0;

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const sliderPadding = EdgeInsets.zero;

  static const titleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const descriptionTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const pointsTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.greyColor,
  );
}
