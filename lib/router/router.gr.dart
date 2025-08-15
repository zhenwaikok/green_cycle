// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i51;
import 'package:flutter/material.dart' as _i52;
import 'package:green_cycle_fyp/model/api_model/cart/cart_model.dart' as _i53;
import 'package:green_cycle_fyp/model/api_model/pickup_request/pickup_request_model.dart'
    as _i54;
import 'package:green_cycle_fyp/view/admin/collector_details/collector_details_screen.dart'
    as _i13;
import 'package:green_cycle_fyp/view/admin/dashboard/admin_dashboard_screen.dart'
    as _i4;
import 'package:green_cycle_fyp/view/admin/manage_awareness/add_edit_awareness_screen.dart'
    as _i2;
import 'package:green_cycle_fyp/view/admin/manage_awareness/manage_awareness_screen.dart'
    as _i27;
import 'package:green_cycle_fyp/view/admin/manage_collectors/manage_collectors_screen.dart'
    as _i28;
import 'package:green_cycle_fyp/view/admin/manage_requests/manage_requests_screen.dart'
    as _i29;
import 'package:green_cycle_fyp/view/admin/manage_reward/add_edit_reward_screen.dart'
    as _i3;
import 'package:green_cycle_fyp/view/admin/manage_reward/manage_rewards_screen.dart'
    as _i30;
import 'package:green_cycle_fyp/view/admin/pickup_request_details/pickup_request_details_screen.dart'
    as _i38;
import 'package:green_cycle_fyp/view/admin/profile/admin_profile_screen.dart'
    as _i5;
import 'package:green_cycle_fyp/view/auth/collector_additional_signup_screen.dart'
    as _i12;
import 'package:green_cycle_fyp/view/auth/login_screen.dart' as _i26;
import 'package:green_cycle_fyp/view/auth/signup_screen.dart' as _i49;
import 'package:green_cycle_fyp/view/collector/available_pickup_request/available_pickup_request_screen.dart'
    as _i6;
import 'package:green_cycle_fyp/view/collector/collector_home/collector_home_screen.dart'
    as _i14;
import 'package:green_cycle_fyp/view/collector/complete_pickup/complete_pickup_screen.dart'
    as _i17;
import 'package:green_cycle_fyp/view/collector/my_pickup/my_pickup_screen.dart'
    as _i34;
import 'package:green_cycle_fyp/view/collector/pickup_history/pickup_history_screen.dart'
    as _i37;
import 'package:green_cycle_fyp/view/collector/pickup_request_details/collector_pickup_request_details_screen.dart'
    as _i15;
import 'package:green_cycle_fyp/view/collector/profile/collector_profile_screen.dart'
    as _i16;
import 'package:green_cycle_fyp/view/common/awareness_details_screen.dart'
    as _i7;
import 'package:green_cycle_fyp/view/common/change_password_screen.dart'
    as _i10;
import 'package:green_cycle_fyp/view/common/edit_profile_screen.dart' as _i22;
import 'package:green_cycle_fyp/view/common/init_screen.dart' as _i23;
import 'package:green_cycle_fyp/view/common/loading_screen.dart' as _i25;
import 'package:green_cycle_fyp/view/common/success_screen.dart' as _i50;
import 'package:green_cycle_fyp/view/customer/add_edit_address/add_edit_address_screen.dart'
    as _i1;
import 'package:green_cycle_fyp/view/customer/awareness/awareness_screen.dart'
    as _i8;
import 'package:green_cycle_fyp/view/customer/cart/cart_screen.dart' as _i9;
import 'package:green_cycle_fyp/view/customer/checkout/checkout_screen.dart'
    as _i11;
import 'package:green_cycle_fyp/view/customer/completed_request/completed_request_screen.dart'
    as _i18;
import 'package:green_cycle_fyp/view/customer/create_listing/create_edit_listing_screen.dart'
    as _i19;
import 'package:green_cycle_fyp/view/customer/home/home_screen.dart' as _i21;
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
    as _i44;
import 'package:green_cycle_fyp/view/customer/request_details/request_details_screen.dart'
    as _i41;
import 'package:green_cycle_fyp/view/customer/request_for_pickup/request_item_details_screen.dart'
    as _i42;
