import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/profile_image.dart';
import 'package:green_cycle_fyp/widget/profile_row_element.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile', isBackButtonVisible: false),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: _Styles.screenPadding,
            child: Column(
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
extension _Actions on _ProfileScreenState {
  void onRewardsPressed() {
    context.router.push(RewardRoute());
  }

  void onChangePasswordPressed() {
    context.router.push(ChangePasswordRoute());
  }

  void onEditProfilePressed() {
    //TODO: Pass correct role ltr
    context.router.push(EditProfileRoute(selectedRole: 'Customer'));
  }

  void onPointsPressed() {
    context.router.push(PointsRoute());
  }

  void onCompletedRequestPressed() {
    context.router.push(CompletedRequestRoute());
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ProfileScreenState {
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
              Text('Point: 123', style: _Styles.pointTextStyle),
            ],
          ),
        ),
      ],
    );
  }

  Widget getProfileCard() {
    return CustomCard(
      children: [
        getProfileCardTop(),
        SizedBox(height: 15),
        Divider(color: ColorManager.lightGreyColor),
        getProfileCardBottom(),
      ],
    );
  }

  Widget getProfileCardTop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getProfileElement(
          icon: Icons.card_giftcard_outlined,
          text: 'Rewards',
          onTap: onRewardsPressed,
        ),
        getProfileElement(
          icon: FontAwesomeIcons.coins,
          text: 'Points',
          onTap: onPointsPressed,
        ),
        getProfileElement(icon: Icons.archive_rounded, text: 'My Listing'),
      ],
    );
  }

  Widget getProfileElement({
    required IconData icon,
    required String text,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: ColorManager.primary, size: _Styles.iconSize),
          SizedBox(height: 5),
          Text(
            text,
            style: _Styles.profileElementTextStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget getProfileCardBottom() {
    return Column(
      children: [
        CustomProfileRowElement(
          icon: Icons.person,
          text: 'Edit Profile',
          onTap: onEditProfilePressed,
        ),
        CustomProfileRowElement(
          icon: Icons.lock,
          text: 'Change Password',
          onTap: onChangePasswordPressed,
        ),
        CustomProfileRowElement(
          icon: Icons.history,
          text: 'Completed Recycle',
          onTap: onCompletedRequestPressed,
        ),
        CustomProfileRowElement(icon: Icons.shopping_bag, text: 'My Purchases'),
        CustomProfileRowElement(
          icon: Icons.logout,
          text: 'Sign Out',
          isSignOut: true,
        ),
      ],
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const iconSize = 35.0;
  static const maxTextLines = 2;

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const usernameTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const pointTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const profileElementTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );
}
