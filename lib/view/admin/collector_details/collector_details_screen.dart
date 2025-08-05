import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/enums/form_type.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/user/user_model.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:green_cycle_fyp/widget/profile_image.dart';
import 'package:provider/provider.dart';

@RoutePage()
class CollectorDetailsScreen extends StatelessWidget {
  const CollectorDetailsScreen({super.key, required this.collectorID});

  final String collectorID;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserViewModel(
        userRepository: UserRepository(
          sharePreferenceHandler: SharedPreferenceHandler(),
          userServices: UserServices(),
        ),
        firebaseRepository: FirebaseRepository(
          firebaseServices: FirebaseServices(),
        ),
      ),
      child: _CollectorDetailsScreen(collectorID: collectorID),
    );
  }
}

class _CollectorDetailsScreen extends BaseStatefulPage {
  @override
  State<_CollectorDetailsScreen> createState() =>
      _CollectorDetailsScreenState();

  const _CollectorDetailsScreen({required this.collectorID});

  final String collectorID;
}

class _CollectorDetailsScreenState
    extends BaseStatefulState<_CollectorDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    initialLoad();
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Collector Details',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  Widget body() {
    final user = context.select((UserViewModel vm) => vm.userDetails);

    if (user == null) {
      return SizedBox.shrink();
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getAccountStatusBar(approvalStatus: user.approvalStatus ?? ''),
          SizedBox(height: 10),
          if (user.approvalStatus == 'Rejected') ...[
            getRejectionMessage(
              rejectionMessage: user.accountRejectMessage ?? '',
            ),
            SizedBox(height: 20),
          ],
          getCollectorImage(imageURL: user.profileImageURL ?? ''),
          SizedBox(height: 20),
          getCollectorNameOrganization(
            collectorName: user.fullName ?? '-',
            companyName: user.companyName ?? '-',
          ),
          SizedBox(height: 60),
          getCollectorDetails(user: user),
          if (user.approvalStatus != 'Approved') ...[
            SizedBox(height: 40),
            getRejectApproveButton(approvalStatus: user.approvalStatus ?? ''),
          ],
        ],
      ),
    );
  }
}

// * ---------------------------- Helpers ----------------------------
extension _Helpers on _CollectorDetailsScreenState {
  String get accountRejectMessage =>
      _formKey
          .currentState
          ?.fields[RejectCollectorFormFieldEnum.reason.name]
          ?.value ??
      '';
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CollectorDetailsScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  Future<void> initialLoad() async {
    await tryLoad(
      context,
      () => context.read<UserViewModel>().getUserDetails(
        userID: widget.collectorID,
        noNeedUpdateUserSharedPreference: true,
      ),
    );
  }

  void onApproveButtonPressed() {
    WidgetUtil.showAlertDialog(
      context,
      title: 'Approval Confirmation',
      content: 'Are you sure to approve this collector\'s profile?',
      actions: [
        getAlertDialogTextButton(
          onPressed: onBackButtonPressed,
          text: 'Cancel',
        ),
        getAlertDialogTextButton(
          onPressed: onApproveSubmitPressed,
          text: 'Submit',
        ),
      ],
    );
  }

  void onDeleteButtonPressed() {
    WidgetUtil.showAlertDialog(
      context,
      title: 'Rejection Reason',
      maxLines: _Styles.maxLines,
      needTextField: true,
      formName: RejectCollectorFormFieldEnum.reason.name,
      validator: FormBuilderValidators.required(),
      hintText: 'Reason',
      formKey: _formKey,
      actions: [
        getAlertDialogTextButton(
          onPressed: onBackButtonPressed,
          text: 'Cancel',
        ),
        getAlertDialogTextButton(
          onPressed: () =>
              onRejectSubmitPressed(rejectMessage: accountRejectMessage),
          text: 'Submit',
        ),
      ],
    );
  }

  Future<void> onRejectSubmitPressed({required String rejectMessage}) async {
    final formValid = _formKey.currentState?.saveAndValidate() ?? false;

    if (formValid) {
      await context.router.maybePop();
      final result = mounted
          ? await tryLoad(
              context,
              () => context.read<UserViewModel>().updateUser(
                userID: widget.collectorID,
                noNeedUpdateUserSharedPreference: true,
                approvalStatus: 'Rejected',
                accountRejectMessage: rejectMessage,
              ),
            )
          : null;

      if (result ?? false) {
        unawaited(
          WidgetUtil.showSnackBar(
            text: 'Rejected collector profile successfully',
          ),
        );
        if (mounted) {
          await context.router.maybePop(true);
        }
      } else {
        unawaited(
          WidgetUtil.showSnackBar(text: 'Failed to reject collector profile'),
        );
      }
    }
  }

