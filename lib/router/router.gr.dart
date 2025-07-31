// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i49;
import 'package:flutter/material.dart' as _i50;
import 'package:green_cycle_fyp/view/admin/collector_details/collector_details_screen.dart'
    as _i12;
import 'package:green_cycle_fyp/view/admin/dashboard/admin_dashboard_screen.dart'
    as _i3;
import 'package:green_cycle_fyp/view/admin/manage_awareness/add_edit_awareness_screen.dart'
    as _i1;
import 'package:green_cycle_fyp/view/admin/manage_awareness/manage_awareness_screen.dart'
    as _i27;
import 'package:green_cycle_fyp/view/admin/manage_collectors/manage_collectors_screen.dart'
    as _i28;
import 'package:green_cycle_fyp/view/admin/manage_requests/manage_requests_screen.dart'
    as _i29;
import 'package:green_cycle_fyp/view/admin/manage_reward/add_edit_reward_screen.dart'
    as _i2;
import 'package:green_cycle_fyp/view/admin/manage_reward/manage_rewards_screen.dart'
    as _i30;
import 'package:green_cycle_fyp/view/admin/pickup_request_details/pickup_request_details_screen.dart'
    as _i38;
import 'package:green_cycle_fyp/view/admin/profile/admin_profile_screen.dart'
    as _i4;
import 'package:green_cycle_fyp/view/auth/collector_additional_signup_screen.dart'
    as _i11;
import 'package:green_cycle_fyp/view/auth/login_screen.dart' as _i26;
import 'package:green_cycle_fyp/view/auth/signup_screen.dart' as _i48;
import 'package:green_cycle_fyp/view/collector/available_pickup_request/available_pickup_request_screen.dart'
    as _i5;
import 'package:green_cycle_fyp/view/collector/collector_home/collector_home_screen.dart'
    as _i13;
import 'package:green_cycle_fyp/view/collector/complete_pickup/complete_pickup_screen.dart'
    as _i16;
import 'package:green_cycle_fyp/view/collector/my_pickup/my_pickup_screen.dart'
    as _i34;
import 'package:green_cycle_fyp/view/collector/pickup_history/pickup_history_screen.dart'
    as _i37;
import 'package:green_cycle_fyp/view/collector/pickup_request_details/collector_pickup_request_details_screen.dart'
    as _i14;
import 'package:green_cycle_fyp/view/collector/profile/collector_profile_screen.dart'
    as _i15;
import 'package:green_cycle_fyp/view/common/awareness_details_screen.dart'
    as _i6;
import 'package:green_cycle_fyp/view/common/change_password_screen.dart' as _i9;
import 'package:green_cycle_fyp/view/common/edit_profile_screen.dart' as _i22;
import 'package:green_cycle_fyp/view/common/init_screen.dart' as _i23;
import 'package:green_cycle_fyp/view/common/loading_screen.dart' as _i25;
import 'package:green_cycle_fyp/view/customer/awareness/awareness_screen.dart'
    as _i7;
import 'package:green_cycle_fyp/view/customer/cart/cart_screen.dart' as _i8;
import 'package:green_cycle_fyp/view/customer/checkout/checkout_screen.dart'
    as _i10;
import 'package:green_cycle_fyp/view/customer/completed_request/completed_request_screen.dart'
    as _i17;
import 'package:green_cycle_fyp/view/customer/create_listing/create_listing_screen.dart'
    as _i18;
import 'package:green_cycle_fyp/view/customer/edit_listing/edit_listing_screen.dart'
    as _i21;
import 'package:green_cycle_fyp/view/customer/home/home_screen.dart' as _i20;
import 'package:green_cycle_fyp/view/customer/item_details/item_details_screen.dart'
    as _i24;
import 'package:green_cycle_fyp/view/customer/marketplace/marketplace_screen.dart'
    as _i32;
import 'package:green_cycle_fyp/view/customer/marketplace_category/marketplace_category_screen.dart'
    as _i31;
import 'package:green_cycle_fyp/view/customer/my_listing/my_listing_screen.dart'
    as _i33;
import 'package:green_cycle_fyp/view/customer/my_purchases/my_purchases_screen.dart'
    as _i35;
import 'package:green_cycle_fyp/view/customer/points/points_screen.dart'
    as _i39;
