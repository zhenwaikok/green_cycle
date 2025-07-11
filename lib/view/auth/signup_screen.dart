import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/enums/form_type.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_dropdown.dart';
import 'package:green_cycle_fyp/widget/custom_text_field.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final List<String> roles = ['Customer', 'Collector'];
  final List<String> genders = ['Male', 'Female'];
  String? selectedRole;

  @override
  void initState() {
    selectedRole = roles.first;
    super.initState();
  }

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: _Styles.screenPadding,
            child: Center(
              child: Column(
                children: [
                  getLogo(),
                  SizedBox(height: 15),
                  getTitle(),
                  SizedBox(height: 30),
                  getCard(),
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
extension _Actions on _SignUpScreenState {
  void onRoleChanged(String? value) {
    _setState(() {
      selectedRole = value;
    });
  }

  void onSignInButtonPressed() {
    context.router.push(LoginRoute());
  }

  void onSignUpButtonPressed() {
    context.router.push(CollectorAdditionalSignupRoute());
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _SignUpScreenState {
  Widget getLogo() {
    return Image.asset(
      "assets/images/GreenCycleLogo.png",
      width: _Styles.logoSize,
      height: _Styles.logoSize,
    );
  }

  Widget getTitle() {
    return Text(
      'JOIN US!',
      style: _Styles.titleTextStyle,
      textAlign: TextAlign.center,
    );
  }

  Widget getCard() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getCardTitleDescription(),
          SizedBox(height: 20),
          getSignUpTextField(),
          SizedBox(height: 20),
          getTextField(),
        ],
      ),
    );
  }

  Widget getCardTitleDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sign Up', style: _Styles.cardTitleTextStyle),
        SizedBox(height: 20),
        Text(
          'Enter details below to create an account.',
          style: _Styles.cardDescriptionTextStyle,
        ),
      ],
    );
  }

  Widget getSignUpTextField() {
    return Column(
      children: [
        CustomDropdown(
          formName: SignUpFormFieldsEnum.role.name,
          items: roles,
          title: 'Role',
          fontSize: _Styles.signUpFormFieldFontSize,
          color: _Styles.signUpFormFieldColor,
          onChanged: (value) {
            onRoleChanged(value);
          },
        ),
      ],
    );
  }

  Widget getTextField() {
    return Column(
      children: [
        getCustomerNameTextField(),
        SizedBox(height: 20),
        getEmailTextField(),
        SizedBox(height: 20),
        getGenderDropdown(),
        SizedBox(height: 20),
        getPhoneTextField(),
        SizedBox(height: 20),
        getPasswordTextField(),
        SizedBox(height: 30),
        getButtons(),
      ],
    );
  }

  Widget getGenderDropdown() {
    return CustomDropdown(
      formName: SignUpFormFieldsEnum.gender.name,
      items: genders,
      title: 'Gender',
      fontSize: _Styles.signUpFormFieldFontSize,
      color: _Styles.signUpFormFieldColor,
    );
  }

  Widget getEmailTextField() {
    return CustomTextField(
      fontSize: _Styles.signUpFormFieldFontSize,
      color: _Styles.signUpFormFieldColor,
      title: 'Email Address',
      prefixIcon: Icon(Icons.email_outlined, color: ColorManager.greyColor),
      formName: SignUpFormFieldsEnum.email.name,
    );
  }

  Widget getCustomerNameTextField() {
    if (selectedRole != 'Customer') {
      return CustomTextField(
        fontSize: _Styles.signUpFormFieldFontSize,
        color: _Styles.signUpFormFieldColor,
        title: 'Full Name',
        formName: SignUpFormFieldsEnum.name.name,
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: CustomTextField(
              fontSize: _Styles.signUpFormFieldFontSize,
              color: _Styles.signUpFormFieldColor,
              title: 'First Name',
              formName: SignUpFormFieldsEnum.name.name,
            ),
          ),
          SizedBox(width: 25),
          Expanded(
            child: CustomTextField(
              fontSize: _Styles.signUpFormFieldFontSize,
              color: _Styles.signUpFormFieldColor,
              title: 'Last Name',
              formName: SignUpFormFieldsEnum.name.name,
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
    return Column(
      children: [
        CustomTextField(
          fontSize: _Styles.signUpFormFieldFontSize,
          color: _Styles.signUpFormFieldColor,
          title: 'Password',
          prefixIcon: Icon(Icons.lock_outline, color: ColorManager.greyColor),
          formName: SignUpFormFieldsEnum.password.name,
        ),
        SizedBox(height: 20),
        CustomTextField(
          fontSize: _Styles.signUpFormFieldFontSize,
          color: _Styles.signUpFormFieldColor,
          title: 'Confirm Password',
          prefixIcon: Icon(Icons.lock_outline, color: ColorManager.greyColor),
          formName: SignUpFormFieldsEnum.confirmPassword.name,
        ),
      ],
    );
  }

  Widget getButtons() {
    return Column(
      children: [
        CustomButton(
          text: 'Sign Up',
          textColor: ColorManager.whiteColor,
          onPressed: onSignUpButtonPressed,
        ),
        SizedBox(height: 12),
        CustomButton(
          text: 'Have an account? Sign In',
          textColor: ColorManager.primary,
          backgroundColor: ColorManager.whiteColor,
          borderColor: ColorManager.primary,
          onPressed: onSignInButtonPressed,
        ),
      ],
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const logoSize = 100.0;
  static const signUpFormFieldFontSize = 16.0;
  static const signUpFormFieldColor = ColorManager.blackColor;
  static const textFieldBorderWidth = 2.0;

  static const contentPadding = EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 10,
  );

  static final outlineErrorInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: ColorManager.redColor),
  );

  static const titleTextStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const cardTitleTextStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const cardDescriptionTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const phoneNumTextStyle = TextStyle(
    fontSize: signUpFormFieldFontSize,
    fontWeight: FontWeightManager.bold,
    color: signUpFormFieldColor,
  );

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );
}
