import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/user/user_model.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/profile_image.dart';
import 'package:green_cycle_fyp/widget/profile_row_element.dart';
import 'package:provider/provider.dart';

@RoutePage()
class CollectorProfileScreen extends StatelessWidget {
  const CollectorProfileScreen({super.key});

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
      child: _CollectorProfileScreen(),
    );
  }
}

class _CollectorProfileScreen extends BaseStatefulPage {
  @override
  State<_CollectorProfileScreen> createState() =>
      _CollectorProfileScreenState();
}

class _CollectorProfileScreenState
    extends BaseStatefulState<_CollectorProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(title: 'Profile', isBackButtonVisible: false);
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  Widget body() {
    final user =
        context.select((UserViewModel vm) => vm.userDetails) ?? UserModel();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getProfileDetails(
            imageURL: user.profileImageURL ?? '',
            fullName: user.fullName ?? '-',
            userRole: user.userRole ?? '-',
          ),
          SizedBox(height: 25),
          Divider(color: ColorManager.lightGreyColor),
          SizedBox(height: 25),
          getCollectorStatsCard(),
          SizedBox(height: 30),
          getProfileCard(
            userRole: user.userRole ?? '',
            userID: user.userID ?? '',
          ),
        ],
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CollectorProfileScreenState {
  void onChangePasswordPressed() {
    context.router.push(ChangePasswordRoute());
  }

  void onEditProfilePressed({
    required String userRole,
    required String userID,
  }) async {
    final result = await context.router.push(
      EditProfileRoute(userRole: userRole, userID: userID),
    );

    if (result == true && mounted) {
      fetchData();
    }
  }

  void onPickupHistoryPressed() {
    context.router.push(PickupHistoryRoute());
  }

  Future<void> onSignOutPressed() async {
    final result = await tryLoad(
      context,
      () => context.read<UserViewModel>().logout(),
    );
    if (result ?? false) {
      if (mounted) context.router.replaceAll([LoginRoute()]);
    }
  }

  Future<void> fetchData() async {
    final user = context.read<UserViewModel>().user;

    await tryLoad(
      context,
      () => context.read<UserViewModel>().getUserDetails(
        userID: user?.userID ?? '',
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CollectorProfileScreenState {
  Widget getProfileDetails({
    required String imageURL,
    required String fullName,
    required String userRole,
  }) {
    return Row(
      children: [
        CustomProfileImage(imageURL: imageURL, imageSize: 80.0),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                fullName,
                style: _Styles.usernameTextStyle,
                maxLines: _Styles.maxTextLines,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 15),
              Text(userRole, style: _Styles.collectorTextStyle),
            ],
          ),
        ),
      ],
    );
  }

  Widget getCollectorStatsCard() {
    return CustomCard(
      needBoxShadow: false,
      backgroundColor: ColorManager.primaryLight,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: getCollectorStatsItem(title: 'Ongoing', value: '1'),
            ),
            VerticalDivider(
              color: ColorManager.primary,
              thickness: 2,
              width: 30,
            ),
            Expanded(
              child: getCollectorStatsItem(title: 'Completed', value: '15'),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCollectorStatsItem({required String title, required String value}) {
    return Column(
      children: [
        Text(value, style: _Styles.valueTextStyle),
        SizedBox(height: 5),
        Text(title, style: _Styles.titleTextStyle),
      ],
    );
  }

  Widget getProfileCard({required String userRole, required String userID}) {
    return CustomCard(
      padding: _Styles.customCardPadding,
      child: getProfileCardItems(userRole: userRole, userID: userID),
    );
  }

  Widget getProfileCardItems({
    required String userRole,
    required String userID,
  }) {
    return Column(
      children: [
        CustomProfileRowElement(
          icon: Icons.person,
          text: 'Edit Profile',
          onPressed: () =>
              onEditProfilePressed(userRole: userRole, userID: userID),
        ),
        CustomProfileRowElement(
          icon: Icons.lock,
          text: 'Change Password',
          onPressed: onChangePasswordPressed,
        ),
        CustomProfileRowElement(
          icon: Icons.history,
          text: 'Pickup History',
          onPressed: onPickupHistoryPressed,
        ),
        CustomProfileRowElement(
          icon: Icons.logout,
          text: 'Sign Out',
          isSignOut: true,
          onPressed: onSignOutPressed,
        ),
      ],
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const maxTextLines = 2;

  static const customCardPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 10,
  );

  static const usernameTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const collectorTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const titleTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.primary,
  );

  static const valueTextStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );
}