import 'package:green_cycle_fyp/view/customer/profile/profile_screen.dart'
    as _i40;
import 'package:green_cycle_fyp/view/customer/request/request_screen.dart'
    as _i43;
import 'package:green_cycle_fyp/view/customer/request_details/request_details_screen.dart'
    as _i41;
import 'package:green_cycle_fyp/view/customer/request_for_pickup/request_item_details_screen.dart'
    as _i42;
import 'package:green_cycle_fyp/view/customer/request_for_pickup/request_summary_screen.dart'
    as _i44;
import 'package:green_cycle_fyp/view/customer/request_for_pickup/schedule_pickup_screen.dart'
    as _i46;
import 'package:green_cycle_fyp/view/customer/request_for_pickup/select_location_screen.dart'
    as _i47;
import 'package:green_cycle_fyp/view/customer/reward/reward_screen.dart'
    as _i45;
import 'package:green_cycle_fyp/view/onboarding_screen.dart' as _i36;
import 'package:green_cycle_fyp/widget/custom_bottom_nav_bar.dart' as _i19;

/// generated route for
/// [_i1.AddOrEditAwarenessScreen]
class AddOrEditAwarenessRoute
    extends _i49.PageRouteInfo<AddOrEditAwarenessRouteArgs> {
  AddOrEditAwarenessRoute({
    _i50.Key? key,
    required bool isEdit,
    int? awarenessId,
    List<_i49.PageRouteInfo>? children,
  }) : super(
         AddOrEditAwarenessRoute.name,
         args: AddOrEditAwarenessRouteArgs(
           key: key,
           isEdit: isEdit,
           awarenessId: awarenessId,
         ),
         initialChildren: children,
       );

  static const String name = 'AddOrEditAwarenessRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddOrEditAwarenessRouteArgs>();
      return _i1.AddOrEditAwarenessScreen(
        key: args.key,
        isEdit: args.isEdit,
        awarenessId: args.awarenessId,
      );
    },
  );
}

class AddOrEditAwarenessRouteArgs {
  const AddOrEditAwarenessRouteArgs({
    this.key,
    required this.isEdit,
    this.awarenessId,
  });

  final _i50.Key? key;

  final bool isEdit;

  final int? awarenessId;

  @override
  String toString() {
    return 'AddOrEditAwarenessRouteArgs{key: $key, isEdit: $isEdit, awarenessId: $awarenessId}';
  }
}

/// generated route for
/// [_i2.AddOrEditRewardScreen]
class AddOrEditRewardRoute
    extends _i49.PageRouteInfo<AddOrEditRewardRouteArgs> {
  AddOrEditRewardRoute({
    _i50.Key? key,
    required bool isEdit,
    int? rewardId,
    List<_i49.PageRouteInfo>? children,
  }) : super(
         AddOrEditRewardRoute.name,
         args: AddOrEditRewardRouteArgs(
           key: key,
           isEdit: isEdit,
           rewardId: rewardId,
         ),
         initialChildren: children,
       );

  static const String name = 'AddOrEditRewardRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddOrEditRewardRouteArgs>();
      return _i2.AddOrEditRewardScreen(
        key: args.key,
        isEdit: args.isEdit,
        rewardId: args.rewardId,
      );
    },
  );
}

class AddOrEditRewardRouteArgs {
  const AddOrEditRewardRouteArgs({
    this.key,
    required this.isEdit,
    this.rewardId,
  });

  final _i50.Key? key;

  final bool isEdit;

  final int? rewardId;

  @override
  String toString() {
    return 'AddOrEditRewardRouteArgs{key: $key, isEdit: $isEdit, rewardId: $rewardId}';
  }
}

/// generated route for
/// [_i3.AdminDashboardScreen]
class AdminDashboardRoute extends _i49.PageRouteInfo<void> {
  const AdminDashboardRoute({List<_i49.PageRouteInfo>? children})
    : super(AdminDashboardRoute.name, initialChildren: children);

  static const String name = 'AdminDashboardRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i3.AdminDashboardScreen();
    },
  );
}

/// generated route for
/// [_i4.AdminProfileScreen]
class AdminProfileRoute extends _i49.PageRouteInfo<void> {
  const AdminProfileRoute({List<_i49.PageRouteInfo>? children})
    : super(AdminProfileRoute.name, initialChildren: children);

