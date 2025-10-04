import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/reward_redemption/reward_redemption_model.dart';
import 'package:green_cycle_fyp/widget/adaptive_alert_dialog.dart';
import 'package:green_cycle_fyp/widget/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:url_launcher/url_launcher.dart';

class WidgetUtil {
  static String dateFormatter(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String dateTimeFormatter(DateTime date) {
    return DateFormat('dd/MM/yyyy, h:mm a').format(date);
  }

  static String priceFormatter(double price) {
    return price.toStringAsFixed(2);
  }

  static String distanceFormatter(int meters) {
    if (meters < 1000) {
      return '$meters m';
    } else {
      return '${(meters / 1000).toStringAsFixed(1)} km';
    }
  }

  static String durationFormatter(double minutes) {
    if (minutes < 60) {
      return minutes <= 1 ? '$minutes min' : '${minutes.floor()} mins';
    } else {
      final hour = (minutes / 60).floor();

      return hour == 1
          ? '${hour.toStringAsFixed(1)} hour'
          : '${hour.toStringAsFixed(1)} hours';
    }
  }

  static DateTime getEarliestPickupDateTime({
    required DateTime date,
    required String timeRange,
  }) {
    final startTime = timeRange.split(' - ').first.trim();

    final timeParts = startTime.split(RegExp(r'[: ]'));
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);
    final period = timeParts[2].toLowerCase();

    if (period == 'pm' && hour != 12) {
      hour += 12;
    } else if (period == 'am' && hour == 12) {
      hour = 0;
    }

    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  static String differenceBetweenDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    final minutes = difference.inMinutes;
    final hours = difference.inHours;
    final days = difference.inDays;
    final months = (difference.inDays / 30).floor();
    final years = (difference.inDays / 365).floor();

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return minutes == 1 ? '1 minute ago' : '$minutes minutes ago';
    } else if (difference.inHours < 24) {
      return hours == 1 ? '1 hour ago' : '$hours hours ago';
    } else if (difference.inDays < 30) {
      return days == 1 ? '1 day ago' : '$days days ago';
    } else if (difference.inDays < 365) {
      return months == 1 ? '1 month ago' : '$months months ago';
    } else {
      return years == 1 ? '1 year ago' : '$years years ago';
    }
  }

  static Color getPickupRequestStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return ColorManager.yellowColor;
      case 'completed':
        return ColorManager.primary;
      case 'ongoing':
        return ColorManager.orangeColor;
      case 'accepted':
        return ColorManager.blueColor;
      case 'arrived':
        return ColorManager.purpleColor;
      default:
        return ColorManager.primary;
    }
  }

  static Color getPurchaseStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return ColorManager.primary;
      case 'in progress':
        return ColorManager.orangeColor;
      case 'shipped':
        return ColorManager.purpleColor;
      default:
        return ColorManager.primary;
    }
  }

  static Color getAccountStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'rejected':
        return ColorManager.redColor;
      case 'pending':
        return ColorManager.orangeColor;
      case 'approved':
        return ColorManager.primary;
      default:
        return ColorManager.primary;
    }
  }

  static String getButtonLabel(String status) {
    return switch (status) {
      'Accepted' => 'On My Way',
      'Ongoing' => 'Arrived',
      'Arrived' => 'Complete Pickup',
      _ => 'Accept Pickup Request',
    };
  }

  static String getAlertDialogContentLabel(String status) {
    return switch (status) {
      'Pending' =>
        'Are you sure you want to accept this pickup request? This action cannot be undone.',
      'Accepted' =>
        'Are you sure you\'re on the way? This action cannot be undone.',
      'Ongoing' =>
        'Are you sure you\'re arrived? This action cannot be undone.',
      'Arrived' =>
        'Are you sure to complete this pickup? This action cannot be undone.',
      _ => '',
    };
  }

  static String getRewardStatus({
    required bool isUsed,
    required bool isExpired,
  }) {
    if (isUsed) {
      return 'Used';
    } else if (isExpired) {
      return 'Expired';
    } else {
      return 'Active';
    }
  }

  static String getProfileStatusNoteTest({required String status}) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Your profile is currently under review. Please check back later.';
      case 'approved':
        return 'Your profile has been approved. You can now start accepting pickup requests.';
      case 'rejected':
        return 'Your profile has been rejected. Please review the reason below and update your details to resubmit.';
      default:
        return 'Your profile is currently under review. Please check back later.';
    }
  }

  static int completedRequestPoints({
    required String pickupRequestItemcategory,
    required int pickupQuantity,
  }) {
    final category = DropDownItems.itemCategoryItems;

    const categoryPoints = [
      50, // Large Household Appliances
      25, // Small Household Appliances
      30, // Consumer Electronics
      35, // ICT
      10, // Lighting Equipment
      15, // Batteries & Accumulators
      20, // Electrical & Electronic Tools
      25, // Medical Devices
      20, // Monitoring & Control Instruments
    ];

    final index = category.indexOf(pickupRequestItemcategory);
    final pointsPerItem = (index >= 0 && index < categoryPoints.length)
        ? categoryPoints[index]
        : 0;

    return pointsPerItem * pickupQuantity;
  }

  static bool isRewardDateExpired({required DateTime expiryDate}) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final expiry = DateTime(expiryDate.year, expiryDate.month, expiryDate.day);

    return expiry.isBefore(today);
  }

  static bool isRewardUsed({
    required RewardRedemptionModel rewardRedemptionDetails,
  }) {
    return rewardRedemptionDetails.isUsed == true;
  }

  static Future<T?> showAlertDialog<T>(
    BuildContext context, {
    required String? title,
    String? content,
    required List<Widget Function(BuildContext dialogContext)>? actions,
    String? formName,
    bool dismissible = true,
    bool needTextField = false,
    int? maxLines,
    String? Function(String?)? validator,
    GlobalKey<FormBuilderState>? formKey,
    String? hintText,
    Widget? customizeContent,
  }) {
    return showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.all(20),
        titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        actionsPadding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        title: Text(
          title ?? '',
          textAlign: TextAlign.justify,
          style: TextStyle(fontWeight: FontWeightManager.bold, fontSize: 20),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        content:
            customizeContent ??
            (needTextField
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
                : Text(content ?? '', style: TextStyle(fontSize: 16))),
        actions: actions?.map((builder) => builder(dialogContext)).toList(),
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

  static List<File> convertImageFileToFile({required List<ImageFile> images}) {
    final List<File> imageFiles = images
        .where((img) => img.hasPath)
        .map((img) => File(img.path ?? ''))
        .toList();

    return imageFiles;
  }

  static List<ImageFile> convertImageURLsToImageFiles(List<String> imageUrls) {
    return imageUrls
        .map(
          (url) => ImageFile(
            url,
            name: url.split('/').last,
            extension: url.split('.').last,
            path: url,
          ),
        )
        .toList();
  }

  static Future<void> dialPhoneNum({required String phoneNum}) async {
    final url = Uri.parse('tel:$phoneNum');

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.platformDefault);
      } else {
        debugPrint("No app can handle tel: URI");
      }
    } catch (e) {
      debugPrint("Failed to launch dialer: $e");
    }
  }
}
