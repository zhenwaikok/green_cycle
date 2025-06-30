import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/enums/form_type.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_text_field.dart';

@RoutePage()
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: _Styles.screenPadding,
        child: CustomButton(
          text: 'Save',
          textColor: ColorManager.whiteColor,
          onPressed: () {},
        ),
      ),
      appBar: CustomAppBar(
        title: 'Change Password',
        isBackButtonVisible: true,
        onPressed: onBackButtonPressed,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: _Styles.screenPadding,
            child: Column(
              children: [
                getChangePasswordLogoText(),
                SizedBox(height: 40),
                getPasswordTextFields(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ChangePasswordScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ChangePasswordScreenState {
  Widget getChangePasswordLogoText() {
    return Column(
      children: [
        Image.asset(
          width: double.infinity,
          height: _Styles.logoSize,
          'assets/images/changepwdlogo.jpg',
        ),
        Text(
          'Enter your current password for verification, followed by a new password. Make sure your new password is strong and unique.',
          style: _Styles.descTextStyle,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget getPasswordTextFields() {
    return Column(
      children: [
        CustomTextField(
          fontSize: 15,
          color: ColorManager.blackColor,
          title: 'Current Password',
          formName: ChangePassowrdFormFieldsEnum.currentPassword.name,
          prefixIcon: Icon(Icons.lock, color: ColorManager.greyColor),
        ),
        SizedBox(height: 20),
        CustomTextField(
          fontSize: 15,
          color: ColorManager.blackColor,
          title: 'New Password',
          formName: ChangePassowrdFormFieldsEnum.newPassword.name,
          prefixIcon: Icon(Icons.lock, color: ColorManager.greyColor),
        ),
        SizedBox(height: 20),
        CustomTextField(
          fontSize: 15,
          color: ColorManager.blackColor,
          title: 'Confirm New Password',
          formName: ChangePassowrdFormFieldsEnum.confirmNewPassword.name,
          prefixIcon: Icon(Icons.lock, color: ColorManager.greyColor),
        ),
      ],
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const logoSize = 200.0;

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const descTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );
}