  static const String name = 'AdminProfileRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i4.AdminProfileScreen();
    },
  );
}

/// generated route for
/// [_i5.AvailablePickupRequestScreen]
class AvailablePickupRequestRoute extends _i49.PageRouteInfo<void> {
  const AvailablePickupRequestRoute({List<_i49.PageRouteInfo>? children})
    : super(AvailablePickupRequestRoute.name, initialChildren: children);

  static const String name = 'AvailablePickupRequestRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i5.AvailablePickupRequestScreen();
    },
  );
}

/// generated route for
/// [_i6.AwarenessDetailsScreen]
class AwarenessDetailsRoute
    extends _i49.PageRouteInfo<AwarenessDetailsRouteArgs> {
  AwarenessDetailsRoute({
    _i50.Key? key,
    required String userRole,
    required int awarenessId,
    List<_i49.PageRouteInfo>? children,
  }) : super(
         AwarenessDetailsRoute.name,
         args: AwarenessDetailsRouteArgs(
           key: key,
           userRole: userRole,
           awarenessId: awarenessId,
         ),
         initialChildren: children,
       );

  static const String name = 'AwarenessDetailsRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AwarenessDetailsRouteArgs>();
      return _i6.AwarenessDetailsScreen(
        key: args.key,
        userRole: args.userRole,
        awarenessId: args.awarenessId,
      );
    },
  );
}

class AwarenessDetailsRouteArgs {
  const AwarenessDetailsRouteArgs({
    this.key,
    required this.userRole,
    required this.awarenessId,
  });

  final _i50.Key? key;

  final String userRole;

  final int awarenessId;

  @override
  String toString() {
    return 'AwarenessDetailsRouteArgs{key: $key, userRole: $userRole, awarenessId: $awarenessId}';
  }
}

/// generated route for
/// [_i7.AwarenessScreen]
class AwarenessRoute extends _i49.PageRouteInfo<void> {
  const AwarenessRoute({List<_i49.PageRouteInfo>? children})
    : super(AwarenessRoute.name, initialChildren: children);

  static const String name = 'AwarenessRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i7.AwarenessScreen();
    },
  );
}

/// generated route for
/// [_i8.CartScreen]
class CartRoute extends _i49.PageRouteInfo<void> {
  const CartRoute({List<_i49.PageRouteInfo>? children})
    : super(CartRoute.name, initialChildren: children);

  static const String name = 'CartRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i8.CartScreen();
    },
  );
}

/// generated route for
/// [_i9.ChangePasswordScreen]
class ChangePasswordRoute extends _i49.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i49.PageRouteInfo>? children})
    : super(ChangePasswordRoute.name, initialChildren: children);

  static const String name = 'ChangePasswordRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i9.ChangePasswordScreen();
    },
  );
}

/// generated route for
/// [_i10.CheckoutScreen]
class CheckoutRoute extends _i49.PageRouteInfo<void> {
  const CheckoutRoute({List<_i49.PageRouteInfo>? children})
    : super(CheckoutRoute.name, initialChildren: children);

  static const String name = 'CheckoutRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i10.CheckoutScreen();
    },
  );
}

/// generated route for
/// [_i11.CollectorAdditionalSignupScreen]
class CollectorAdditionalSignupRoute
    extends _i49.PageRouteInfo<CollectorAdditionalSignupRouteArgs> {
  CollectorAdditionalSignupRoute({
    _i50.Key? key,
    required String userRole,
    required String fullName,
    required String emailAddress,
    required String gender,
    required String phoneNumber,
    required String password,
    List<_i49.PageRouteInfo>? children,
  }) : super(
         CollectorAdditionalSignupRoute.name,
         args: CollectorAdditionalSignupRouteArgs(
           key: key,
           userRole: userRole,
           fullName: fullName,
           emailAddress: emailAddress,
           gender: gender,
           phoneNumber: phoneNumber,
           password: password,
         ),
         initialChildren: children,
       );

  static const String name = 'CollectorAdditionalSignupRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CollectorAdditionalSignupRouteArgs>();
      return _i11.CollectorAdditionalSignupScreen(
        key: args.key,
        userRole: args.userRole,
        fullName: args.fullName,
        emailAddress: args.emailAddress,
        gender: args.gender,
        phoneNumber: args.phoneNumber,
        password: args.password,
      );
    },
  );
}

