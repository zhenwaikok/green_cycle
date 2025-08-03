import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/widget/adaptive_alert_dialog.dart';
import 'package:green_cycle_fyp/widget/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class WidgetUtil {
  static String dateFormatter(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String dateTimeFormatter(DateTime date) {
    return DateFormat('dd/MM/yyyy, h:mm a').format(date);
  }

  static Color getPickupRequestStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return ColorManager.yellowColor;
      case 'completed':
        return ColorManager.primary;
      case 'in progress':
        return ColorManager.orangeColor;
      case 'accepted':
        return ColorManager.blueColor;
      case 'arrived':
        return ColorManager.purpleColor;
      default:
        return ColorManager.primary;
    }
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
    String? Function(String?)? validator,
    GlobalKey<FormBuilderState>? formKey,
    String? hintText,
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
            ? FormBuilder(
                key: formKey,
                child: SizedBox(
                  width: double.maxFinite,
                  child: CustomTextField(
                    formName: formName ?? '',
                    validator: validator,
                    labelText: hintText,
                  ),
                ),
              )
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
        child: Text('OK', style: TextStyle(color: ColorManager.primary)),
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

  static Future<void> showSnackBar({required String text}) async {
    await Fluttertoast.cancel();
    const duration = 1;

    await Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: duration,
      backgroundColor: ColorManager.blackColor.withValues(alpha: 0.5),
      textColor: ColorManager.whiteColor,
      fontSize: 15.0,
    );
  }

  static ImageFile convertToImageFile(XFile file) {
    return ImageFile(
      UniqueKey().toString(),
      name: file.name,
      extension: file.path.split('.').last,
      bytes: File(file.path).readAsBytesSync(),
      path: file.path,
    );
  }

  static Future<List<XFile>> pickMultipleImages({
    required List<XFile> images,
  }) async {
    final ImagePicker imagePicker = ImagePicker();
    images = await imagePicker.pickMultiImage();
    return images;
  }
}
