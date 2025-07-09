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
    this.icon,
  });

  final String text;
  final Color textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final void Function() onPressed;
  final Icon? icon;

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ?icon,
            icon != null ? SizedBox(width: 10) : SizedBox(width: 0),
            Text(text, style: _Styles.buttonTextStyle(color: textColor)),
          ],
        ),
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