import 'package:green_cycle_fyp/view/customer/request_for_pickup/request_summary_screen.dart'
    as _i45;
import 'package:green_cycle_fyp/view/customer/request_for_pickup/schedule_pickup_screen.dart'
    as _i47;
import 'package:green_cycle_fyp/view/customer/request_for_pickup/select_location_screen.dart'
    as _i48;
import 'package:green_cycle_fyp/view/customer/request_location_tracking/request_location_tracking_screen.dart'
    as _i43;
import 'package:green_cycle_fyp/view/customer/reward/reward_screen.dart'
    as _i46;
import 'package:green_cycle_fyp/view/onboarding_screen.dart' as _i36;
import 'package:green_cycle_fyp/widget/custom_bottom_nav_bar.dart' as _i20;

/// generated route for
/// [_i1.AddOrEditAddressScreen]
class AddOrEditAddressRoute
    extends _i51.PageRouteInfo<AddOrEditAddressRouteArgs> {
  AddOrEditAddressRoute({
    _i52.Key? key,
    required bool isAddAddress,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         AddOrEditAddressRoute.name,
         args: AddOrEditAddressRouteArgs(key: key, isAddAddress: isAddAddress),
         initialChildren: children,
       );

  static const String name = 'AddOrEditAddressRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddOrEditAddressRouteArgs>();
      return _i1.AddOrEditAddressScreen(
        key: args.key,
        isAddAddress: args.isAddAddress,
      );
    },
  );
}

class AddOrEditAddressRouteArgs {
  const AddOrEditAddressRouteArgs({this.key, required this.isAddAddress});

  final _i52.Key? key;

  final bool isAddAddress;

  @override
  String toString() {
    return 'AddOrEditAddressRouteArgs{key: $key, isAddAddress: $isAddAddress}';
  }
}

/// generated route for
/// [_i2.AddOrEditAwarenessScreen]
class AddOrEditAwarenessRoute
    extends _i51.PageRouteInfo<AddOrEditAwarenessRouteArgs> {
  AddOrEditAwarenessRoute({
    _i52.Key? key,
    required bool isEdit,
    int? awarenessId,
    List<_i51.PageRouteInfo>? children,
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

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddOrEditAwarenessRouteArgs>();
      return _i2.AddOrEditAwarenessScreen(
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

  final _i52.Key? key;

  final bool isEdit;

  final int? awarenessId;

  @override
  String toString() {
    return 'AddOrEditAwarenessRouteArgs{key: $key, isEdit: $isEdit, awarenessId: $awarenessId}';
  }
}

/// generated route for
/// [_i3.AddOrEditRewardScreen]
class AddOrEditRewardRoute
    extends _i51.PageRouteInfo<AddOrEditRewardRouteArgs> {
  AddOrEditRewardRoute({
    _i52.Key? key,
    required bool isEdit,
    int? rewardId,
    List<_i51.PageRouteInfo>? children,
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

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddOrEditRewardRouteArgs>();
      return _i3.AddOrEditRewardScreen(
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

  final _i52.Key? key;

  final bool isEdit;

  final int? rewardId;

  @override
  String toString() {
    return 'AddOrEditRewardRouteArgs{key: $key, isEdit: $isEdit, rewardId: $rewardId}';
  }
}

/// generated route for
/// [_i4.AdminDashboardScreen]
class AdminDashboardRoute extends _i51.PageRouteInfo<void> {
  const AdminDashboardRoute({List<_i51.PageRouteInfo>? children})
    : super(AdminDashboardRoute.name, initialChildren: children);

  static const String name = 'AdminDashboardRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i4.AdminDashboardScreen();
    },
  );
}

/// generated route for
/// [_i5.AdminProfileScreen]
class AdminProfileRoute extends _i51.PageRouteInfo<void> {
  const AdminProfileRoute({List<_i51.PageRouteInfo>? children})
    : super(AdminProfileRoute.name, initialChildren: children);

  static const String name = 'AdminProfileRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i5.AdminProfileScreen();
    },
  );
}

/// generated route for
/// [_i6.AvailablePickupRequestScreen]
class AvailablePickupRequestRoute extends _i51.PageRouteInfo<void> {
  const AvailablePickupRequestRoute({List<_i51.PageRouteInfo>? children})
    : super(AvailablePickupRequestRoute.name, initialChildren: children);

  static const String name = 'AvailablePickupRequestRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i6.AvailablePickupRequestScreen();
    },
  );
}

