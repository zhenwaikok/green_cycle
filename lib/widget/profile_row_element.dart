import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';

class CustomProfileRowElement extends StatelessWidget {
  const CustomProfileRowElement({
    super.key,
    required this.icon,
    required this.text,
    this.isSignOut = false,
    this.onTap,
  });

  final IconData icon;
  final String text;
  final bool? isSignOut;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _Styles.padding,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              icon,
              color: isSignOut == true
                  ? ColorManager.redColor
                  : ColorManager.primary,
              size: _Styles.iconSize,
            ),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                text,
                style: _Styles.labelTextStyle(isSignOut: isSignOut ?? false),
              ),
            ),
            if (isSignOut == false)
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: ColorManager.blackColor,
                size: _Styles.arrowIconSize,
              ),
          ],
        ),
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const iconSize = 35.0;
  static const arrowIconSize = 20.0;

  static TextStyle labelTextStyle({required bool isSignOut}) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeightManager.regular,
    color: isSignOut == true ? ColorManager.redColor : ColorManager.blackColor,
  );

  static const padding = EdgeInsets.symmetric(vertical: 15);
}
