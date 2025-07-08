import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    this.padding,
    this.needBoxShadow = true,
    this.backgroundColor,
    this.borderRadius,
    this.child,
  });

  final EdgeInsetsGeometry? padding;
  final bool? needBoxShadow;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorManager.whiteColor,
        borderRadius:
            borderRadius ?? BorderRadius.circular(_Styles.cardBorderRadius),
        boxShadow: (needBoxShadow ?? true)
            ? [
                BoxShadow(
                  color: ColorManager.blackColor.withValues(alpha: 0.15),
                  blurRadius: 8,
                  spreadRadius: 0.5,
                  offset: Offset(0, 0),
                ),
              ]
            : null,
      ),
      child: Padding(padding: padding ?? _Styles.cardPadding, child: child),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const cardBorderRadius = 15.0;

  static const cardPadding = EdgeInsets.symmetric(vertical: 20, horizontal: 25);
}