/// generated route for
/// [_i7.AwarenessDetailsScreen]
class AwarenessDetailsRoute
    extends _i51.PageRouteInfo<AwarenessDetailsRouteArgs> {
  AwarenessDetailsRoute({
    _i52.Key? key,
    required String userRole,
    required int awarenessId,
    List<_i51.PageRouteInfo>? children,
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

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AwarenessDetailsRouteArgs>();
      return _i7.AwarenessDetailsScreen(
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

  final _i52.Key? key;

  final String userRole;

  final int awarenessId;

  @override
  String toString() {
    return 'AwarenessDetailsRouteArgs{key: $key, userRole: $userRole, awarenessId: $awarenessId}';
  }
}

/// generated route for
/// [_i8.AwarenessScreen]
class AwarenessRoute extends _i51.PageRouteInfo<void> {
  const AwarenessRoute({List<_i51.PageRouteInfo>? children})
    : super(AwarenessRoute.name, initialChildren: children);

  static const String name = 'AwarenessRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i8.AwarenessScreen();
    },
  );
}

/// generated route for
/// [_i9.CartScreen]
class CartRoute extends _i51.PageRouteInfo<void> {
  const CartRoute({List<_i51.PageRouteInfo>? children})
    : super(CartRoute.name, initialChildren: children);

  static const String name = 'CartRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i9.CartScreen();
    },
  );
}

/// generated route for
/// [_i10.ChangePasswordScreen]
class ChangePasswordRoute extends _i51.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i51.PageRouteInfo>? children})
    : super(ChangePasswordRoute.name, initialChildren: children);

  static const String name = 'ChangePasswordRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i10.ChangePasswordScreen();
    },
  );
}

/// generated route for
/// [_i11.CheckoutScreen]
class CheckoutRoute extends _i51.PageRouteInfo<CheckoutRouteArgs> {
  CheckoutRoute({
    _i52.Key? key,
    required List<_i53.CartModel> cartItems,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         CheckoutRoute.name,
         args: CheckoutRouteArgs(key: key, cartItems: cartItems),
         initialChildren: children,
       );

  static const String name = 'CheckoutRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CheckoutRouteArgs>();
      return _i11.CheckoutScreen(key: args.key, cartItems: args.cartItems);
    },
  );
}

class CheckoutRouteArgs {
  const CheckoutRouteArgs({this.key, required this.cartItems});

  final _i52.Key? key;

  final List<_i53.CartModel> cartItems;

  @override
  String toString() {
    return 'CheckoutRouteArgs{key: $key, cartItems: $cartItems}';
  }
}

