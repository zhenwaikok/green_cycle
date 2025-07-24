// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i48;
import 'package:flutter/material.dart' as _i49;
import 'package:green_cycle_fyp/view/admin/collector_details/collector_details_screen.dart'
    as _i12;
import 'package:green_cycle_fyp/view/admin/dashboard/admin_dashboard_screen.dart'
    as _i3;
import 'package:green_cycle_fyp/view/admin/manage_awareness/add_edit_awareness_screen.dart'
    as _i1;
import 'package:green_cycle_fyp/view/admin/manage_awareness/manage_awareness_screen.dart'
    as _i26;
import 'package:green_cycle_fyp/view/admin/manage_collectors/manage_collectors_screen.dart'
    as _i27;
import 'package:green_cycle_fyp/view/admin/manage_requests/manage_requests_screen.dart'
    as _i28;
import 'package:green_cycle_fyp/view/admin/manage_reward/add_edit_reward_screen.dart'
    as _i2;
import 'package:green_cycle_fyp/view/admin/manage_reward/manage_rewards_screen.dart'
    as _i29;
import 'package:green_cycle_fyp/view/admin/pickup_request_details/pickup_request_details_screen.dart'
    as _i37;
import 'package:green_cycle_fyp/view/admin/profile/admin_profile_screen.dart'
    as _i4;
import 'package:green_cycle_fyp/view/auth/collector_additional_signup_screen.dart'
    as _i11;
import 'package:green_cycle_fyp/view/auth/login_screen.dart' as _i25;
import 'package:green_cycle_fyp/view/auth/signup_screen.dart' as _i47;
import 'package:green_cycle_fyp/view/collector/available_pickup_request/available_pickup_request_screen.dart'
    as _i5;
import 'package:green_cycle_fyp/view/collector/collector_home/collector_home_screen.dart'
    as _i13;
import 'package:green_cycle_fyp/view/collector/complete_pickup/complete_pickup_screen.dart'
    as _i16;
import 'package:green_cycle_fyp/view/collector/my_pickup/my_pickup_screen.dart'
    as _i33;
import 'package:green_cycle_fyp/view/collector/pickup_history/pickup_history_screen.dart'
    as _i36;
import 'package:green_cycle_fyp/view/collector/pickup_request_details/collector_pickup_request_details_screen.dart'
    as _i14;
import 'package:green_cycle_fyp/view/collector/profile/collector_profile_screen.dart'
    as _i15;
import 'package:green_cycle_fyp/view/common/awareness_details_screen.dart'
    as _i6;
import 'package:green_cycle_fyp/view/common/change_password_screen.dart' as _i9;
import 'package:green_cycle_fyp/view/common/edit_profile_screen.dart' as _i22;
import 'package:green_cycle_fyp/view/common/loading_screen.dart' as _i24;
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
    as _i23;
import 'package:green_cycle_fyp/view/customer/marketplace/marketplace_screen.dart'
    as _i31;
import 'package:green_cycle_fyp/view/customer/marketplace_category/marketplace_category_screen.dart'
    as _i30;
import 'package:green_cycle_fyp/view/customer/my_listing/my_listing_screen.dart'
    as _i32;
import 'package:green_cycle_fyp/view/customer/my_purchases/my_purchases_screen.dart'
    as _i34;
import 'package:green_cycle_fyp/view/customer/points/points_screen.dart'
    as _i38;
import 'package:green_cycle_fyp/view/customer/profile/profile_screen.dart'
    as _i39;
import 'package:green_cycle_fyp/view/customer/request/request_screen.dart'
    as _i42;
import 'package:green_cycle_fyp/view/customer/request_details/request_details_screen.dart'
    as _i40;
import 'package:green_cycle_fyp/view/customer/request_for_pickup/request_item_details_screen.dart'
    as _i41;
import 'package:green_cycle_fyp/view/customer/request_for_pickup/request_summary_screen.dart'
    as _i43;
import 'package:green_cycle_fyp/view/customer/request_for_pickup/schedule_pickup_screen.dart'
    as _i45;
import 'package:green_cycle_fyp/view/customer/request_for_pickup/select_location_screen.dart'
    as _i46;
import 'package:green_cycle_fyp/view/customer/reward/reward_screen.dart'
    as _i44;
