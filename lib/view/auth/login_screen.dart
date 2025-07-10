import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/enums/form_type.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_text_field.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userRole = 'Collector';
  List<PageRouteInfo> routes = [];
  List<BottomNavigationBarItem> navBarItems = [];

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
extension _Actions on _LoginScreenState {
  void onSignInButtonPressed() {
    //TODO: Implement sign-in logic

    context.router.pushAndPopUntil(
      CustomBottomNavBar(userRole: userRole),
      predicate: (route) => false,
    );
  }

  void onCreateAccountButtonPressed() {
    context.router.push(SignUpRoute());
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _LoginScreenState {
  Widget getLogo() {
    return Image.asset(
      "assets/images/GreenCycleLogo.png",
      width: _Styles.logoSize,
      height: _Styles.logoSize,
    );
  }

  Widget getTitle() {
    return Text(
      'WELCOME BACK!',
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
          SizedBox(height: 30),
          getLoginTextField(),
          getForgotPasswordText(),
          SizedBox(height: 30),
          getButtons(),
        ],
      ),
    );
  }

  Widget getCardTitleDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Login', style: _Styles.cardTitleTextStyle),
        SizedBox(height: 20),
        Text(
          'Enter email address and password to log in.',
          style: _Styles.cardDescriptionTextStyle,
        ),
      ],
    );
  }

  Widget getLoginTextField() {
    return Column(
      children: [
        CustomTextField(
          fontSize: _Styles.loginFormFieldFontSize,
          color: _Styles.loginFormFieldColor,
          title: 'Email Address',
          prefixIcon: Icon(Icons.email_outlined, color: ColorManager.greyColor),
          formName: LoginFormFieldsEnum.email.name,
        ),
        SizedBox(height: 20),
        CustomTextField(
          fontSize: _Styles.loginFormFieldFontSize,
          color: _Styles.loginFormFieldColor,
          title: 'Password',
          prefixIcon: Icon(Icons.lock_outline, color: ColorManager.greyColor),
          formName: LoginFormFieldsEnum.password.name,
        ),
      ],
    );
  }

  Widget getForgotPasswordText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          style: _Styles.forgotPasswordButtonStyle,
          child: Text(
            'Forgot Password?',
            style: _Styles.forgotPasswordTextStyle,
          ),
        ),
      ],
    );
  }

  Widget getButtons() {
    return Column(
      children: [
        CustomButton(
          text: 'Sign In',
          textColor: ColorManager.whiteColor,
          onPressed: onSignInButtonPressed,
        ),
        SizedBox(height: 12),
        CustomButton(
          text: 'Create New Account',
          textColor: ColorManager.primary,
          backgroundColor: ColorManager.whiteColor,
          borderColor: ColorManager.primary,
          onPressed: onCreateAccountButtonPressed,
        ),
      ],
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const logoSize = 100.0;
  static const loginFormFieldFontSize = 16.0;
  static const loginFormFieldColor = ColorManager.blackColor;

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

  static const forgotPasswordTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
    decoration: TextDecoration.underline,
    decorationColor: ColorManager.primary,
  );

  static final forgotPasswordButtonStyle = ButtonStyle(
    overlayColor: WidgetStateProperty.all(Colors.transparent),
  );

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );
}