/// generated route for
/// [_i12.CollectorAdditionalSignupScreen]
class CollectorAdditionalSignupRoute
    extends _i51.PageRouteInfo<CollectorAdditionalSignupRouteArgs> {
  CollectorAdditionalSignupRoute({
    _i52.Key? key,
    required String userRole,
    required String fullName,
    required String emailAddress,
    required String gender,
    required String phoneNumber,
    required String password,
    List<_i51.PageRouteInfo>? children,
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

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CollectorAdditionalSignupRouteArgs>();
      return _i12.CollectorAdditionalSignupScreen(
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

  final _i52.Key? key;

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
/// [_i13.CollectorDetailsScreen]
class CollectorDetailsRoute
    extends _i51.PageRouteInfo<CollectorDetailsRouteArgs> {
  CollectorDetailsRoute({
    _i52.Key? key,
    required String collectorID,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         CollectorDetailsRoute.name,
         args: CollectorDetailsRouteArgs(key: key, collectorID: collectorID),
         initialChildren: children,
       );

  static const String name = 'CollectorDetailsRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CollectorDetailsRouteArgs>();
      return _i13.CollectorDetailsScreen(
        key: args.key,
        collectorID: args.collectorID,
      );
    },
  );
}

class CollectorDetailsRouteArgs {
  const CollectorDetailsRouteArgs({this.key, required this.collectorID});

  final _i52.Key? key;

  final String collectorID;

  @override
  String toString() {
    return 'CollectorDetailsRouteArgs{key: $key, collectorID: $collectorID}';
  }
}

/// generated route for
/// [_i14.CollectorHomeScreen]
class CollectorHomeRoute extends _i51.PageRouteInfo<void> {
  const CollectorHomeRoute({List<_i51.PageRouteInfo>? children})
    : super(CollectorHomeRoute.name, initialChildren: children);

  static const String name = 'CollectorHomeRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i14.CollectorHomeScreen();
    },
  );
}

/// generated route for
/// [_i15.CollectorPickupRequestDetailsScreen]
class CollectorPickupRequestDetailsRoute
    extends _i51.PageRouteInfo<CollectorPickupRequestDetailsRouteArgs> {
  CollectorPickupRequestDetailsRoute({
    _i52.Key? key,
    required String pickupRequestID,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         CollectorPickupRequestDetailsRoute.name,
         args: CollectorPickupRequestDetailsRouteArgs(
           key: key,
           pickupRequestID: pickupRequestID,
         ),
         initialChildren: children,
       );

  static const String name = 'CollectorPickupRequestDetailsRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CollectorPickupRequestDetailsRouteArgs>();
      return _i15.CollectorPickupRequestDetailsScreen(
        key: args.key,
        pickupRequestID: args.pickupRequestID,
      );
    },
  );
}

class CollectorPickupRequestDetailsRouteArgs {
  const CollectorPickupRequestDetailsRouteArgs({
    this.key,
    required this.pickupRequestID,
  });

  final _i52.Key? key;

  final String pickupRequestID;

  @override
  String toString() {
    return 'CollectorPickupRequestDetailsRouteArgs{key: $key, pickupRequestID: $pickupRequestID}';
  }
}

/// generated route for
/// [_i16.CollectorProfileScreen]
class CollectorProfileRoute extends _i51.PageRouteInfo<void> {
  const CollectorProfileRoute({List<_i51.PageRouteInfo>? children})
    : super(CollectorProfileRoute.name, initialChildren: children);

  static const String name = 'CollectorProfileRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i16.CollectorProfileScreen();
    },
  );
}

/// generated route for
/// [_i17.CompletePickupScreen]
class CompletePickupRoute extends _i51.PageRouteInfo<CompletePickupRouteArgs> {
  CompletePickupRoute({
    _i52.Key? key,
    required _i54.PickupRequestModel pickupRequestDetails,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         CompletePickupRoute.name,
         args: CompletePickupRouteArgs(
           key: key,
           pickupRequestDetails: pickupRequestDetails,
         ),
         initialChildren: children,
       );

  static const String name = 'CompletePickupRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CompletePickupRouteArgs>();
      return _i17.CompletePickupScreen(
        key: args.key,
        pickupRequestDetails: args.pickupRequestDetails,
      );
    },
  );
}

class CompletePickupRouteArgs {
  const CompletePickupRouteArgs({this.key, required this.pickupRequestDetails});

  final _i52.Key? key;

  final _i54.PickupRequestModel pickupRequestDetails;

  @override
  String toString() {
    return 'CompletePickupRouteArgs{key: $key, pickupRequestDetails: $pickupRequestDetails}';
  }
}

/// generated route for
/// [_i18.CompletedRequestScreen]
class CompletedRequestRoute extends _i51.PageRouteInfo<void> {
  const CompletedRequestRoute({List<_i51.PageRouteInfo>? children})
    : super(CompletedRequestRoute.name, initialChildren: children);

  static const String name = 'CompletedRequestRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i18.CompletedRequestScreen();
    },
  );
}

/// generated route for
/// [_i19.CreateEditListingScreen]
class CreateEditListingRoute
    extends _i51.PageRouteInfo<CreateEditListingRouteArgs> {
  CreateEditListingRoute({
    _i52.Key? key,
    required bool isEdit,
    int? itemListingID,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         CreateEditListingRoute.name,
         args: CreateEditListingRouteArgs(
           key: key,
           isEdit: isEdit,
           itemListingID: itemListingID,
         ),
         initialChildren: children,
       );

  static const String name = 'CreateEditListingRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateEditListingRouteArgs>();
      return _i19.CreateEditListingScreen(
        key: args.key,
        isEdit: args.isEdit,
        itemListingID: args.itemListingID,
      );
    },
  );
}

