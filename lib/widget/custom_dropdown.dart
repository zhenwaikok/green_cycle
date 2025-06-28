import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    super.key,
    required this.formName,
    required this.items,
    required this.title,
    required this.fontSize,
    required this.color,
    this.onChanged,
  });

  final String title;
  final double fontSize;
  final Color color;
  final String formName;
  final List<String> items;
  final void Function(String?)? onChanged;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTitle(
          title: widget.title,
          fontSize: widget.fontSize,
          color: widget.color,
        ),
        SizedBox(height: 10),
        getDropdownField(),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CustomDropdownState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CustomDropdownState {
  Widget getTitle({
    required String title,
    required double fontSize,
    required Color color,
  }) {
    return Text(
      title,
      style: _Styles.titleTextStyle(fontSize: fontSize, color: color),
    );
  }

  Widget getDropdownField() {
    return FormBuilderDropdown(
      name: widget.formName,
      initialValue: widget.items.isNotEmpty ? widget.items[0] : null,
      items: widget.items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      dropdownColor: ColorManager.whiteColor,
      decoration: InputDecoration(
        contentPadding: _Styles.contentPadding,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.greyColor,
            width: _Styles.textFieldBorderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.greyColor,
            width: _Styles.textFieldBorderWidth,
          ),
        ),
        errorBorder: _Styles.outlineErrorInputBorder,
        focusedErrorBorder: _Styles.outlineErrorInputBorder,
      ),
      onChanged: widget.onChanged,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const textFieldBorderWidth = 2.0;
  static const contentPadding = EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 10,
  );

  static TextStyle titleTextStyle({
    required double fontSize,
    FontWeight fontWeight = FontWeightManager.bold,
    required Color color,
  }) {
    return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
  }

  static final outlineErrorInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: ColorManager.redColor),
  );
}
