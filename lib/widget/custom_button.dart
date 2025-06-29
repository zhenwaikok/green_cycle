import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.textColor,
    this.backgroundColor,
    this.borderColor,
    required this.onPressed,
  });

  final String text;
  final Color textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: _Styles.buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style:
            ElevatedButton.styleFrom(
              backgroundColor: backgroundColor ?? ColorManager.primary,
              side: BorderSide(
                color: borderColor ?? Colors.transparent,
                width: _Styles.borderWidth,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(5.0),
              ),
            ).copyWith(
              overlayColor: WidgetStateProperty.all(
                ColorManager.greyColor.withValues(alpha: 0.1),
              ),
            ),
        child: Text(text, style: _Styles.buttonTextStyle(color: textColor)),
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const double borderWidth = 1.5;
  static const double buttonHeight = 40.0;

  static TextStyle buttonTextStyle({required Color color}) {
    return TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: color);
  }
}