class CreateEditListingRouteArgs {
  const CreateEditListingRouteArgs({
    this.key,
    required this.isEdit,
    this.itemListingID,
  });

  final _i52.Key? key;

  final bool isEdit;

  final int? itemListingID;

  @override
  String toString() {
    return 'CreateEditListingRouteArgs{key: $key, isEdit: $isEdit, itemListingID: $itemListingID}';
  }
}

/// generated route for
/// [_i20.CustomBottomNavBar]
class CustomBottomNavBar extends _i51.PageRouteInfo<CustomBottomNavBarArgs> {
  CustomBottomNavBar({
    _i52.Key? key,
    required String userRole,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         CustomBottomNavBar.name,
         args: CustomBottomNavBarArgs(key: key, userRole: userRole),
         initialChildren: children,
       );

  static const String name = 'CustomBottomNavBar';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CustomBottomNavBarArgs>();
      return _i20.CustomBottomNavBar(key: args.key, userRole: args.userRole);
    },
  );
}

class CustomBottomNavBarArgs {
  const CustomBottomNavBarArgs({this.key, required this.userRole});

  final _i52.Key? key;

  final String userRole;

  @override
  String toString() {
    return 'CustomBottomNavBarArgs{key: $key, userRole: $userRole}';
  }
}

/// generated route for
/// [_i21.CustomerHomeScreen]
class CustomerHomeRoute extends _i51.PageRouteInfo<void> {
  const CustomerHomeRoute({List<_i51.PageRouteInfo>? children})
    : super(CustomerHomeRoute.name, initialChildren: children);

  static const String name = 'CustomerHomeRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i21.CustomerHomeScreen();
    },
  );
}

/// generated route for
/// [_i22.EditProfileScreen]
class EditProfileRoute extends _i51.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    _i52.Key? key,
    required String userRole,
    required String userID,
    List<_i51.PageRouteInfo>? children,
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

  static _i51.PageInfo page = _i51.PageInfo(
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

  final _i52.Key? key;

  final String userRole;

  final String userID;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, userRole: $userRole, userID: $userID}';
  }
}

/// generated route for
/// [_i23.InitScreen]
class InitRoute extends _i51.PageRouteInfo<void> {
  const InitRoute({List<_i51.PageRouteInfo>? children})
    : super(InitRoute.name, initialChildren: children);

  static const String name = 'InitRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i23.InitScreen();
    },
  );
}

/// generated route for
/// [_i24.ItemDetailsScreen]
class ItemDetailsRoute extends _i51.PageRouteInfo<ItemDetailsRouteArgs> {
  ItemDetailsRoute({
    _i52.Key? key,
    required int itemListingID,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         ItemDetailsRoute.name,
         args: ItemDetailsRouteArgs(key: key, itemListingID: itemListingID),
         initialChildren: children,
       );

  static const String name = 'ItemDetailsRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ItemDetailsRouteArgs>();
      return _i24.ItemDetailsScreen(
        key: args.key,
        itemListingID: args.itemListingID,
      );
    },
  );
}

class ItemDetailsRouteArgs {
  const ItemDetailsRouteArgs({this.key, required this.itemListingID});

  final _i52.Key? key;

  final int itemListingID;

  @override
  String toString() {
    return 'ItemDetailsRouteArgs{key: $key, itemListingID: $itemListingID}';
  }
}

/// generated route for
/// [_i25.LoadingScreen]
class LoadingRoute extends _i51.PageRouteInfo<void> {
  const LoadingRoute({List<_i51.PageRouteInfo>? children})
    : super(LoadingRoute.name, initialChildren: children);

  static const String name = 'LoadingRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i25.LoadingScreen();
    },
  );
}

/// generated route for
/// [_i26.LoginScreen]
class LoginRoute extends _i51.PageRouteInfo<void> {
  const LoginRoute({List<_i51.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i26.LoginScreen();
    },
  );
}