import 'package:green_cycle_fyp/view/onboarding_screen.dart' as _i35;
import 'package:green_cycle_fyp/widget/custom_bottom_nav_bar.dart' as _i19;

abstract class $AppRouter extends _i48.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i48.PageFactory> pagesMap = {
    AddOrEditAwarenessRoute.name: (routeData) {
      final args = routeData.argsAs<AddOrEditAwarenessRouteArgs>();
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddOrEditAwarenessScreen(
          key: args.key,
          isEdit: args.isEdit,
        ),
      );
    },
    AddOrEditRewardRoute.name: (routeData) {
      final args = routeData.argsAs<AddOrEditRewardRouteArgs>();
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.AddOrEditRewardScreen(
          key: args.key,
          isEdit: args.isEdit,
        ),
      );
    },
    AdminDashboardRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AdminDashboardScreen(),
      );
    },
    AdminProfileRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.AdminProfileScreen(),
      );
    },
    AvailablePickupRequestRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.AvailablePickupRequestScreen(),
      );
    },
    AwarenessDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<AwarenessDetailsRouteArgs>();
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.AwarenessDetailsScreen(
          key: args.key,
          userRole: args.userRole,
          awarenessId: args.awarenessId,
        ),
      );
    },
    AwarenessRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.AwarenessScreen(),
      );
    },
    CartRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.CartScreen(),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.ChangePasswordScreen(),
      );
    },
    CheckoutRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.CheckoutScreen(),
      );
    },
    CollectorAdditionalSignupRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.CollectorAdditionalSignupScreen(),
      );
    },
    CollectorDetailsRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.CollectorDetailsScreen(),
      );
    },
    CollectorHomeRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.CollectorHomeScreen(),
      );
    },
    CollectorPickupRequestDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<CollectorPickupRequestDetailsRouteArgs>(
          orElse: () => const CollectorPickupRequestDetailsRouteArgs());
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.CollectorPickupRequestDetailsScreen(
          key: args.key,
          requestStatus: args.requestStatus,
        ),
      );
    },
    CollectorProfileRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.CollectorProfileScreen(),
      );
    },
    CompletePickupRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.CompletePickupScreen(),
      );
    },
    CompletedRequestRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.CompletedRequestScreen(),
      );
    },
    CreateListingRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.CreateListingScreen(),
      );
    },
    CustomBottomNavBar.name: (routeData) {
      final args = routeData.argsAs<CustomBottomNavBarArgs>();
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.CustomBottomNavBar(
          key: args.key,
          userRole: args.userRole,
        ),
      );
    },
    CustomerHomeRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.CustomerHomeScreen(),
      );
    },
    EditListingRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.EditListingScreen(),
      );
    },
    EditProfileRoute.name: (routeData) {
      final args = routeData.argsAs<EditProfileRouteArgs>();
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i22.EditProfileScreen(
          key: args.key,
          selectedRole: args.selectedRole,
        ),
      );
    },
    ItemDetailsRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i23.ItemDetailsScreen(),
      );
    },
    LoadingRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i24.LoadingScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i25.LoginScreen(),
      );
    },
    ManageAwarenessRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i26.ManageAwarenessScreen(),
      );
    },
    ManageCollectorsRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i27.ManageCollectorsScreen(),
      );
    },
    ManageRequestsRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i28.ManageRequestsScreen(),
      );
    },
    ManageRewardsRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i29.ManageRewardsScreen(),
      );
    },
    MarketplaceCategoryRoute.name: (routeData) {
      final args = routeData.argsAs<MarketplaceCategoryRouteArgs>();
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.MarketplaceCategoryScreen(
          key: args.key,
          category: args.category,
        ),
      );
    },
    MarketplaceRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i31.MarketplaceScreen(),
      );
    },
    MyListingRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i32.MyListingScreen(),
      );
    },
    MyPickupRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i33.MyPickupScreen(),
      );
    },
    MyPurchasesRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i34.MyPurchasesScreen(),
      );
    },
    OnboardingRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i35.OnboardingScreen(),
      );
    },
    PickupHistoryRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i36.PickupHistoryScreen(),
      );
    },
    PickupRequestDetailsRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i37.PickupRequestDetailsScreen(),
      );
    },
    PointsRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i38.PointsScreen(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i39.ProfileScreen(),
      );
    },
    RequestDetailsRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i40.RequestDetailsScreen(),
      );
    },
    RequestItemDetailsRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i41.RequestItemDetailsScreen(),
      );
    },
    RequestRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i42.RequestScreen(),
      );
    },
    RequestSummaryRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i43.RequestSummaryScreen(),
      );
    },
    RewardRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i44.RewardScreen(),
      );
    },
    SchedulePickupRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i45.SchedulePickupScreen(),
      );
    },
    SelectLocationRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i46.SelectLocationScreen(),
      );
    },
    SignUpRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i47.SignUpScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddOrEditAwarenessScreen]
