import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/enums/form_type.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_dropdown.dart';
import 'package:green_cycle_fyp/widget/custom_text_field.dart';
import 'package:green_cycle_fyp/widget/image_picker_widget.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class CollectorAdditionalSignupScreen extends StatefulWidget {
  const CollectorAdditionalSignupScreen({super.key});

  @override
  State<CollectorAdditionalSignupScreen> createState() =>
      _CollectorAdditionalSignupScreenState();
}

class _CollectorAdditionalSignupScreenState
    extends State<CollectorAdditionalSignupScreen> {
  File? selectedImage;
  List<String> vehicleTypes = ['Car', 'Truck', 'Van'];

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Collector Additional Info',
        onPressed: backButtononPressed,
        isBackButtonVisible: true,
      ),
      bottomNavigationBar: Padding(
        padding: _Styles.screenPadding,
        child: CustomButton(
          text: 'Submit for Approval',
          textColor: ColorManager.whiteColor,
          onPressed: () {},
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: _Styles.screenPadding,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getVehicleTypeDropdown(),
                  SizedBox(height: 20),
                  getVehiclePlateNumberTextField(),
                  SizedBox(height: 20),
                  getCompanyTextField(),
                  SizedBox(height: 20),
                  getFacePhotoField(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CollectorAdditionalSignupScreenState {
  void backButtononPressed() {
    context.router.maybePop();
  }

  Future<void> onFacePhotoUploadPressed() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      _setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CollectorAdditionalSignupScreenState {
  Widget getVehicleTypeDropdown() {
    return CustomDropdown(
      formName: SignUpFormFieldsEnum.vehicleType.name,
      items: vehicleTypes,
      title: 'Vehicle Type',
      fontSize: _Styles.fontSize,
      color: ColorManager.primary,
    );
  }

  Widget getVehiclePlateNumberTextField() {
    return CustomTextField(
      fontSize: _Styles.fontSize,
      color: ColorManager.primary,
      title: 'Vehicle Plate Number',
      formName: SignUpFormFieldsEnum.vehiclePlateNum.name,
    );
  }

  Widget getCompanyTextField() {
    return CustomTextField(
      fontSize: _Styles.fontSize,
      color: ColorManager.primary,
      title: 'Company/Organization',
      formName: SignUpFormFieldsEnum.organizationName.name,
    );
  }

  Widget getFacePhotoField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Upload A Clear Face Photo', style: _Styles.titleTextStyle),
        SizedBox(height: 10),
        PhotoPicker(
          onTap: () {
            onFacePhotoUploadPressed();
          },
          selectedImage: selectedImage ?? File(''),
        ),
      ],
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const fontSize = 16.0;

  static const titleTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );
}
