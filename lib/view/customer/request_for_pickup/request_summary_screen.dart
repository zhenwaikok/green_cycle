import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/pickup_request_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:provider/provider.dart';

@RoutePage()
class RequestSummaryScreen extends StatelessWidget {
  const RequestSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _RequestSummaryScreen();
  }
}

class _RequestSummaryScreen extends BaseStatefulPage {
  @override
  State<_RequestSummaryScreen> createState() => _RequestSummaryScreenState();
}

class _RequestSummaryScreenState
    extends BaseStatefulState<_RequestSummaryScreen> {
  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Request Summary',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  Widget bottomNavigationBar() {
    return getConfirmRequestButton();
  }

  @override
  Widget body() {
    final vm = context.watch<PickupRequestViewModel>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getTitle(),
          SizedBox(height: 35),
          getPickupLocationSection(
            pickupLocation: vm.pickupLocation ?? '-',
            remarks: vm.remarks,
          ),
          SizedBox(height: 25),
          getPickupDateTimeSection(
            pickupDate: vm.pickupDate ?? DateTime.now(),
            pickupTimeRange: vm.pickupTimeRange ?? '',
          ),
          SizedBox(height: 25),
          getItemDetailsSection(
            itemImages: vm.pickupItemImages,
            itemDescription: vm.pickupItemDescription ?? '-',
            category: vm.pickupItemCategory ?? '-',
            quantity: vm.pickupItemQuantity ?? 0,
            condition: vm.pickupItemCondition ?? '-',
          ),
        ],
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _RequestSummaryScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  void onEditPickupLocationPressed() {
    context.router.push(SelectLocationRoute(isEdit: true));
  }

  void onEditPickupDateAndTimePressed() {
    context.router.push(SchedulePickupRoute(isEdit: true));
  }

  void onEditItemDetailsPressed() {
    context.router.push(RequestItemDetailsRoute(isEdit: true));
  }

  Future<void> onConfirmRequestButtonPressed() async {
    final vm = context.read<PickupRequestViewModel>();
    final result =
        await tryLoad(context, () => vm.insertPickupRequest()) ?? false;
    if (result) {
      unawaited(
        WidgetUtil.showSnackBar(text: 'Request submitted successfully'),
      );
      if (mounted) {
        context.router.popUntil((route) => route.isFirst);
      }
    } else {
      unawaited(WidgetUtil.showSnackBar(text: 'Failed to submit request'));
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _RequestSummaryScreenState {
  Widget getTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Review Request', style: _Styles.titleTextStyle),
        Text(
          'Review your pickup request details before submitting. You can edit any section if needed.',
          style: _Styles.blackTextStyle,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget getPickupLocationSection({
    required String pickupLocation,
    required String? remarks,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getSectionTitle(
          title: 'Pickup Location',
          onPressed: onEditPickupLocationPressed,
        ),
        Text(
          pickupLocation,
          style: _Styles.blackTextStyle,
          textAlign: TextAlign.justify,
        ),
        remarks != null && remarks.isNotEmpty
            ? Column(
                children: [
                  SizedBox(height: 5),
                  Text(
                    '**Remarks: $remarks',
                    style: _Styles.smallGreyTextStyle,
                    textAlign: TextAlign.justify,
                  ),
                ],
              )
            : SizedBox.shrink(),
      ],
    );
  }

  Widget getPickupDateTimeSection({
    required DateTime pickupDate,
    required String pickupTimeRange,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getSectionTitle(
          title: 'Pickup Date & Time',
          onPressed: onEditPickupDateAndTimePressed,
        ),
        Text(
          '${WidgetUtil.dateFormatter(pickupDate)}, $pickupTimeRange',
          style: _Styles.blackTextStyle,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget getItemDetailsSection({
    required List<ImageFile> itemImages,
    required String itemDescription,
    required String category,
    required int quantity,
    required String condition,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getSectionTitle(
          title: 'Item Details',
          onPressed: onEditItemDetailsPressed,
        ),
        SizedBox(height: 10),
        Row(
          children: [
            ...List.generate(
              itemImages.length,
              (index) => Padding(
                padding: _Styles.itemImagePadding,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    _Styles.itemImageBorderRadius,
                  ),
                  child: Image.file(
                    File(itemImages[index].path ?? ''),
                    width: _Styles.itemImageSize,
                    height: _Styles.itemImageSize,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        getItemDescription(
          itemDescription: itemDescription,
          category: category,
          quantity: quantity,
          condition: condition,
        ),
      ],
    );
  }

  Widget getSectionTitle({
    required String title,
    required void Function() onPressed,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: _Styles.sectionTitleTextStyle),
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.edit,
            color: ColorManager.primary,
            size: _Styles.editIconSize,
          ),
        ),
      ],
    );
  }

  Widget getItemDescription({
    required String itemDescription,
    required String category,
    required int quantity,
    required String condition,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getItemDescriptionText(
          itemTitle: 'Item Description: ',
          itemDescription: itemDescription,
        ),
        SizedBox(height: 15),
        getItemDescriptionText(
          itemTitle: 'Category: ',
          itemDescription: category,
        ),
        SizedBox(height: 15),
        getItemDescriptionText(
          itemTitle: 'Quantity: ',
          itemDescription: quantity.toString(),
        ),
        SizedBox(height: 15),
        getItemDescriptionText(
          itemTitle: 'Condition & Usage Info: ',
          itemDescription: condition,
        ),
      ],
    );
  }

  Widget getItemDescriptionText({
    required String itemTitle,
    required String itemDescription,
  }) {
    return RichText(
      text: TextSpan(
        text: itemTitle,
        style: _Styles.blackTextStyle,
        children: [
          TextSpan(text: itemDescription, style: _Styles.greyTextStyle),
        ],
      ),
    );
  }

  Widget getConfirmRequestButton() {
    return CustomButton(
      text: 'Confirm Request',
      textColor: ColorManager.whiteColor,
      onPressed: onConfirmRequestButtonPressed,
      backgroundColor: ColorManager.primary,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const editIconSize = 25.0;
  static const itemImageSize = 110.0;
  static const itemImageBorderRadius = 10.0;
  static const itemImagePadding = EdgeInsets.only(right: 10);

  static const titleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const blackTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const greyTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const smallGreyTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const sectionTitleTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );
}
