import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/widget/adaptive_alert_dialog.dart';
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.all(20),
        titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        actionsPadding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        title: Text(
          title ?? '',
          textAlign: TextAlign.justify,
          style: TextStyle(fontWeight: FontWeightManager.bold, fontSize: 20),
        ),
        content: needTextField
            ? CustomTextField(formName: formName ?? '', maxLines: maxLines)
            : Text(content ?? '', style: TextStyle(fontSize: 16)),
        actions: actions,
        backgroundColor: ColorManager.whiteColor,
      ),
      barrierDismissible: dismissible,
    );
  }

  static Future<void> showDefaultErrorDialog(
    BuildContext context,
    String errorMessage,
  ) async {
    final List<Widget> actionBuilders = [
      TextButton(
        onPressed: () {
          context.router.maybePop();
        },
        child: Text('OK'),
      ),
    ];
    if (context.mounted) {
      return showAdaptiveDialog<void>(
        context: context,
        builder: (context) => AdaptiveAlertDialog(
          errorMessage: errorMessage,
          actionBuilders: actionBuilders,
        ),
        useRootNavigator: false,
      );
    }
  }
}
