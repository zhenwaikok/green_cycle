import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';

class CustomStatusBar extends StatelessWidget {
  const CustomStatusBar({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadius.circular(_Styles.borderRadius),
        ),
        child: Padding(
          padding: _Styles.textPadding,
          child: Text(text, style: _Styles.textStyle),
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
    fontSize: 12,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.whiteColor,
  );
}
