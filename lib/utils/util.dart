import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:intl/intl.dart';

class WidgetUtil {
  static String dateFormatter(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static Future<T?> showAlertDialog<T>(
    BuildContext context, {
    required String? title,
    required String? content,
    required List<Widget>? actions,
    bool dismissible = true,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title ?? ''),
        content: Text(content ?? ''),
        actions: actions,
        backgroundColor: ColorManager.whiteColor,
      ),
      barrierDismissible: dismissible,
    );
  }
}
