import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/pickup_request/pickup_request_model.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/pickup_request_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/point_transaction_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/image_picker_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

@RoutePage()
class CompletePickupScreen extends StatelessWidget {
  const CompletePickupScreen({super.key, required this.pickupRequestDetails});

  final PickupRequestModel pickupRequestDetails;

  @override
  Widget build(BuildContext context) {
    return _CompletePickupScreen(pickupRequestDetails: pickupRequestDetails);
  }
}

class _CompletePickupScreen extends BaseStatefulPage {
  const _CompletePickupScreen({required this.pickupRequestDetails});

  final PickupRequestModel pickupRequestDetails;

  @override
  State<_CompletePickupScreen> createState() => _CompletePickupScreenState();
}

class _CompletePickupScreenState
    extends BaseStatefulState<_CompletePickupScreen> {
  File? selectedImage;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Complete Pickup',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  Widget bottomNavigationBar() {
    return getSubmitButton();
  }

  @override
  Widget body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getTitleDescription(),
          SizedBox(height: 50),
          getSelectImageOrOpenCamera(),
        ],
      ),
    );
  }
}

// * ---------------------------- Helpers ----------------------------
extension _Helpers on _CompletePickupScreenState {
  int get completedRequestPoints => WidgetUtil.completedRequestPoints(
    pickupRequestItemcategory:
        widget.pickupRequestDetails.pickupItemCategory ?? '',
    pickupQuantity: widget.pickupRequestDetails.pickupItemQuantity ?? 0,
  );
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CompletePickupScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  Future<void> onPhotoUploadPressed({required bool fromGallery}) async {
    final pickedFile = await ImagePicker().pickImage(
      source: fromGallery ? ImageSource.gallery : ImageSource.camera,
    );

    if (pickedFile != null) {
      _setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> onSubmitButtonPressed() async {
    if (selectedImage == null) {
      unawaited(
        WidgetUtil.showSnackBar(
          text: 'Please upload a proof of collection image',
        ),
      );
    } else {
      final result =
          await tryLoad(
            context,
            () => context.read<PickupRequestViewModel>().updatePickupRequest(
              collectionProofImage: selectedImage,
              completedDate: DateTime.now(),
              pickupRequestStatus: 'Completed',
              pickupRequestDetails: widget.pickupRequestDetails,
              isCollectorUpdate: true,
            ),
          ) ??
          false;
      if (result) {
        await updateCustomerPoints();
      }
    }
  }

  Future<void> updateCustomerPoints() async {
    final userVM = context.read<UserViewModel>();

    await tryCatch(
      context,
      () => userVM.getUserDetails(
        userID: widget.pickupRequestDetails.userID ?? '',
        noNeedUpdateUserSharedPreference: true,
      ),
    );

    final result = mounted
        ? await tryLoad(
                context,
                () => userVM.updateUser(
                  userID: widget.pickupRequestDetails.userID,
                  point: completedRequestPoints,
                  noNeedUpdateUserSharedPreference: true,
                  isAddPoint: true,
                ),
              ) ??
              false
        : false;

    if (result) {
      await addPointTransaction();
    }
  }

  Future<void> addPointTransaction() async {
    final result =
        await tryLoad(
          context,
          () => context.read<PointTransactionViewModel>().insertPointTransaction(
            userID: widget.pickupRequestDetails.userID ?? '',
            point: completedRequestPoints,
            type: 'earn',
            description:
                'Completed request: #${widget.pickupRequestDetails.pickupRequestID}',
            createdAt: DateTime.now(),
          ),
        ) ??
        false;

    if (result) {
      unawaited(
        WidgetUtil.showSnackBar(
          text: 'Congrats! Successfully completed the pickup',
        ),
      );
      if (mounted) await context.router.maybePop(true);
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CompletePickupScreenState {
  Widget getTitleDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload a photo as proof of collection',
          style: _Styles.titleTextStyle,
        ),
        Text(
          'This helps ensure transparency and confirms that the pickup was successfully completed.',
          style: _Styles.descriptionTextStyle,
        ),
      ],
    );
  }

  Widget getSelectImageOrOpenCamera() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getPhotoField(),
        SizedBox(height: 30),
        Text('OR', style: _Styles.blackTextStyle),
        SizedBox(height: 30),
        getTakePhotoButton(),
      ],
    );
  }

  Widget getPhotoField() {
    return PhotoPicker(
      borderRadius: _Styles.borderRadius,
      onTap: () {
        onPhotoUploadPressed(fromGallery: true);
      },
      selectedImage: selectedImage ?? File(''),
    );
  }

  Widget getTakePhotoButton() {
    return CustomButton(
      backgroundColor: ColorManager.primaryLight,
      icon: Icon(Icons.camera_alt, color: ColorManager.primary),
      text: 'Open Camera & Take Photo',
      textColor: ColorManager.primary,

      onPressed: () {
        onPhotoUploadPressed(fromGallery: false);
      },
    );
  }

  Widget getSubmitButton() {
    return CustomButton(
      text: 'Submit',
      textColor: ColorManager.whiteColor,
      onPressed: onSubmitButtonPressed,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const borderRadius = 15.0;

  static const titleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const descriptionTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const blackTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );
}
