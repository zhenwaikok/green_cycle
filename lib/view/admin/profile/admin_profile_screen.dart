import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
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
class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

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
      child: _AdminProfileScreen(),
    );
  }
}

class _AdminProfileScreen extends BaseStatefulPage {
  @override
  State<_AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends BaseStatefulState<_AdminProfileScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  EdgeInsets defaultPadding() {
    return EdgeInsets.zero;
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(title: 'Profile', isBackButtonVisible: false);
  }

  @override
  Widget body() {
    final userDetails = context.select((UserViewModel vm) => vm.userDetails);

    return AdaptiveWidgets.buildRefreshableScrollView(
      context,
      onRefresh: fetchData,
      refreshIndicatorBackgroundColor: ColorManager.whiteColor,
      color: ColorManager.blackColor,
      slivers: [
        SliverPadding(
          padding: _Styles.screenPadding,
          sliver: SliverMainAxisGroup(
            slivers: [
              SliverToBoxAdapter(
                child: getProfileDetails(
                  profileImageURL: userDetails?.profileImageURL ?? '',
                  username: userDetails?.fullName ?? '-',
                  userRole: userDetails?.userRole ?? '-',
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 25)),
              SliverToBoxAdapter(
                child: Divider(color: ColorManager.lightGreyColor),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 25)),
              SliverToBoxAdapter(child: getProfileCard()),
            ],
          ),
        ),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _AdminProfileScreenState {
  void onChangePasswordPressed() {
    context.router.push(ChangePasswordRoute());
  }

  void onEditProfilePressed() async {
    final userVM = context.read<UserViewModel>();

    final userRole = userVM.user?.userRole ?? '';
    final userID = userVM.user?.userID ?? '';

    final result = await context.router.push(
      EditProfileRoute(userRole: userRole, userID: userID),
    );

    if (result == true && mounted) {
      fetchData();
    }
  }

  Future<void> onSignOutPressed() async {
    final result = await tryLoad(
      context,
      () => context.read<UserViewModel>().logout(),
    );
    if (result ?? false) {
      if (mounted) await context.router.replaceAll([LoginRoute()]);
    }
  }

  Future<void> fetchData() async {
    final userVM = context.read<UserViewModel>();
    final userID = userVM.user?.userID ?? '';

    await tryLoad(context, () => userVM.getUserDetails(userID: userID));
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _AdminProfileScreenState {
  Widget getProfileDetails({
    required String profileImageURL,
    required String username,
    required String userRole,
  }) {
    return Row(
      children: [
        CustomProfileImage(imageURL: profileImageURL, imageSize: 80.0),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                username,
                style: _Styles.usernameTextStyle,
                maxLines: _Styles.maxTextLines,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 15),
              Text(userRole, style: _Styles.adminTextStyle),
            ],
          ),
        ),
      ],
    );
  }

  Widget getProfileCard() {
    return CustomCard(
      padding: _Styles.customCardPadding,
      child: getProfileCardItems(),
    );
  }

  Widget getProfileCardItems() {
    return Column(
      children: [
        CustomProfileRowElement(
          icon: Icons.person,
          text: 'Edit Profile',
          onPressed: onEditProfilePressed,
        ),
        CustomProfileRowElement(
          icon: Icons.lock,
          text: 'Change Password',
          onPressed: onChangePasswordPressed,
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

  static const screenPadding = EdgeInsets.all(20);

  static const customCardPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 10,
  );

  static const usernameTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const adminTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );
}