  Future<void> onApproveSubmitPressed() async {
    await context.router.maybePop();
    final result = mounted
        ? await tryLoad(
            context,
            () => context.read<UserViewModel>().updateUser(
              userID: widget.collectorID,
              noNeedUpdateUserSharedPreference: true,
              approvalStatus: 'Approved',
            ),
          )
        : null;

    if (result ?? false) {
      WidgetUtil.showSnackBar(text: 'Approved collector profile successfully');
      if (mounted) {
        context.router.maybePop(true);
      }
    } else {
      WidgetUtil.showSnackBar(text: 'Failed to approve collector profile');
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CollectorDetailsScreenState {
  Widget getAccountStatusBar({required String approvalStatus}) {
    final statusStyles = {
      'Approved': ColorManager.primary,
      'Pending': ColorManager.orangeColor,
      'Rejected': ColorManager.redColor,
    };

    return CustomStatusBar(
      text: approvalStatus,
      backgroundColor: statusStyles[approvalStatus],
    );
  }

  Widget getRejectionMessage({required String rejectionMessage}) {
    return Text(
      ' Reason: $rejectionMessage',
      style: _Styles.rejectionMessageTextStyle,
    );
  }

  Widget getCollectorImage({required String imageURL}) {
    return Center(
      child: CustomProfileImage(
        imageSize: _Styles.imageSize,
        imageURL: imageURL,
      ),
    );
  }

  Widget getCollectorNameOrganization({
    required String collectorName,
    required String companyName,
  }) {
    return Center(
      child: Column(
        children: [
          Text(collectorName, style: _Styles.collectorNameTextStyle),
          Text(companyName, style: _Styles.companyTextStyle),
        ],
      ),
    );
  }

  Widget getCollectorDetails({required UserModel user}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTitleDescription(
          title: 'Email Address',
          description: user.emailAddress ?? '-',
        ),
        SizedBox(height: 30),
        getTitleDescription(title: 'Gender', description: user.gender ?? '-'),
        SizedBox(height: 30),
        getTitleDescription(
          title: 'Phone Number',
          description: user.phoneNumber ?? '-',
        ),
        SizedBox(height: 30),
        getTitleDescription(
          title: 'Vehicle Type',
          description: user.vehicleType ?? '-',
        ),
        SizedBox(height: 30),
        getTitleDescription(
          title: 'Vehicle Plate Number',
          description: user.vehiclePlateNumber ?? '-',
        ),
      ],
    );
  }

  Widget getTitleDescription({
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: _Styles.titleTextStyle),
        Text(description, style: _Styles.descriptionTextStyle),
      ],
    );
  }

  Widget getRejectApproveButton({required String approvalStatus}) {
    final isRejected = approvalStatus == 'Rejected';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!isRejected) ...[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: CustomButton(
              text: 'Reject',
              textColor: ColorManager.redColor,
              onPressed: onDeleteButtonPressed,
              borderColor: ColorManager.redColor,
              backgroundColor: ColorManager.whiteColor,
              icon: Icon(
                Icons.close,
                color: ColorManager.redColor,
                size: _Styles.iconSize,
              ),
            ),
          ),
        ],
        isRejected
            ? Expanded(
                child: CustomButton(
                  text: 'Approve',
                  textColor: ColorManager.primary,
                  onPressed: onApproveButtonPressed,
                  borderColor: ColorManager.primary,
                  backgroundColor: ColorManager.whiteColor,
                  icon: Icon(
                    Icons.check_rounded,
                    color: ColorManager.primary,
                    size: _Styles.iconSize,
                  ),
                ),
              )
            : SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: CustomButton(
                  text: 'Approve',
                  textColor: ColorManager.primary,
                  onPressed: onApproveButtonPressed,
                  borderColor: ColorManager.primary,
                  backgroundColor: ColorManager.whiteColor,
                  icon: Icon(
                    Icons.check_rounded,
                    color: ColorManager.primary,
                    size: _Styles.iconSize,
                  ),
                ),
              ),
      ],
    );
  }

  Widget getAlertDialogTextButton({
    required void Function()? onPressed,
    required String text,
  }) {
    return TextButton(
      style: _Styles.textButtonStyle,
      onPressed: onPressed,
      child: Text(text, style: _Styles.textButtonTextStyle),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const imageSize = 130.0;
  static const iconSize = 25.0;
  static const maxLines = 6;

  static const collectorNameTextStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const companyTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const titleTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const descriptionTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static final textButtonStyle = ButtonStyle(
    overlayColor: WidgetStateProperty.all(ColorManager.lightGreyColor2),
  );

  static const textButtonTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const rejectionMessageTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.redColor,
  );
}
