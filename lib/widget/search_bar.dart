import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    this.onChanged,
    this.controller,
    required this.hintText,
  });

  final void Function(String? value)? onChanged;
  final TextEditingController? controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return getTextField();
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on CustomSearchBar {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on CustomSearchBar {
  Widget getTextField() {
    return Container(
      width: double.infinity,
      height: _Styles.searchBarHeight,
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(_Styles.searchBarBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            spreadRadius: 0.5,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: _Styles.contentPadding,
          prefixIcon: Icon(
            Icons.search,
            color: ColorManager.blackColor,
            size: _Styles.searchIconSize,
          ),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        cursorColor: ColorManager.blackColor,
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const searchIconSize = 25.0;
  static const searchBarHeight = 50.0;
  static const searchBarBorderRadius = 20.0;

  static const contentPadding = EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 10,
  );
}
