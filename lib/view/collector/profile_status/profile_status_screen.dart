import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/constant/images_manager.dart';
import 'package:green_cycle_fyp/model/api_model/user/user_model.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/profile_image.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';

@RoutePage()
class CollectorProfileStatusScreen extends StatelessWidget {
  const CollectorProfileStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _CollectorProfileStatusScreen();
  }
}

class _CollectorProfileStatusScreen extends BaseStatefulPage {
  @override
  State<_CollectorProfileStatusScreen> createState() =>
      _CollectorProfileStatusScreenState();
}

class _CollectorProfileStatusScreenState
    extends BaseStatefulState<_CollectorProfileStatusScreen> {
  bool refreshData = false;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Profile Status',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  Widget body() {
    final userDetails = context.select((UserViewModel vm) => vm.userDetails);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getProfileStatusCard(userDetails: userDetails ?? UserModel()),
        SizedBox(height: 20),
        getNoteText(status: userDetails?.approvalStatus ?? '-'),
        if (userDetails?.approvalStatus == 'Rejected') ...[
          SizedBox(height: 15),
          getRejectReason(
            rejectReason: userDetails?.accountRejectMessage ?? '-',
          ),
        ],
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CollectorProfileStatusScreenState {
  void onBackButtonPressed() {
    context.router.maybePop(refreshData);
  }

  void onResubmitButtonPressed() async {
    final userDetails = context.read<UserViewModel>().userDetails;
    final result = await context.router.push(
      EditProfileRoute(
        isResubmit: true,
        userRole: userDetails?.userRole ?? '',
        userID: userDetails?.userID ?? '',
      ),
    );

    _setState(() {
      refreshData = result == true;
    });
  }

  Future<void> fetchData() async {
    final userVM = context.read<UserViewModel>();
    final userID = userVM.user?.userID ?? '';

    await tryLoad(context, () => userVM.getUserDetails(userID: userID));
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CollectorProfileStatusScreenState {
  Widget getProfileStatusCard({required UserModel userDetails}) {
    return CustomCard(
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          getImage(),
          getProfileStatusContent(
            profileImageURL: userDetails.profileImageURL ?? '',
            status: userDetails.approvalStatus ?? '-',
          ),
        ],
      ),
    );
  }

  Widget getImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(_Styles.borderRadius),
        topRight: Radius.circular(_Styles.borderRadius),
      ),
      child: Image.asset(
        Images.reviewProfileImage,
        width: double.infinity,
        height: _Styles.reviewProfileImageHeight,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget getProfileStatusContent({
    required String profileImageURL,
    required String status,
  }) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Padding(
              padding: _Styles.screenPadding,
              child: Align(
                alignment: Alignment.center,
                child: getProfileImage(profileImageURL: profileImageURL),
              ),
            ),
          ),
          VerticalDivider(
            color: ColorManager.greyColor,
            width: 30,
            thickness: 1,
          ),
          Expanded(
            child: Padding(
              padding: _Styles.screenPadding,
              child: getProfileStatus(status: status),
            ),
          ),
        ],
      ),
    );
  }

  Widget getProfileImage({required String profileImageURL}) {
    return CustomProfileImage(
      imageURL: profileImageURL,
      imageSize: _Styles.profileImageSize,
    );
  }

  Widget getProfileStatus({required String status}) {
    final textColor = WidgetUtil.getAccountStatusColor(status);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Status', style: _Styles.statusTitleTextStyle),
        SizedBox(height: 5),
        Text(status, style: _Styles.statusTextStyle(color: textColor)),
      ],
    );
  }

  Widget getNoteText({required String status}) {
    final noteText = WidgetUtil.getProfileStatusNoteTest(status: status);
    final textColor = WidgetUtil.getAccountStatusColor(status);

    return Text(
      noteText,
      style: _Styles.noteTextStyle(color: textColor),
      textAlign: TextAlign.justify,
    );
  }

  Widget getRejectReason({required String rejectReason}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reason: $rejectReason',
          style: _Styles.rejectReasonTextStyle,
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 5),
        getResubmitButton(),
      ],
    );
  }

  Widget getResubmitButton() {
    return TouchableOpacity(
      onPressed: onResubmitButtonPressed,
      child: Text('Resubmit', style: _Styles.resubmitTextStyle),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const borderRadius = 15.0;
  static const profileImageSize = 80.0;
  static const reviewProfileImageHeight = 180.0;

  static const screenPadding = EdgeInsets.all(20);

  static const statusTitleTextStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.greyColor,
  );

  static TextStyle statusTextStyle({required Color color}) => TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeightManager.bold,
    color: color,
  );

  static TextStyle noteTextStyle({required Color color}) => TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeightManager.regular,
    color: color,
  );

  static const rejectReasonTextStyle = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const resubmitTextStyle = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
    decoration: TextDecoration.underline,
  );
}