/// generated route for
/// [_i27.ManageAwarenessScreen]
class ManageAwarenessRoute extends _i51.PageRouteInfo<void> {
  const ManageAwarenessRoute({List<_i51.PageRouteInfo>? children})
    : super(ManageAwarenessRoute.name, initialChildren: children);

  static const String name = 'ManageAwarenessRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i27.ManageAwarenessScreen();
    },
  );
}

/// generated route for
/// [_i28.ManageCollectorsScreen]
class ManageCollectorsRoute extends _i51.PageRouteInfo<void> {
  const ManageCollectorsRoute({List<_i51.PageRouteInfo>? children})
    : super(ManageCollectorsRoute.name, initialChildren: children);

  static const String name = 'ManageCollectorsRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i28.ManageCollectorsScreen();
    },
  );
}

/// generated route for
/// [_i29.ManageRequestsScreen]
class ManageRequestsRoute extends _i51.PageRouteInfo<void> {
  const ManageRequestsRoute({List<_i51.PageRouteInfo>? children})
    : super(ManageRequestsRoute.name, initialChildren: children);

  static const String name = 'ManageRequestsRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i29.ManageRequestsScreen();
    },
  );
}

/// generated route for
/// [_i30.ManageRewardsScreen]
class ManageRewardsRoute extends _i51.PageRouteInfo<void> {
  const ManageRewardsRoute({List<_i51.PageRouteInfo>? children})
    : super(ManageRewardsRoute.name, initialChildren: children);

  static const String name = 'ManageRewardsRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i30.ManageRewardsScreen();
    },
  );
}

/// generated route for
/// [_i31.MarketplaceCategoryScreen]
class MarketplaceCategoryRoute
    extends _i51.PageRouteInfo<MarketplaceCategoryRouteArgs> {
  MarketplaceCategoryRoute({
    _i52.Key? key,
    required String category,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         MarketplaceCategoryRoute.name,
         args: MarketplaceCategoryRouteArgs(key: key, category: category),
         initialChildren: children,
       );

  static const String name = 'MarketplaceCategoryRoute';

  static _i51.PageInfo page = _i51.PageInfo(
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

  final _i52.Key? key;

  final String category;

  @override
  String toString() {
    return 'MarketplaceCategoryRouteArgs{key: $key, category: $category}';
  }
}

/// generated route for
/// [_i32.MarketplaceScreen]
class MarketplaceRoute extends _i51.PageRouteInfo<void> {
  const MarketplaceRoute({List<_i51.PageRouteInfo>? children})
    : super(MarketplaceRoute.name, initialChildren: children);

  static const String name = 'MarketplaceRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i32.MarketplaceScreen();
    },
  );
}

/// generated route for
/// [_i33.MyListingScreen]
class MyListingRoute extends _i51.PageRouteInfo<void> {
  const MyListingRoute({List<_i51.PageRouteInfo>? children})
    : super(MyListingRoute.name, initialChildren: children);

  static const String name = 'MyListingRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i33.MyListingScreen();
    },
  );
}

/// generated route for
/// [_i34.MyPickupScreen]
class MyPickupRoute extends _i51.PageRouteInfo<void> {
  const MyPickupRoute({List<_i51.PageRouteInfo>? children})
    : super(MyPickupRoute.name, initialChildren: children);

  static const String name = 'MyPickupRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i34.MyPickupScreen();
    },
  );
}

/// generated route for
/// [_i35.MyPurchasesScreen]
class MyPurchasesRoute extends _i51.PageRouteInfo<void> {
  const MyPurchasesRoute({List<_i51.PageRouteInfo>? children})
    : super(MyPurchasesRoute.name, initialChildren: children);

  static const String name = 'MyPurchasesRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i35.MyPurchasesScreen();
    },
  );
}

/// generated route for
/// [_i36.OnboardingScreen]
class OnboardingRoute extends _i51.PageRouteInfo<void> {
  const OnboardingRoute({List<_i51.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i36.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i37.PickupHistoryScreen]
class PickupHistoryRoute extends _i51.PageRouteInfo<void> {
  const PickupHistoryRoute({List<_i51.PageRouteInfo>? children})
    : super(PickupHistoryRoute.name, initialChildren: children);

  static const String name = 'PickupHistoryRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i37.PickupHistoryScreen();
    },
  );
}

