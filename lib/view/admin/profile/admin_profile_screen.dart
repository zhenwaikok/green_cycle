import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/mixins/error_handling_mixin.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
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

class _AdminProfileScreen extends StatefulWidget {
  @override
  State<_AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<_AdminProfileScreen>
    with ErrorHandlingMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile', isBackButtonVisible: false),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: _Styles.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getProfileDetails(),
                SizedBox(height: 25),
                Divider(color: ColorManager.lightGreyColor),
                SizedBox(height: 25),
                getProfileCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _AdminProfileScreenState {
  void onChangePasswordPressed() {
    context.router.push(ChangePasswordRoute());
  }

  void onEditProfilePressed() {
    //TODO: Pass correct role ltr
    // context.router.push(EditProfileRoute(selectedRole: 'Admin'));
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
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _AdminProfileScreenState {
  Widget getProfileDetails() {
    return Row(
      children: [
        CustomProfileImage(
          imageURL:
              'https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D',
          imageSize: 80.0,
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Username',
                style: _Styles.usernameTextStyle,
                maxLines: _Styles.maxTextLines,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 15),
              Text('Admin', style: _Styles.adminTextStyle),
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

  static const customCardPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 10,
  );
  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
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