class AddOrEditAwarenessRoute
    extends _i48.PageRouteInfo<AddOrEditAwarenessRouteArgs> {
  AddOrEditAwarenessRoute({
    _i49.Key? key,
    required bool isEdit,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          AddOrEditAwarenessRoute.name,
          args: AddOrEditAwarenessRouteArgs(
            key: key,
            isEdit: isEdit,
          ),
          initialChildren: children,
        );

  static const String name = 'AddOrEditAwarenessRoute';

  static const _i48.PageInfo<AddOrEditAwarenessRouteArgs> page =
      _i48.PageInfo<AddOrEditAwarenessRouteArgs>(name);
}

class AddOrEditAwarenessRouteArgs {
  const AddOrEditAwarenessRouteArgs({
    this.key,
    required this.isEdit,
  });

  final _i49.Key? key;

  final bool isEdit;

  @override
  String toString() {
    return 'AddOrEditAwarenessRouteArgs{key: $key, isEdit: $isEdit}';
  }
}

/// generated route for
/// [_i2.AddOrEditRewardScreen]
class AddOrEditRewardRoute
    extends _i48.PageRouteInfo<AddOrEditRewardRouteArgs> {
  AddOrEditRewardRoute({
    _i49.Key? key,
    required bool isEdit,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          AddOrEditRewardRoute.name,
          args: AddOrEditRewardRouteArgs(
            key: key,
            isEdit: isEdit,
          ),
          initialChildren: children,
        );

  static const String name = 'AddOrEditRewardRoute';

  static const _i48.PageInfo<AddOrEditRewardRouteArgs> page =
      _i48.PageInfo<AddOrEditRewardRouteArgs>(name);
}

class AddOrEditRewardRouteArgs {
  const AddOrEditRewardRouteArgs({
    this.key,
    required this.isEdit,
  });

  final _i49.Key? key;

  final bool isEdit;

  @override
  String toString() {
    return 'AddOrEditRewardRouteArgs{key: $key, isEdit: $isEdit}';
  }
}

/// generated route for
/// [_i3.AdminDashboardScreen]
class AdminDashboardRoute extends _i48.PageRouteInfo<void> {
  const AdminDashboardRoute({List<_i48.PageRouteInfo>? children})
      : super(
          AdminDashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminDashboardRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i4.AdminProfileScreen]
class AdminProfileRoute extends _i48.PageRouteInfo<void> {
  const AdminProfileRoute({List<_i48.PageRouteInfo>? children})
      : super(
          AdminProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminProfileRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i5.AvailablePickupRequestScreen]
class AvailablePickupRequestRoute extends _i48.PageRouteInfo<void> {
  const AvailablePickupRequestRoute({List<_i48.PageRouteInfo>? children})
      : super(
          AvailablePickupRequestRoute.name,
          initialChildren: children,
        );

  static const String name = 'AvailablePickupRequestRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i6.AwarenessDetailsScreen]
class AwarenessDetailsRoute
    extends _i48.PageRouteInfo<AwarenessDetailsRouteArgs> {
  AwarenessDetailsRoute({
    _i49.Key? key,
    required String userRole,
    required int awarenessId,
    List<_i48.PageRouteInfo>? children,
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

  static const _i48.PageInfo<AwarenessDetailsRouteArgs> page =
      _i48.PageInfo<AwarenessDetailsRouteArgs>(name);
}

class AwarenessDetailsRouteArgs {
  const AwarenessDetailsRouteArgs({
    this.key,
    required this.userRole,
    required this.awarenessId,
  });

  final _i49.Key? key;

  final String userRole;

  final int awarenessId;

  @override
  String toString() {
    return 'AwarenessDetailsRouteArgs{key: $key, userRole: $userRole, awarenessId: $awarenessId}';
  }
}

/// generated route for
/// [_i7.AwarenessScreen]
class AwarenessRoute extends _i48.PageRouteInfo<void> {
  const AwarenessRoute({List<_i48.PageRouteInfo>? children})
      : super(
          AwarenessRoute.name,
          initialChildren: children,
        );

  static const String name = 'AwarenessRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i8.CartScreen]
class CartRoute extends _i48.PageRouteInfo<void> {
  const CartRoute({List<_i48.PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i9.ChangePasswordScreen]
class ChangePasswordRoute extends _i48.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i48.PageRouteInfo>? children})
      : super(
          ChangePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i10.CheckoutScreen]
class CheckoutRoute extends _i48.PageRouteInfo<void> {
  const CheckoutRoute({List<_i48.PageRouteInfo>? children})
      : super(
          CheckoutRoute.name,
          initialChildren: children,
        );

  static const String name = 'CheckoutRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i11.CollectorAdditionalSignupScreen]
class CollectorAdditionalSignupRoute extends _i48.PageRouteInfo<void> {
  const CollectorAdditionalSignupRoute({List<_i48.PageRouteInfo>? children})
      : super(
          CollectorAdditionalSignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'CollectorAdditionalSignupRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i12.CollectorDetailsScreen]
class CollectorDetailsRoute extends _i48.PageRouteInfo<void> {
  const CollectorDetailsRoute({List<_i48.PageRouteInfo>? children})
      : super(
          CollectorDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'CollectorDetailsRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i13.CollectorHomeScreen]
class CollectorHomeRoute extends _i48.PageRouteInfo<void> {
  const CollectorHomeRoute({List<_i48.PageRouteInfo>? children})
      : super(
          CollectorHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'CollectorHomeRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i14.CollectorPickupRequestDetailsScreen]
class CollectorPickupRequestDetailsRoute
    extends _i48.PageRouteInfo<CollectorPickupRequestDetailsRouteArgs> {
  CollectorPickupRequestDetailsRoute({
    _i49.Key? key,
    String? requestStatus,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          CollectorPickupRequestDetailsRoute.name,
          args: CollectorPickupRequestDetailsRouteArgs(
            key: key,
            requestStatus: requestStatus,
          ),
          initialChildren: children,
        );

  static const String name = 'CollectorPickupRequestDetailsRoute';

  static const _i48.PageInfo<CollectorPickupRequestDetailsRouteArgs> page =
      _i48.PageInfo<CollectorPickupRequestDetailsRouteArgs>(name);
}

class CollectorPickupRequestDetailsRouteArgs {
  const CollectorPickupRequestDetailsRouteArgs({
    this.key,
    this.requestStatus,
  });

  final _i49.Key? key;

  final String? requestStatus;

  @override
  String toString() {
    return 'CollectorPickupRequestDetailsRouteArgs{key: $key, requestStatus: $requestStatus}';
  }
}

/// generated route for
/// [_i15.CollectorProfileScreen]
class CollectorProfileRoute extends _i48.PageRouteInfo<void> {
  const CollectorProfileRoute({List<_i48.PageRouteInfo>? children})
      : super(
          CollectorProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'CollectorProfileRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i16.CompletePickupScreen]
class CompletePickupRoute extends _i48.PageRouteInfo<void> {
  const CompletePickupRoute({List<_i48.PageRouteInfo>? children})
      : super(
          CompletePickupRoute.name,
          initialChildren: children,
        );

  static const String name = 'CompletePickupRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i17.CompletedRequestScreen]
class CompletedRequestRoute extends _i48.PageRouteInfo<void> {
  const CompletedRequestRoute({List<_i48.PageRouteInfo>? children})
      : super(
          CompletedRequestRoute.name,
          initialChildren: children,
        );

  static const String name = 'CompletedRequestRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i18.CreateListingScreen]
class CreateListingRoute extends _i48.PageRouteInfo<void> {
  const CreateListingRoute({List<_i48.PageRouteInfo>? children})
      : super(
          CreateListingRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateListingRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i19.CustomBottomNavBar]
class CustomBottomNavBar extends _i48.PageRouteInfo<CustomBottomNavBarArgs> {
  CustomBottomNavBar({
    _i49.Key? key,
    required String userRole,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          CustomBottomNavBar.name,
          args: CustomBottomNavBarArgs(
            key: key,
            userRole: userRole,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomBottomNavBar';

  static const _i48.PageInfo<CustomBottomNavBarArgs> page =
      _i48.PageInfo<CustomBottomNavBarArgs>(name);
}

class CustomBottomNavBarArgs {
  const CustomBottomNavBarArgs({
    this.key,
    required this.userRole,
  });

  final _i49.Key? key;

  final String userRole;

  @override
  String toString() {
    return 'CustomBottomNavBarArgs{key: $key, userRole: $userRole}';
  }
}

/// generated route for
/// [_i20.CustomerHomeScreen]
class CustomerHomeRoute extends _i48.PageRouteInfo<void> {
  const CustomerHomeRoute({List<_i48.PageRouteInfo>? children})
      : super(
          CustomerHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'CustomerHomeRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i21.EditListingScreen]
class EditListingRoute extends _i48.PageRouteInfo<void> {
  const EditListingRoute({List<_i48.PageRouteInfo>? children})
      : super(
          EditListingRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditListingRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i22.EditProfileScreen]
class EditProfileRoute extends _i48.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    _i49.Key? key,
    required String selectedRole,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          EditProfileRoute.name,
          args: EditProfileRouteArgs(
            key: key,
            selectedRole: selectedRole,
          ),
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const _i48.PageInfo<EditProfileRouteArgs> page =
      _i48.PageInfo<EditProfileRouteArgs>(name);
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({
    this.key,
    required this.selectedRole,
  });

  final _i49.Key? key;

  final String selectedRole;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, selectedRole: $selectedRole}';
  }
}

/// generated route for
/// [_i23.ItemDetailsScreen]
class ItemDetailsRoute extends _i48.PageRouteInfo<void> {
  const ItemDetailsRoute({List<_i48.PageRouteInfo>? children})
      : super(
          ItemDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ItemDetailsRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i24.LoadingScreen]
class LoadingRoute extends _i48.PageRouteInfo<void> {
  const LoadingRoute({List<_i48.PageRouteInfo>? children})
      : super(
          LoadingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoadingRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i25.LoginScreen]
class LoginRoute extends _i48.PageRouteInfo<void> {
  const LoginRoute({List<_i48.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i26.ManageAwarenessScreen]
class ManageAwarenessRoute extends _i48.PageRouteInfo<void> {
  const ManageAwarenessRoute({List<_i48.PageRouteInfo>? children})
      : super(
          ManageAwarenessRoute.name,
          initialChildren: children,
        );

  static const String name = 'ManageAwarenessRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i27.ManageCollectorsScreen]
class ManageCollectorsRoute extends _i48.PageRouteInfo<void> {
  const ManageCollectorsRoute({List<_i48.PageRouteInfo>? children})
      : super(
          ManageCollectorsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ManageCollectorsRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i28.ManageRequestsScreen]
class ManageRequestsRoute extends _i48.PageRouteInfo<void> {
  const ManageRequestsRoute({List<_i48.PageRouteInfo>? children})
      : super(
          ManageRequestsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ManageRequestsRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i29.ManageRewardsScreen]
class ManageRewardsRoute extends _i48.PageRouteInfo<void> {
  const ManageRewardsRoute({List<_i48.PageRouteInfo>? children})
      : super(
          ManageRewardsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ManageRewardsRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i30.MarketplaceCategoryScreen]
class MarketplaceCategoryRoute
    extends _i48.PageRouteInfo<MarketplaceCategoryRouteArgs> {
  MarketplaceCategoryRoute({
    _i49.Key? key,
    required String category,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          MarketplaceCategoryRoute.name,
          args: MarketplaceCategoryRouteArgs(
            key: key,
            category: category,
          ),
          initialChildren: children,
        );

  static const String name = 'MarketplaceCategoryRoute';

  static const _i48.PageInfo<MarketplaceCategoryRouteArgs> page =
      _i48.PageInfo<MarketplaceCategoryRouteArgs>(name);
}

class MarketplaceCategoryRouteArgs {
  const MarketplaceCategoryRouteArgs({
    this.key,
    required this.category,
  });

  final _i49.Key? key;

  final String category;

  @override
  String toString() {
    return 'MarketplaceCategoryRouteArgs{key: $key, category: $category}';
  }
}

/// generated route for
/// [_i31.MarketplaceScreen]
class MarketplaceRoute extends _i48.PageRouteInfo<void> {
  const MarketplaceRoute({List<_i48.PageRouteInfo>? children})
      : super(
          MarketplaceRoute.name,
          initialChildren: children,
        );

  static const String name = 'MarketplaceRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i32.MyListingScreen]
class MyListingRoute extends _i48.PageRouteInfo<void> {
  const MyListingRoute({List<_i48.PageRouteInfo>? children})
      : super(
          MyListingRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyListingRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i33.MyPickupScreen]
class MyPickupRoute extends _i48.PageRouteInfo<void> {
  const MyPickupRoute({List<_i48.PageRouteInfo>? children})
      : super(
          MyPickupRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyPickupRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i34.MyPurchasesScreen]
class MyPurchasesRoute extends _i48.PageRouteInfo<void> {
  const MyPurchasesRoute({List<_i48.PageRouteInfo>? children})
      : super(
          MyPurchasesRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyPurchasesRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i35.OnboardingScreen]
class OnboardingRoute extends _i48.PageRouteInfo<void> {
  const OnboardingRoute({List<_i48.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i36.PickupHistoryScreen]
class PickupHistoryRoute extends _i48.PageRouteInfo<void> {
  const PickupHistoryRoute({List<_i48.PageRouteInfo>? children})
      : super(
          PickupHistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'PickupHistoryRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i37.PickupRequestDetailsScreen]
class PickupRequestDetailsRoute extends _i48.PageRouteInfo<void> {
  const PickupRequestDetailsRoute({List<_i48.PageRouteInfo>? children})
      : super(
          PickupRequestDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PickupRequestDetailsRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i38.PointsScreen]
class PointsRoute extends _i48.PageRouteInfo<void> {
  const PointsRoute({List<_i48.PageRouteInfo>? children})
      : super(
          PointsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PointsRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i39.ProfileScreen]
class ProfileRoute extends _i48.PageRouteInfo<void> {
  const ProfileRoute({List<_i48.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i40.RequestDetailsScreen]
class RequestDetailsRoute extends _i48.PageRouteInfo<void> {
  const RequestDetailsRoute({List<_i48.PageRouteInfo>? children})
      : super(
          RequestDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'RequestDetailsRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i41.RequestItemDetailsScreen]
class RequestItemDetailsRoute extends _i48.PageRouteInfo<void> {
  const RequestItemDetailsRoute({List<_i48.PageRouteInfo>? children})
      : super(
          RequestItemDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'RequestItemDetailsRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i42.RequestScreen]
class RequestRoute extends _i48.PageRouteInfo<void> {
  const RequestRoute({List<_i48.PageRouteInfo>? children})
      : super(
          RequestRoute.name,
          initialChildren: children,
        );

  static const String name = 'RequestRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i43.RequestSummaryScreen]
class RequestSummaryRoute extends _i48.PageRouteInfo<void> {
  const RequestSummaryRoute({List<_i48.PageRouteInfo>? children})
      : super(
          RequestSummaryRoute.name,
          initialChildren: children,
        );

  static const String name = 'RequestSummaryRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i44.RewardScreen]
class RewardRoute extends _i48.PageRouteInfo<void> {
  const RewardRoute({List<_i48.PageRouteInfo>? children})
      : super(
          RewardRoute.name,
          initialChildren: children,
        );

  static const String name = 'RewardRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i45.SchedulePickupScreen]
class SchedulePickupRoute extends _i48.PageRouteInfo<void> {
  const SchedulePickupRoute({List<_i48.PageRouteInfo>? children})
      : super(
          SchedulePickupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SchedulePickupRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i46.SelectLocationScreen]
class SelectLocationRoute extends _i48.PageRouteInfo<void> {
  const SelectLocationRoute({List<_i48.PageRouteInfo>? children})
      : super(
          SelectLocationRoute.name,
          initialChildren: children,
        );

  static const String name = 'SelectLocationRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i47.SignUpScreen]
class SignUpRoute extends _i48.PageRouteInfo<void> {
  const SignUpRoute({List<_i48.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}
