import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomStatusBar extends StatelessWidget {
  const CustomStatusBar({super.key, required this.text, this.backgroundColor});

  final String text;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Skeleton.shade(
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? ColorManager.primary,
            borderRadius: BorderRadius.circular(_Styles.borderRadius),
          ),
          child: Padding(
            padding: _Styles.textPadding,
            child: Text(text, style: _Styles.textStyle),
          ),
        ),
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const borderRadius = 20.0;

  static const textPadding = EdgeInsets.symmetric(horizontal: 15, vertical: 3);

  static const textStyle = TextStyle(
    fontSize: 11,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.whiteColor,
  );
}
