import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/enums/form_type.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/constant/images_manager.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_text_field.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _ForgotPasswordScreen();
  }
}

class _ForgotPasswordScreen extends BaseStatefulPage {
  @override
  State<_ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends BaseStatefulState<_ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Forgot Password',
      onPressed: onBackButtonPressed,
      isBackButtonVisible: true,
    );
  }

  @override
  Widget bottomNavigationBar() {
    return getSubmitButton();
  }

  @override
  Widget body() {
    return Center(
      child: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getImage(),
            SizedBox(height: 40),
            getForgotPasswordMessage(),
            SizedBox(height: 20),
            getEmailTextField(),
          ],
        ),
      ),
    );
  }
}

// * ---------------------------- Helpers ----------------------------
extension _Helpers on _ForgotPasswordScreenState {
  String get email => _formKey
      .currentState
      ?.fields[ForgotPasswordFormFieldsEnum.email.name]
      ?.value;
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ForgotPasswordScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  void onSubmitButtonPressed() async {
    final formValid = _formKey.currentState?.saveAndValidate() ?? false;

    if (formValid) {
      final result =
          await tryLoad(
            context,
            () => context.read<UserViewModel>().passwordReset(email: email),
          ) ??
          false;

      if (result) {
        unawaited(
          WidgetUtil.showSnackBar(
            text: 'Password reset link sent to your email, please check',
          ),
        );
      }
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ForgotPasswordScreenState {
  Widget getImage() {
    return Image.asset(
      Images.forgotPasswordImage,
      width: _Styles.imageSize,
      height: _Styles.imageSize,
      fit: BoxFit.cover,
    );
  }

  Widget getForgotPasswordMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Forgot Password?', style: _Styles.titleTextStyle),
        SizedBox(height: 10),
        Text(
          'Don\'t worry, it happens! Enter the email address associated with your account.',
          style: _Styles.messageTextStyle,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget getEmailTextField() {
    return CustomTextField(
      needTitle: false,
      prefixIcon: Icon(Icons.email_outlined, color: ColorManager.blackColor),
      formName: ForgotPasswordFormFieldsEnum.email.name,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.email(),
      ]),
    );
  }

  Widget getSubmitButton() {
    return CustomButton(
      text: 'Submit',
      textColor: ColorManager.whiteColor,
      onPressed: onSubmitButtonPressed,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const imageSize = 300.0;

  static const titleTextStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const messageTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );
}
