import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/widget/custom_text_field.dart';
import 'package:intl/intl.dart';

class WidgetUtil {
  static String dateFormatter(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static Future<T?> showAlertDialog<T>(
    BuildContext context, {
    required String? title,
    String? content,
    required List<Widget>? actions,
    String? formName,
    bool dismissible = true,
    bool needTextField = false,
    int? maxLines,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          title ?? '',
          textAlign: TextAlign.justify,
          style: TextStyle(fontWeight: FontWeightManager.bold),
        ),
        content: needTextField
            ? CustomTextField(formName: formName ?? '', maxLines: maxLines)
            : Text(content ?? ''),
        actions: actions,
        backgroundColor: ColorManager.whiteColor,
      ),
      barrierDismissible: dismissible,
    );
  }
}
