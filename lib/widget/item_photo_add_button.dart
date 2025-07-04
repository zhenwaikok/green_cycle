import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';

class ItemPhotoAddButton extends StatelessWidget {
  const ItemPhotoAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _Styles.containerSize,
      width: _Styles.containerSize,
      decoration: BoxDecoration(
        border: Border.all(color: ColorManager.blackColor),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Icon(
        Icons.add,
        color: ColorManager.blackColor,
        size: _Styles.iconSize,
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const containerSize = 100.0;

  static const iconSize = 30.0;
}