/// generated route for
/// [_i38.PickupRequestDetailsScreen]
class PickupRequestDetailsRoute extends _i51.PageRouteInfo<void> {
  const PickupRequestDetailsRoute({List<_i51.PageRouteInfo>? children})
    : super(PickupRequestDetailsRoute.name, initialChildren: children);

  static const String name = 'PickupRequestDetailsRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i38.PickupRequestDetailsScreen();
    },
  );
}

/// generated route for
/// [_i39.PointsScreen]
class PointsRoute extends _i51.PageRouteInfo<void> {
  const PointsRoute({List<_i51.PageRouteInfo>? children})
    : super(PointsRoute.name, initialChildren: children);

  static const String name = 'PointsRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i39.PointsScreen();
    },
  );
}

/// generated route for
/// [_i40.ProfileScreen]
class ProfileRoute extends _i51.PageRouteInfo<void> {
  const ProfileRoute({List<_i51.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i40.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i41.RequestDetailsScreen]
class RequestDetailsRoute extends _i51.PageRouteInfo<RequestDetailsRouteArgs> {
  RequestDetailsRoute({
    _i52.Key? key,
    required String pickupRequestID,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         RequestDetailsRoute.name,
         args: RequestDetailsRouteArgs(
           key: key,
           pickupRequestID: pickupRequestID,
         ),
         initialChildren: children,
       );

  static const String name = 'RequestDetailsRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RequestDetailsRouteArgs>();
      return _i41.RequestDetailsScreen(
        key: args.key,
        pickupRequestID: args.pickupRequestID,
      );
    },
  );
}

class RequestDetailsRouteArgs {
  const RequestDetailsRouteArgs({this.key, required this.pickupRequestID});

  final _i52.Key? key;

  final String pickupRequestID;

  @override
  String toString() {
    return 'RequestDetailsRouteArgs{key: $key, pickupRequestID: $pickupRequestID}';
  }
}

/// generated route for
/// [_i42.RequestItemDetailsScreen]
class RequestItemDetailsRoute
    extends _i51.PageRouteInfo<RequestItemDetailsRouteArgs> {
  RequestItemDetailsRoute({
    _i52.Key? key,
    required bool isEdit,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         RequestItemDetailsRoute.name,
         args: RequestItemDetailsRouteArgs(key: key, isEdit: isEdit),
         initialChildren: children,
       );

  static const String name = 'RequestItemDetailsRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RequestItemDetailsRouteArgs>();
      return _i42.RequestItemDetailsScreen(key: args.key, isEdit: args.isEdit);
    },
  );
}

class RequestItemDetailsRouteArgs {
  const RequestItemDetailsRouteArgs({this.key, required this.isEdit});

  final _i52.Key? key;

  final bool isEdit;

  @override
  String toString() {
    return 'RequestItemDetailsRouteArgs{key: $key, isEdit: $isEdit}';
  }
}

/// generated route for
/// [_i43.RequestLocationTrackingScreen]
class RequestLocationTrackingRoute
    extends _i51.PageRouteInfo<RequestLocationTrackingRouteArgs> {
  RequestLocationTrackingRoute({
    _i52.Key? key,
    required String pickupRequestID,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         RequestLocationTrackingRoute.name,
         args: RequestLocationTrackingRouteArgs(
           key: key,
           pickupRequestID: pickupRequestID,
         ),
         initialChildren: children,
       );

  static const String name = 'RequestLocationTrackingRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RequestLocationTrackingRouteArgs>();
      return _i43.RequestLocationTrackingScreen(
        key: args.key,
        pickupRequestID: args.pickupRequestID,
      );
    },
  );
}

class RequestLocationTrackingRouteArgs {
  const RequestLocationTrackingRouteArgs({
    this.key,
    required this.pickupRequestID,
  });

  final _i52.Key? key;

  final String pickupRequestID;

  @override
  String toString() {
    return 'RequestLocationTrackingRouteArgs{key: $key, pickupRequestID: $pickupRequestID}';
  }
}

/// generated route for
/// [_i44.RequestScreen]
class RequestRoute extends _i51.PageRouteInfo<void> {
  const RequestRoute({List<_i51.PageRouteInfo>? children})
    : super(RequestRoute.name, initialChildren: children);

