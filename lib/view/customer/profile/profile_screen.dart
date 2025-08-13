import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/user/user_model.dart';
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
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
      child: _ProfileScreen(),
    );
  }
}

class _ProfileScreen extends StatefulWidget {
  @override
  State<_ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<_ProfileScreen>
    with ErrorHandlingMixin {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final user =
        context.select((UserViewModel vm) => vm.userDetails) ?? UserModel();

    return Scaffold(
      appBar: CustomAppBar(title: 'Profile', isBackButtonVisible: false),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: _Styles.screenPadding,
            child: Column(
              children: [
                getProfileDetails(user: user),
                SizedBox(height: 25),
                Divider(color: ColorManager.lightGreyColor),
                SizedBox(height: 25),
                getProfileCard(
                  userRole: user.userRole ?? '',
                  userID: user.userID ?? '',
                ),
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
  void onRewardsPressed() async {
    final result = await context.router.push(RewardRoute());

    if (result == true && mounted) {
      fetchData();
    }
  }

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

  void onPointsPressed() {
    context.router.push(PointsRoute());
  }

  void onCompletedRequestPressed() {
    context.router.push(CompletedRequestRoute());
  }

  void onMyPurchasesPressed() {
    context.router.push(MyPurchasesRoute());
  }

  void onMyListingPressed() {
    context.router.push(MyListingRoute());
  }

  Future<void> fetchData() async {
    final userID = context.read<UserViewModel>().user?.userID ?? '';

    await tryLoad(
      context,
      () => context.read<UserViewModel>().getUserDetails(userID: userID),
    );
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
extension _WidgetFactories on _ProfileScreenState {
  Widget getProfileDetails({required UserModel user}) {
    return Row(
      children: [
        CustomProfileImage(
          imageURL: user.profileImageURL ?? '',
          imageSize: _Styles.imageSize,
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${user.firstName ?? '-'} ${user.lastName ?? ''}',
                style: _Styles.usernameTextStyle,
                maxLines: _Styles.maxTextLines,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 10),
              Text(
                '${user.currentPoint ?? 0} points',
                style: _Styles.pointTextStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getProfileCard({required String userRole, required String userID}) {
    return CustomCard(
      padding: _Styles.customCardPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getProfileCardTop(),
          SizedBox(height: 15),
          Divider(color: ColorManager.lightGreyColor),
          getProfileCardBottom(userRole: userRole, userID: userID),
        ],
      ),
    );
  }

  Widget getProfileCardTop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getProfileElement(
          icon: Icons.card_giftcard_outlined,
          text: 'Rewards',
          onPressed: onRewardsPressed,
        ),
        getProfileElement(
          icon: FontAwesomeIcons.coins,
          text: 'Points',
          onPressed: onPointsPressed,
        ),
        getProfileElement(
          icon: Icons.archive_rounded,
          text: 'My Listing',
          onPressed: onMyListingPressed,
        ),
      ],
    );
  }

  Widget getProfileElement({
    required IconData icon,
    required String text,
    void Function()? onPressed,
  }) {
    return TouchableOpacity(
      onPressed: onPressed,
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

  Widget getProfileCardBottom({
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
          text: 'Completed Recycle',
          onPressed: onCompletedRequestPressed,
        ),
        CustomProfileRowElement(
          icon: Icons.shopping_bag,
          text: 'My Purchases',
          onPressed: onMyPurchasesPressed,
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

  static const iconSize = 35.0;
  static const maxTextLines = 2;
  static const imageSize = 80.0;

  static const customCardPadding = EdgeInsets.all(20);

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const usernameTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.semiBold,
    color: ColorManager.blackColor,
  );

  static const pointTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const profileElementTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );
}
