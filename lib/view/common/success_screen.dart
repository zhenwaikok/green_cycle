import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/constant/images_manager.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.title,
    required this.message,
    required this.buttonText,
  });

  final String title;
  final String message;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return _SuccessScreen(
      title: title,
      message: message,
      buttonText: buttonText,
    );
  }
}

class _SuccessScreen extends BaseStatefulPage {
  const _SuccessScreen({
    required this.title,
    required this.message,
    required this.buttonText,
  });

  final String title;
  final String message;
  final String buttonText;

  @override
  State<_SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends BaseStatefulState<_SuccessScreen> {
  @override
  Widget bottomNavigationBar() {
    return getBottomButton(text: widget.buttonText);
  }

  @override
  Widget body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getSuccessImage(),
          SizedBox(height: 40),
          getSuccessMessage(title: widget.title, message: widget.message),
        ],
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _Actions on _SuccessScreenState {
  void onSuccessScreenButtonPressed() {
    context.router.replaceAll([
      CustomBottomNavBar(
        userRole: context.read<UserViewModel>().user?.userRole ?? '',
      ),
    ]);
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _SuccessScreenState {
  Widget getSuccessImage() {
    return Image.asset(
      Images.successTickImage,
      width: _Styles.successImageSize,
      height: _Styles.successImageSize,
      fit: BoxFit.cover,
    );
  }

  Widget getSuccessMessage({required String title, required String message}) {
    return Column(
      children: [
        Text(title, style: _Styles.titleTextStyle),
        SizedBox(height: 15),
        Text(
          message,
          style: _Styles.messageTextStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget getBottomButton({required String text}) {
    return CustomButton(
      text: text,
      textColor: ColorManager.whiteColor,
      onPressed: onSuccessScreenButtonPressed,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const successImageSize = 120.0;

  static const titleTextStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const messageTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );
}
