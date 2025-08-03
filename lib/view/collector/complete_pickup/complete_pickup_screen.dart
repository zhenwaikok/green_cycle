import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/image_picker_widget.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class CompletePickupScreen extends StatelessWidget {
  const CompletePickupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _CompletePickupScreen();
  }
}

class _CompletePickupScreen extends BaseStatefulPage {
  @override
  State<_CompletePickupScreen> createState() => _CompletePickupScreenState();
}

class _CompletePickupScreenState
    extends BaseStatefulState<_CompletePickupScreen> {
  File? selectedImage;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Complete Pickup',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  Widget bottomNavigationBar() {
    return getSubmitButton();
  }

  @override
  Widget body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getTitleDescription(),
          SizedBox(height: 50),
          getSelectImageOrOpenCamera(),
        ],
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CompletePickupScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  Future<void> onPhotoUploadPressed({required bool fromGallery}) async {
    final pickedFile = await ImagePicker().pickImage(
      source: fromGallery ? ImageSource.gallery : ImageSource.camera,
    );

    if (pickedFile != null) {
      _setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CompletePickupScreenState {
  Widget getTitleDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload a photo as proof of collection',
          style: _Styles.titleTextStyle,
        ),
        Text(
          'This helps ensure transparency and confirms that the pickup was successfully completed.',
          style: _Styles.descriptionTextStyle,
        ),
      ],
    );
  }

  Widget getSelectImageOrOpenCamera() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getPhotoField(),
        SizedBox(height: 30),
        Text('OR', style: _Styles.blackTextStyle),
        SizedBox(height: 30),
        getTakePhotoButton(),
      ],
    );
  }

  Widget getPhotoField() {
    return PhotoPicker(
      borderRadius: _Styles.borderRadius,
      onTap: () {
        onPhotoUploadPressed(fromGallery: true);
      },
      selectedImage: selectedImage ?? File(''),
    );
  }

  Widget getTakePhotoButton() {
    return CustomButton(
      backgroundColor: ColorManager.primaryLight,
      icon: Icon(Icons.camera_alt, color: ColorManager.primary),
      text: 'Open Camera & Take Photo',
      textColor: ColorManager.primary,

      onPressed: () {
        onPhotoUploadPressed(fromGallery: false);
      },
    );
  }

  Widget getSubmitButton() {
    return CustomButton(
      text: 'Submit',
      textColor: ColorManager.whiteColor,
      onPressed: () {},
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const borderRadius = 15.0;

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

  static const blackTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );
}