class CollectorAdditionalSignupRouteArgs {
  const CollectorAdditionalSignupRouteArgs({
    this.key,
    required this.userRole,
    required this.fullName,
    required this.emailAddress,
    required this.gender,
    required this.phoneNumber,
    required this.password,
  });

  final _i50.Key? key;

  final String userRole;

  final String fullName;

  final String emailAddress;

  final String gender;

  final String phoneNumber;

  final String password;

  @override
  String toString() {
    return 'CollectorAdditionalSignupRouteArgs{key: $key, userRole: $userRole, fullName: $fullName, emailAddress: $emailAddress, gender: $gender, phoneNumber: $phoneNumber, password: $password}';
  }
}

/// generated route for
/// [_i12.CollectorDetailsScreen]
class CollectorDetailsRoute
    extends _i49.PageRouteInfo<CollectorDetailsRouteArgs> {
  CollectorDetailsRoute({
    _i50.Key? key,
    required String collectorID,
    List<_i49.PageRouteInfo>? children,
  }) : super(
         CollectorDetailsRoute.name,
         args: CollectorDetailsRouteArgs(key: key, collectorID: collectorID),
         initialChildren: children,
       );

  static const String name = 'CollectorDetailsRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CollectorDetailsRouteArgs>();
      return _i12.CollectorDetailsScreen(
        key: args.key,
        collectorID: args.collectorID,
      );
    },
  );
}

class CollectorDetailsRouteArgs {
  const CollectorDetailsRouteArgs({this.key, required this.collectorID});

  final _i50.Key? key;

  final String collectorID;

  @override
  String toString() {
    return 'CollectorDetailsRouteArgs{key: $key, collectorID: $collectorID}';
  }
}

/// generated route for
/// [_i13.CollectorHomeScreen]
class CollectorHomeRoute extends _i49.PageRouteInfo<void> {
  const CollectorHomeRoute({List<_i49.PageRouteInfo>? children})
    : super(CollectorHomeRoute.name, initialChildren: children);

  static const String name = 'CollectorHomeRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i13.CollectorHomeScreen();
    },
  );
}

/// generated route for
/// [_i14.CollectorPickupRequestDetailsScreen]
class CollectorPickupRequestDetailsRoute
    extends _i49.PageRouteInfo<CollectorPickupRequestDetailsRouteArgs> {
  CollectorPickupRequestDetailsRoute({
    _i50.Key? key,
    String? requestStatus,
    List<_i49.PageRouteInfo>? children,
  }) : super(
         CollectorPickupRequestDetailsRoute.name,
         args: CollectorPickupRequestDetailsRouteArgs(
           key: key,
           requestStatus: requestStatus,
         ),
         initialChildren: children,
       );

  static const String name = 'CollectorPickupRequestDetailsRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CollectorPickupRequestDetailsRouteArgs>(
        orElse: () => const CollectorPickupRequestDetailsRouteArgs(),
      );
      return _i14.CollectorPickupRequestDetailsScreen(
        key: args.key,
        requestStatus: args.requestStatus,
      );
    },
  );
}

class CollectorPickupRequestDetailsRouteArgs {
  const CollectorPickupRequestDetailsRouteArgs({this.key, this.requestStatus});

  final _i50.Key? key;

  final String? requestStatus;

  @override
  String toString() {
    return 'CollectorPickupRequestDetailsRouteArgs{key: $key, requestStatus: $requestStatus}';
  }
}

/// generated route for
/// [_i15.CollectorProfileScreen]
class CollectorProfileRoute extends _i49.PageRouteInfo<void> {
  const CollectorProfileRoute({List<_i49.PageRouteInfo>? children})
    : super(CollectorProfileRoute.name, initialChildren: children);

  static const String name = 'CollectorProfileRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i15.CollectorProfileScreen();
    },
  );
}

/// generated route for
/// [_i16.CompletePickupScreen]
class CompletePickupRoute extends _i49.PageRouteInfo<void> {
  const CompletePickupRoute({List<_i49.PageRouteInfo>? children})
    : super(CompletePickupRoute.name, initialChildren: children);

  static const String name = 'CompletePickupRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i16.CompletePickupScreen();
    },
  );
}

