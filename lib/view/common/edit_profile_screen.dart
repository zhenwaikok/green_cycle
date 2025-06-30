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
import 'package:green_cycle_fyp/widget/profile_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

@RoutePage()
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.selectedRole});

  final String selectedRole;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final List<String> roles = ['Customer', 'Collector'];
  final List<String> genders = ['Male', 'Female'];

  File? selectedImage;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Edit Profile',
        isBackButtonVisible: true,
        onPressed: onBackButtonPressed,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: _Styles.screenPadding,
            child: Center(
              child: Column(
                children: [
                  getProfileImage(),
                  SizedBox(height: 60),
                  getProfileTextFields(),
                  SizedBox(height: 50),
                  getButton(),
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
extension _Actions on _EditProfileScreenState {
  void onBackButtonPressed() {
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
extension _WidgetFactories on _EditProfileScreenState {
  Widget getProfileImage() {
    return Stack(
      children: [
        CustomProfileImage(
          imageFile: selectedImage,
          imageURL: selectedImage == null
              ? 'https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D'
              : null,
          imageSize: _Styles.imageSize,
        ),
        Positioned(
          bottom: -2,
          left: 90,
          child: Container(
            decoration: BoxDecoration(
              color: ColorManager.lightGreyColor2,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: onFacePhotoUploadPressed,
              icon: Icon(
                Icons.camera_alt,
                color: ColorManager.greyColor,
                size: _Styles.cameraIconSize,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getProfileTextFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCustomerNameTextField(),
        SizedBox(height: 20),
        getEmailText(),
        SizedBox(height: 20),
        getGenderDropdown(),
        SizedBox(height: 20),
        getPhoneTextField(),
        SizedBox(height: 10),
        getPasswordTextField(),
      ],
    );
  }

  Widget getGenderDropdown() {
    return CustomDropdown(
      formName: EditProfileFormFieldsEnum.gender.name,
      items: genders,
      title: 'Gender',
      fontSize: _Styles.editProfileFormFieldFontSize,
      color: _Styles.editProfileFormFieldColor,
    );
  }

  Widget getEmailText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email Address', style: _Styles.emailTitleTextStyle),
        SizedBox(height: 10),
        Text('xxx@gmail.com', style: _Styles.emailTextStyle),
      ],
    );
  }

  Widget getCustomerNameTextField() {
    if (widget.selectedRole != 'Customer') {
      return CustomTextField(
        fontSize: _Styles.editProfileFormFieldFontSize,
        color: _Styles.editProfileFormFieldColor,
        title: 'Full Name',
        formName: EditProfileFormFieldsEnum.name.name,
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: CustomTextField(
              fontSize: _Styles.editProfileFormFieldFontSize,
              color: _Styles.editProfileFormFieldColor,
              title: 'First Name',
              formName: EditProfileFormFieldsEnum.name.name,
            ),
          ),
          SizedBox(width: 25),
          Expanded(
            child: CustomTextField(
              fontSize: _Styles.editProfileFormFieldFontSize,
              color: _Styles.editProfileFormFieldColor,
              title: 'Last Name',
              formName: EditProfileFormFieldsEnum.name.name,
            ),
          ),
        ],
      );
    }
  }

  Widget getPhoneTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Phone Number', style: _Styles.phoneNumTextStyle),
        SizedBox(height: 10),
        IntlPhoneField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            contentPadding: _Styles.contentPadding,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorManager.greyColor,
                width: _Styles.textFieldBorderWidth,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorManager.greyColor,
                width: _Styles.textFieldBorderWidth,
              ),
            ),
            errorBorder: _Styles.outlineErrorInputBorder,
            focusedErrorBorder: _Styles.outlineErrorInputBorder,
          ),
          initialCountryCode: 'MY',
          cursorColor: ColorManager.blackColor,
          onChanged: (phone) {
            //TODO: Handle phone number change
          },
        ),
      ],
    );
  }

  Widget getPasswordTextField() {
    return CustomTextField(
      fontSize: _Styles.editProfileFormFieldFontSize,
      color: _Styles.editProfileFormFieldColor,
      title: 'Password',
      prefixIcon: Icon(Icons.lock_outline, color: ColorManager.greyColor),
      formName: SignUpFormFieldsEnum.password.name,
    );
  }

  Widget getButton() {
    return CustomButton(
      text: 'Save',
      textColor: ColorManager.whiteColor,
      onPressed: () {},
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const cameraIconSize = 25.0;
  static const imageSize = 150.0;

  static const editProfileFormFieldFontSize = 16.0;
  static const editProfileFormFieldColor = ColorManager.blackColor;
  static const textFieldBorderWidth = 2.0;

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static final outlineErrorInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: ColorManager.redColor),
  );

  static const contentPadding = EdgeInsets.symmetric(horizontal: 10);

  static const phoneNumTextStyle = TextStyle(
    fontSize: editProfileFormFieldFontSize,
    fontWeight: FontWeightManager.bold,
    color: editProfileFormFieldColor,
  );

  static const emailTitleTextStyle = TextStyle(
    fontSize: editProfileFormFieldFontSize,
    fontWeight: FontWeightManager.bold,
    color: editProfileFormFieldColor,
  );

  static const emailTextStyle = TextStyle(
    fontSize: editProfileFormFieldFontSize,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );
}
