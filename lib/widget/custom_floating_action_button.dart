import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final Icon icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: CircleBorder(),
      onPressed: onPressed,
      backgroundColor: ColorManager.primary,
      child: icon,
    );
  }
}