/// generated route for
/// [_i17.CompletedRequestScreen]
class CompletedRequestRoute extends _i49.PageRouteInfo<void> {
  const CompletedRequestRoute({List<_i49.PageRouteInfo>? children})
    : super(CompletedRequestRoute.name, initialChildren: children);

  static const String name = 'CompletedRequestRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i17.CompletedRequestScreen();
    },
  );
}

/// generated route for
/// [_i18.CreateListingScreen]
class CreateListingRoute extends _i49.PageRouteInfo<void> {
  const CreateListingRoute({List<_i49.PageRouteInfo>? children})
    : super(CreateListingRoute.name, initialChildren: children);

  static const String name = 'CreateListingRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i18.CreateListingScreen();
    },
  );
}

/// generated route for
/// [_i19.CustomBottomNavBar]
class CustomBottomNavBar extends _i49.PageRouteInfo<CustomBottomNavBarArgs> {
  CustomBottomNavBar({
    _i50.Key? key,
    required String userRole,
    List<_i49.PageRouteInfo>? children,
  }) : super(
         CustomBottomNavBar.name,
         args: CustomBottomNavBarArgs(key: key, userRole: userRole),
         initialChildren: children,
       );

  static const String name = 'CustomBottomNavBar';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CustomBottomNavBarArgs>();
      return _i19.CustomBottomNavBar(key: args.key, userRole: args.userRole);
    },
  );
}

class CustomBottomNavBarArgs {
  const CustomBottomNavBarArgs({this.key, required this.userRole});

  final _i50.Key? key;

  final String userRole;

  @override
  String toString() {
    return 'CustomBottomNavBarArgs{key: $key, userRole: $userRole}';
  }
}

/// generated route for
/// [_i20.CustomerHomeScreen]
class CustomerHomeRoute extends _i49.PageRouteInfo<void> {
  const CustomerHomeRoute({List<_i49.PageRouteInfo>? children})
    : super(CustomerHomeRoute.name, initialChildren: children);

  static const String name = 'CustomerHomeRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i20.CustomerHomeScreen();
    },
  );
}

/// generated route for
/// [_i21.EditListingScreen]
class EditListingRoute extends _i49.PageRouteInfo<void> {
  const EditListingRoute({List<_i49.PageRouteInfo>? children})
    : super(EditListingRoute.name, initialChildren: children);

  static const String name = 'EditListingRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i21.EditListingScreen();
    },
  );
}

/// generated route for
/// [_i22.EditProfileScreen]
class EditProfileRoute extends _i49.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    _i50.Key? key,
    required String userRole,
    required String userID,
    List<_i49.PageRouteInfo>? children,
  }) : super(
         EditProfileRoute.name,
         args: EditProfileRouteArgs(
           key: key,
           userRole: userRole,
           userID: userID,
         ),
         initialChildren: children,
       );

  static const String name = 'EditProfileRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditProfileRouteArgs>();
      return _i22.EditProfileScreen(
        key: args.key,
        userRole: args.userRole,
        userID: args.userID,
      );
    },
  );
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({
    this.key,
    required this.userRole,
    required this.userID,
  });

  final _i50.Key? key;

  final String userRole;

  final String userID;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, userRole: $userRole, userID: $userID}';
  }
}

/// generated route for
/// [_i23.InitScreen]
class InitRoute extends _i49.PageRouteInfo<void> {
  const InitRoute({List<_i49.PageRouteInfo>? children})
    : super(InitRoute.name, initialChildren: children);

  static const String name = 'InitRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i23.InitScreen();
    },
  );
}

/// generated route for
/// [_i24.ItemDetailsScreen]
class ItemDetailsRoute extends _i49.PageRouteInfo<void> {
  const ItemDetailsRoute({List<_i49.PageRouteInfo>? children})
    : super(ItemDetailsRoute.name, initialChildren: children);

  static const String name = 'ItemDetailsRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i24.ItemDetailsScreen();
    },
  );
}

/// generated route for
/// [_i25.LoadingScreen]
class LoadingRoute extends _i49.PageRouteInfo<void> {
  const LoadingRoute({List<_i49.PageRouteInfo>? children})
    : super(LoadingRoute.name, initialChildren: children);

  static const String name = 'LoadingRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i25.LoadingScreen();
    },
  );
}

/// generated route for
/// [_i26.LoginScreen]
class LoginRoute extends _i49.PageRouteInfo<void> {
  const LoginRoute({List<_i49.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i26.LoginScreen();
    },
  );
}

