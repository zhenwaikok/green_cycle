import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/enums/form_type.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_text_field.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserViewModel(
        userRepository: UserRepository(
          sharePreferenceHandler: SharedPreferenceHandler(),
          userServices: UserServices(),
        ),
        firebaseRepository: FirebaseRepository(
          firebaseServices: FirebaseServices(),
        ),
      ),
      child: _ChangePasswordScreen(),
    );
  }
}

class _ChangePasswordScreen extends BaseStatefulPage {
  @override
  State<_ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState
    extends BaseStatefulState<_ChangePasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Change Password',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  Widget bottomNavigationBar() {
    return getSaveButton();
  }

  @override
  Widget body() {
    return SingleChildScrollView(
      child: FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            getChangePasswordLogoText(),
            SizedBox(height: 40),
            getPasswordTextFields(),
          ],
        ),
      ),
    );
  }
}

// * ---------------------------- Helper ----------------------------
extension _Helpers on _ChangePasswordScreenState {
  String get currentPassword => _formKey
      .currentState
      ?.fields[ChangePasswordFormFieldsEnum.currentPassword.name]
      ?.value;

  String get newPassword => _formKey
      .currentState
      ?.fields[ChangePasswordFormFieldsEnum.newPassword.name]
      ?.value;
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ChangePasswordScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  Future<void> onSaveButtonPressed() async {
    final formValid = _formKey.currentState?.saveAndValidate() ?? false;
    if (formValid) {
      final result =
          await tryLoad(
            context,
            () => context.read<UserViewModel>().updateAccountPassword(
              oldPassword: currentPassword,
              newPassword: newPassword,
            ),
          ) ??
          false;

      if (result) {
        unawaited(
          WidgetUtil.showSnackBar(text: 'Password changed successfully'),
        );
        if (mounted) await context.router.maybePop();
      }
    }
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
          formName: ChangePasswordFormFieldsEnum.currentPassword.name,
          prefixIcon: Icon(Icons.lock, color: ColorManager.blackColor),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(6),
          ]),
        ),
        SizedBox(height: 20),
        CustomTextField(
          fontSize: 15,
          color: ColorManager.blackColor,
          title: 'New Password',
          formName: ChangePasswordFormFieldsEnum.newPassword.name,
          prefixIcon: Icon(Icons.lock, color: ColorManager.blackColor),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(6),
          ]),
        ),
        SizedBox(height: 20),
        CustomTextField(
          fontSize: 15,
          color: ColorManager.blackColor,
          title: 'Confirm New Password',
          formName: ChangePasswordFormFieldsEnum.confirmNewPassword.name,
          prefixIcon: Icon(Icons.lock, color: ColorManager.blackColor),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            (value) {
              final password = _formKey
                  .currentState
                  ?.fields[ChangePasswordFormFieldsEnum.newPassword.name]
                  ?.value;
              if (password != value) {
                return 'Password does not match';
              }
              return null;
            },
          ]),
        ),
      ],
    );
  }

  Widget getSaveButton() {
    return CustomButton(
      text: 'Save',
      textColor: ColorManager.whiteColor,
      onPressed: onSaveButtonPressed,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const logoSize = 200.0;

  static const descTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );
}