  static const String name = 'RequestRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i44.RequestScreen();
    },
  );
}

/// generated route for
/// [_i45.RequestSummaryScreen]
class RequestSummaryRoute extends _i51.PageRouteInfo<void> {
  const RequestSummaryRoute({List<_i51.PageRouteInfo>? children})
    : super(RequestSummaryRoute.name, initialChildren: children);

  static const String name = 'RequestSummaryRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i45.RequestSummaryScreen();
    },
  );
}

/// generated route for
/// [_i46.RewardScreen]
class RewardRoute extends _i51.PageRouteInfo<void> {
  const RewardRoute({List<_i51.PageRouteInfo>? children})
    : super(RewardRoute.name, initialChildren: children);

  static const String name = 'RewardRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i46.RewardScreen();
    },
  );
}

/// generated route for
/// [_i47.SchedulePickupScreen]
class SchedulePickupRoute extends _i51.PageRouteInfo<SchedulePickupRouteArgs> {
  SchedulePickupRoute({
    _i52.Key? key,
    required bool isEdit,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         SchedulePickupRoute.name,
         args: SchedulePickupRouteArgs(key: key, isEdit: isEdit),
         initialChildren: children,
       );

  static const String name = 'SchedulePickupRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SchedulePickupRouteArgs>();
      return _i47.SchedulePickupScreen(key: args.key, isEdit: args.isEdit);
    },
  );
}

class SchedulePickupRouteArgs {
  const SchedulePickupRouteArgs({this.key, required this.isEdit});

  final _i52.Key? key;

  final bool isEdit;

  @override
  String toString() {
    return 'SchedulePickupRouteArgs{key: $key, isEdit: $isEdit}';
  }
}

/// generated route for
/// [_i48.SelectLocationScreen]
class SelectLocationRoute extends _i51.PageRouteInfo<SelectLocationRouteArgs> {
  SelectLocationRoute({
    _i52.Key? key,
    required bool isEdit,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         SelectLocationRoute.name,
         args: SelectLocationRouteArgs(key: key, isEdit: isEdit),
         initialChildren: children,
       );

  static const String name = 'SelectLocationRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SelectLocationRouteArgs>();
      return _i48.SelectLocationScreen(key: args.key, isEdit: args.isEdit);
    },
  );
}

class SelectLocationRouteArgs {
  const SelectLocationRouteArgs({this.key, required this.isEdit});

  final _i52.Key? key;

  final bool isEdit;

  @override
  String toString() {
    return 'SelectLocationRouteArgs{key: $key, isEdit: $isEdit}';
  }
}

/// generated route for
/// [_i49.SignUpScreen]
class SignUpRoute extends _i51.PageRouteInfo<void> {
  const SignUpRoute({List<_i51.PageRouteInfo>? children})
    : super(SignUpRoute.name, initialChildren: children);

  static const String name = 'SignUpRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      return const _i49.SignUpScreen();
    },
  );
}

/// generated route for
/// [_i50.SuccessScreen]
class SuccessRoute extends _i51.PageRouteInfo<SuccessRouteArgs> {
  SuccessRoute({
    _i52.Key? key,
    required String title,
    required String message,
    required String buttonText,
    List<_i51.PageRouteInfo>? children,
  }) : super(
         SuccessRoute.name,
         args: SuccessRouteArgs(
           key: key,
           title: title,
           message: message,
           buttonText: buttonText,
         ),
         initialChildren: children,
       );

  static const String name = 'SuccessRoute';

  static _i51.PageInfo page = _i51.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SuccessRouteArgs>();
      return _i50.SuccessScreen(
        key: args.key,
        title: args.title,
        message: args.message,
        buttonText: args.buttonText,
      );
    },
  );
}

class SuccessRouteArgs {
  const SuccessRouteArgs({
    this.key,
    required this.title,
    required this.message,
    required this.buttonText,
  });

  final _i52.Key? key;

  final String title;

  final String message;

  final String buttonText;

  @override
  String toString() {
    return 'SuccessRouteArgs{key: $key, title: $title, message: $message, buttonText: $buttonText}';
  }
}