/// generated route for
/// [_i27.ManageAwarenessScreen]
class ManageAwarenessRoute extends _i49.PageRouteInfo<void> {
  const ManageAwarenessRoute({List<_i49.PageRouteInfo>? children})
    : super(ManageAwarenessRoute.name, initialChildren: children);

  static const String name = 'ManageAwarenessRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i27.ManageAwarenessScreen();
    },
  );
}

/// generated route for
/// [_i28.ManageCollectorsScreen]
class ManageCollectorsRoute extends _i49.PageRouteInfo<void> {
  const ManageCollectorsRoute({List<_i49.PageRouteInfo>? children})
    : super(ManageCollectorsRoute.name, initialChildren: children);

  static const String name = 'ManageCollectorsRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i28.ManageCollectorsScreen();
    },
  );
}

/// generated route for
/// [_i29.ManageRequestsScreen]
class ManageRequestsRoute extends _i49.PageRouteInfo<void> {
  const ManageRequestsRoute({List<_i49.PageRouteInfo>? children})
    : super(ManageRequestsRoute.name, initialChildren: children);

  static const String name = 'ManageRequestsRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i29.ManageRequestsScreen();
    },
  );
}

/// generated route for
/// [_i30.ManageRewardsScreen]
class ManageRewardsRoute extends _i49.PageRouteInfo<void> {
  const ManageRewardsRoute({List<_i49.PageRouteInfo>? children})
    : super(ManageRewardsRoute.name, initialChildren: children);

  static const String name = 'ManageRewardsRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i30.ManageRewardsScreen();
    },
  );
}

/// generated route for
/// [_i31.MarketplaceCategoryScreen]
class MarketplaceCategoryRoute
    extends _i49.PageRouteInfo<MarketplaceCategoryRouteArgs> {
  MarketplaceCategoryRoute({
    _i50.Key? key,
    required String category,
    List<_i49.PageRouteInfo>? children,
  }) : super(
         MarketplaceCategoryRoute.name,
         args: MarketplaceCategoryRouteArgs(key: key, category: category),
         initialChildren: children,
       );

  static const String name = 'MarketplaceCategoryRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MarketplaceCategoryRouteArgs>();
      return _i31.MarketplaceCategoryScreen(
        key: args.key,
        category: args.category,
      );
    },
  );
}

class MarketplaceCategoryRouteArgs {
  const MarketplaceCategoryRouteArgs({this.key, required this.category});

  final _i50.Key? key;

  final String category;

  @override
  String toString() {
    return 'MarketplaceCategoryRouteArgs{key: $key, category: $category}';
  }
}

/// generated route for
/// [_i32.MarketplaceScreen]
class MarketplaceRoute extends _i49.PageRouteInfo<void> {
  const MarketplaceRoute({List<_i49.PageRouteInfo>? children})
    : super(MarketplaceRoute.name, initialChildren: children);

  static const String name = 'MarketplaceRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i32.MarketplaceScreen();
    },
  );
}

/// generated route for
/// [_i33.MyListingScreen]
class MyListingRoute extends _i49.PageRouteInfo<void> {
  const MyListingRoute({List<_i49.PageRouteInfo>? children})
    : super(MyListingRoute.name, initialChildren: children);

  static const String name = 'MyListingRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i33.MyListingScreen();
    },
  );
}

/// generated route for
/// [_i34.MyPickupScreen]
class MyPickupRoute extends _i49.PageRouteInfo<void> {
  const MyPickupRoute({List<_i49.PageRouteInfo>? children})
    : super(MyPickupRoute.name, initialChildren: children);

  static const String name = 'MyPickupRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i34.MyPickupScreen();
    },
  );
}

/// generated route for
/// [_i35.MyPurchasesScreen]
class MyPurchasesRoute extends _i49.PageRouteInfo<void> {
  const MyPurchasesRoute({List<_i49.PageRouteInfo>? children})
    : super(MyPurchasesRoute.name, initialChildren: children);

  static const String name = 'MyPurchasesRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i35.MyPurchasesScreen();
    },
  );
}

/// generated route for
/// [_i36.OnboardingScreen]
class OnboardingRoute extends _i49.PageRouteInfo<void> {
  const OnboardingRoute({List<_i49.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i36.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i37.PickupHistoryScreen]
class PickupHistoryRoute extends _i49.PageRouteInfo<void> {
  const PickupHistoryRoute({List<_i49.PageRouteInfo>? children})
    : super(PickupHistoryRoute.name, initialChildren: children);

  static const String name = 'PickupHistoryRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i37.PickupHistoryScreen();
    },
  );
}

/// generated route for
/// [_i38.PickupRequestDetailsScreen]
class PickupRequestDetailsRoute extends _i49.PageRouteInfo<void> {
  const PickupRequestDetailsRoute({List<_i49.PageRouteInfo>? children})
    : super(PickupRequestDetailsRoute.name, initialChildren: children);

  static const String name = 'PickupRequestDetailsRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i38.PickupRequestDetailsScreen();
    },
  );
}

/// generated route for
/// [_i39.PointsScreen]
class PointsRoute extends _i49.PageRouteInfo<void> {
  const PointsRoute({List<_i49.PageRouteInfo>? children})
    : super(PointsRoute.name, initialChildren: children);

  static const String name = 'PointsRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i39.PointsScreen();
    },
  );
}

/// generated route for
/// [_i40.ProfileScreen]
class ProfileRoute extends _i49.PageRouteInfo<void> {
  const ProfileRoute({List<_i49.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i40.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i41.RequestDetailsScreen]
class RequestDetailsRoute extends _i49.PageRouteInfo<void> {
  const RequestDetailsRoute({List<_i49.PageRouteInfo>? children})
    : super(RequestDetailsRoute.name, initialChildren: children);

  static const String name = 'RequestDetailsRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i41.RequestDetailsScreen();
    },
  );
}

/// generated route for
/// [_i42.RequestItemDetailsScreen]
class RequestItemDetailsRoute extends _i49.PageRouteInfo<void> {
  const RequestItemDetailsRoute({List<_i49.PageRouteInfo>? children})
    : super(RequestItemDetailsRoute.name, initialChildren: children);

  static const String name = 'RequestItemDetailsRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i42.RequestItemDetailsScreen();
    },
  );
}

/// generated route for
/// [_i43.RequestScreen]
class RequestRoute extends _i49.PageRouteInfo<void> {
  const RequestRoute({List<_i49.PageRouteInfo>? children})
    : super(RequestRoute.name, initialChildren: children);

  static const String name = 'RequestRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i43.RequestScreen();
    },
  );
}

/// generated route for
/// [_i44.RequestSummaryScreen]
class RequestSummaryRoute extends _i49.PageRouteInfo<void> {
  const RequestSummaryRoute({List<_i49.PageRouteInfo>? children})
    : super(RequestSummaryRoute.name, initialChildren: children);

  static const String name = 'RequestSummaryRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i44.RequestSummaryScreen();
    },
  );
}

/// generated route for
/// [_i45.RewardScreen]
class RewardRoute extends _i49.PageRouteInfo<void> {
  const RewardRoute({List<_i49.PageRouteInfo>? children})
    : super(RewardRoute.name, initialChildren: children);

  static const String name = 'RewardRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i45.RewardScreen();
    },
  );
}

/// generated route for
/// [_i46.SchedulePickupScreen]
class SchedulePickupRoute extends _i49.PageRouteInfo<void> {
  const SchedulePickupRoute({List<_i49.PageRouteInfo>? children})
    : super(SchedulePickupRoute.name, initialChildren: children);

  static const String name = 'SchedulePickupRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i46.SchedulePickupScreen();
    },
  );
}

/// generated route for
/// [_i47.SelectLocationScreen]
class SelectLocationRoute extends _i49.PageRouteInfo<void> {
  const SelectLocationRoute({List<_i49.PageRouteInfo>? children})
    : super(SelectLocationRoute.name, initialChildren: children);

  static const String name = 'SelectLocationRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i47.SelectLocationScreen();
    },
  );
}

/// generated route for
/// [_i48.SignUpScreen]
class SignUpRoute extends _i49.PageRouteInfo<void> {
  const SignUpRoute({List<_i49.PageRouteInfo>? children})
    : super(SignUpRoute.name, initialChildren: children);

  static const String name = 'SignUpRoute';

  static _i49.PageInfo page = _i49.PageInfo(
    name,
    builder: (data) {
      return const _i48.SignUpScreen();
    },
  );
}
