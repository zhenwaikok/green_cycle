// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i36;
import 'package:flutter/material.dart' as _i37;
import 'package:green_cycle_fyp/view/admin/dashboard/admin_dashboard_screen.dart'
    as _i2;
import 'package:green_cycle_fyp/view/admin/manage_awareness/add_edit_awareness_screen.dart'
    as _i1;
import 'package:green_cycle_fyp/view/admin/manage_awareness/manage_awareness_screen.dart'
    as _i18;
import 'package:green_cycle_fyp/view/admin/manage_collectors/manage_collectors_screen.dart'
    as _i19;
import 'package:green_cycle_fyp/view/admin/manage_requests/manage_requests_screen.dart'
    as _i20;
import 'package:green_cycle_fyp/view/admin/profile/admin_profile_screen.dart'
    as _i3;
import 'package:green_cycle_fyp/view/auth/collector_additional_signup_screen.dart'
    as _i9;
import 'package:green_cycle_fyp/view/auth/login_screen.dart' as _i17;
import 'package:green_cycle_fyp/view/auth/signup_screen.dart' as _i35;
import 'package:green_cycle_fyp/view/common/awareness_details_screen.dart'
    as _i4;
import 'package:green_cycle_fyp/view/common/change_password_screen.dart' as _i7;
import 'package:green_cycle_fyp/view/common/edit_profile_screen.dart' as _i15;
import 'package:green_cycle_fyp/view/customer/awareness/awareness_screen.dart'
    as _i5;
import 'package:green_cycle_fyp/view/customer/cart/cart_screen.dart' as _i6;
import 'package:green_cycle_fyp/view/customer/checkout/checkout_screen.dart'
    as _i8;
import 'package:green_cycle_fyp/view/customer/completed_request/completed_request_screen.dart'
    as _i10;
import 'package:green_cycle_fyp/view/customer/create_listing/create_listing_screen.dart'
    as _i11;
import 'package:green_cycle_fyp/view/customer/edit_listing/edit_listing_screen.dart'
    as _i14;
import 'package:green_cycle_fyp/view/customer/home/home_screen.dart' as _i13;
import 'package:green_cycle_fyp/view/customer/item_details/item_details_screen.dart'
    as _i16;
import 'package:green_cycle_fyp/view/customer/marketplace/marketplace_screen.dart'
    as _i22;
import 'package:green_cycle_fyp/view/customer/marketplace_category/marketplace_category_screen.dart'
    as _i21;
import 'package:green_cycle_fyp/view/customer/my_listing/my_listing_screen.dart'
    as _i23;
import 'package:green_cycle_fyp/view/customer/my_purchases/my_purchases_screen.dart'
    as _i24;
import 'package:green_cycle_fyp/view/customer/points/points_screen.dart'
    as _i26;
import 'package:green_cycle_fyp/view/customer/profile/profile_screen.dart'
    as _i27;
import 'package:green_cycle_fyp/view/customer/request/request_screen.dart'
    as _i30;
import 'package:green_cycle_fyp/view/customer/request_details/request_details_screen.dart'
    as _i28;
import 'package:green_cycle_fyp/view/customer/request_for_pickup/request_item_details_screen.dart'
    as _i29;
import 'package:green_cycle_fyp/view/customer/request_for_pickup/request_summary_screen.dart'
    as _i31;
import 'package:green_cycle_fyp/view/customer/request_for_pickup/schedule_pickup_screen.dart'
    as _i33;
import 'package:green_cycle_fyp/view/customer/request_for_pickup/select_location_screen.dart'
    as _i34;
import 'package:green_cycle_fyp/view/customer/reward/reward_screen.dart'
    as _i32;
import 'package:green_cycle_fyp/view/onboarding_screen.dart' as _i25;
import 'package:green_cycle_fyp/widget/custom_bottom_nav_bar.dart' as _i12;

abstract class $AppRouter extends _i36.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i36.PageFactory> pagesMap = {
    AddOrEditAwarenessRoute.name: (routeData) {
      final args = routeData.argsAs<AddOrEditAwarenessRouteArgs>();
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddOrEditAwarenessScreen(
          key: args.key,
          isEdit: args.isEdit,
        ),
      );
    },
    AdminDashboardRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AdminDashboardScreen(),
      );
    },
    AdminProfileRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AdminProfileScreen(),
      );
    },
    AwarenessDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<AwarenessDetailsRouteArgs>();
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.AwarenessDetailsScreen(
          key: args.key,
          userRole: args.userRole,
        ),
      );
    },
    AwarenessRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.AwarenessScreen(),
      );
    },
    CartRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.CartScreen(),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.ChangePasswordScreen(),
      );
    },
    CheckoutRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.CheckoutScreen(),
      );
    },
    CollectorAdditionalSignupRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.CollectorAdditionalSignupScreen(),
      );
    },
    CompletedRequestRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.CompletedRequestScreen(),
      );
    },
    CreateListingRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.CreateListingScreen(),
      );
    },
    CustomBottomNavBar.name: (routeData) {
      final args = routeData.argsAs<CustomBottomNavBarArgs>();
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.CustomBottomNavBar(
          key: args.key,
          userRole: args.userRole,
        ),
      );
    },
    CustomerHomeRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.CustomerHomeScreen(),
      );
    },
    EditListingRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.EditListingScreen(),
      );
    },
    EditProfileRoute.name: (routeData) {
      final args = routeData.argsAs<EditProfileRouteArgs>();
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.EditProfileScreen(
          key: args.key,
          selectedRole: args.selectedRole,
        ),
      );
    },
    ItemDetailsRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.ItemDetailsScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.LoginScreen(),
      );
    },
    ManageAwarenessRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.ManageAwarenessScreen(),
      );
    },
    ManageCollectorsRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.ManageCollectorsScreen(),
      );
    },
    ManageRequestsRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.ManageRequestsScreen(),
      );
    },
    MarketplaceCategoryRoute.name: (routeData) {
      final args = routeData.argsAs<MarketplaceCategoryRouteArgs>();
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i21.MarketplaceCategoryScreen(
          key: args.key,
          category: args.category,
        ),
      );
    },
    MarketplaceRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.MarketplaceScreen(),
      );
    },
    MyListingRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i23.MyListingScreen(),
      );
    },
    MyPurchasesRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i24.MyPurchasesScreen(),
      );
    },
    OnboardingRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i25.OnboardingScreen(),
      );
    },
    PointsRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i26.PointsScreen(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i27.ProfileScreen(),
      );
    },
    RequestDetailsRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i28.RequestDetailsScreen(),
      );
    },
    RequestItemDetailsRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i29.RequestItemDetailsScreen(),
      );
    },
    RequestRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i30.RequestScreen(),
      );
    },
    RequestSummaryRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i31.RequestSummaryScreen(),
      );
    },
    RewardRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i32.RewardScreen(),
      );
    },
    SchedulePickupRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i33.SchedulePickupScreen(),
      );
    },
    SelectLocationRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i34.SelectLocationScreen(),
      );
    },
    SignUpRoute.name: (routeData) {
      return _i36.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i35.SignUpScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddOrEditAwarenessScreen]
class AddOrEditAwarenessRoute
    extends _i36.PageRouteInfo<AddOrEditAwarenessRouteArgs> {
  AddOrEditAwarenessRoute({
    _i37.Key? key,
    required bool isEdit,
    List<_i36.PageRouteInfo>? children,
  }) : super(
          AddOrEditAwarenessRoute.name,
          args: AddOrEditAwarenessRouteArgs(
            key: key,
            isEdit: isEdit,
          ),
          initialChildren: children,
        );

  static const String name = 'AddOrEditAwarenessRoute';

  static const _i36.PageInfo<AddOrEditAwarenessRouteArgs> page =
      _i36.PageInfo<AddOrEditAwarenessRouteArgs>(name);
}

class AddOrEditAwarenessRouteArgs {
  const AddOrEditAwarenessRouteArgs({
    this.key,
    required this.isEdit,
  });

  final _i37.Key? key;

  final bool isEdit;

  @override
  String toString() {
    return 'AddOrEditAwarenessRouteArgs{key: $key, isEdit: $isEdit}';
  }
}

/// generated route for
/// [_i2.AdminDashboardScreen]
class AdminDashboardRoute extends _i36.PageRouteInfo<void> {
  const AdminDashboardRoute({List<_i36.PageRouteInfo>? children})
      : super(
          AdminDashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminDashboardRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AdminProfileScreen]
class AdminProfileRoute extends _i36.PageRouteInfo<void> {
  const AdminProfileRoute({List<_i36.PageRouteInfo>? children})
      : super(
          AdminProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminProfileRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i4.AwarenessDetailsScreen]
class AwarenessDetailsRoute
    extends _i36.PageRouteInfo<AwarenessDetailsRouteArgs> {
  AwarenessDetailsRoute({
    _i37.Key? key,
    required String userRole,
    List<_i36.PageRouteInfo>? children,
  }) : super(
          AwarenessDetailsRoute.name,
          args: AwarenessDetailsRouteArgs(
            key: key,
            userRole: userRole,
          ),
          initialChildren: children,
        );

  static const String name = 'AwarenessDetailsRoute';

  static const _i36.PageInfo<AwarenessDetailsRouteArgs> page =
      _i36.PageInfo<AwarenessDetailsRouteArgs>(name);
}

class AwarenessDetailsRouteArgs {
  const AwarenessDetailsRouteArgs({
    this.key,
    required this.userRole,
  });

  final _i37.Key? key;

  final String userRole;

  @override
  String toString() {
    return 'AwarenessDetailsRouteArgs{key: $key, userRole: $userRole}';
  }
}

/// generated route for
/// [_i5.AwarenessScreen]
class AwarenessRoute extends _i36.PageRouteInfo<void> {
  const AwarenessRoute({List<_i36.PageRouteInfo>? children})
      : super(
          AwarenessRoute.name,
          initialChildren: children,
        );

  static const String name = 'AwarenessRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i6.CartScreen]
class CartRoute extends _i36.PageRouteInfo<void> {
  const CartRoute({List<_i36.PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i7.ChangePasswordScreen]
class ChangePasswordRoute extends _i36.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i36.PageRouteInfo>? children})
      : super(
          ChangePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i8.CheckoutScreen]
class CheckoutRoute extends _i36.PageRouteInfo<void> {
  const CheckoutRoute({List<_i36.PageRouteInfo>? children})
      : super(
          CheckoutRoute.name,
          initialChildren: children,
        );

  static const String name = 'CheckoutRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i9.CollectorAdditionalSignupScreen]
class CollectorAdditionalSignupRoute extends _i36.PageRouteInfo<void> {
  const CollectorAdditionalSignupRoute({List<_i36.PageRouteInfo>? children})
      : super(
          CollectorAdditionalSignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'CollectorAdditionalSignupRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i10.CompletedRequestScreen]
class CompletedRequestRoute extends _i36.PageRouteInfo<void> {
  const CompletedRequestRoute({List<_i36.PageRouteInfo>? children})
      : super(
          CompletedRequestRoute.name,
          initialChildren: children,
        );

  static const String name = 'CompletedRequestRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i11.CreateListingScreen]
class CreateListingRoute extends _i36.PageRouteInfo<void> {
  const CreateListingRoute({List<_i36.PageRouteInfo>? children})
      : super(
          CreateListingRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateListingRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i12.CustomBottomNavBar]
class CustomBottomNavBar extends _i36.PageRouteInfo<CustomBottomNavBarArgs> {
  CustomBottomNavBar({
    _i37.Key? key,
    required String userRole,
    List<_i36.PageRouteInfo>? children,
  }) : super(
          CustomBottomNavBar.name,
          args: CustomBottomNavBarArgs(
            key: key,
            userRole: userRole,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomBottomNavBar';

  static const _i36.PageInfo<CustomBottomNavBarArgs> page =
      _i36.PageInfo<CustomBottomNavBarArgs>(name);
}

class CustomBottomNavBarArgs {
  const CustomBottomNavBarArgs({
    this.key,
    required this.userRole,
  });

  final _i37.Key? key;

  final String userRole;

  @override
  String toString() {
    return 'CustomBottomNavBarArgs{key: $key, userRole: $userRole}';
  }
}

/// generated route for
/// [_i13.CustomerHomeScreen]
class CustomerHomeRoute extends _i36.PageRouteInfo<void> {
  const CustomerHomeRoute({List<_i36.PageRouteInfo>? children})
      : super(
          CustomerHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'CustomerHomeRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i14.EditListingScreen]
class EditListingRoute extends _i36.PageRouteInfo<void> {
  const EditListingRoute({List<_i36.PageRouteInfo>? children})
      : super(
          EditListingRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditListingRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i15.EditProfileScreen]
class EditProfileRoute extends _i36.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    _i37.Key? key,
    required String selectedRole,
    List<_i36.PageRouteInfo>? children,
  }) : super(
          EditProfileRoute.name,
          args: EditProfileRouteArgs(
            key: key,
            selectedRole: selectedRole,
          ),
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const _i36.PageInfo<EditProfileRouteArgs> page =
      _i36.PageInfo<EditProfileRouteArgs>(name);
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({
    this.key,
    required this.selectedRole,
  });

  final _i37.Key? key;

  final String selectedRole;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, selectedRole: $selectedRole}';
  }
}

/// generated route for
/// [_i16.ItemDetailsScreen]
class ItemDetailsRoute extends _i36.PageRouteInfo<void> {
  const ItemDetailsRoute({List<_i36.PageRouteInfo>? children})
      : super(
          ItemDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ItemDetailsRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i17.LoginScreen]
class LoginRoute extends _i36.PageRouteInfo<void> {
  const LoginRoute({List<_i36.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i18.ManageAwarenessScreen]
class ManageAwarenessRoute extends _i36.PageRouteInfo<void> {
  const ManageAwarenessRoute({List<_i36.PageRouteInfo>? children})
      : super(
          ManageAwarenessRoute.name,
          initialChildren: children,
        );

  static const String name = 'ManageAwarenessRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i19.ManageCollectorsScreen]
class ManageCollectorsRoute extends _i36.PageRouteInfo<void> {
  const ManageCollectorsRoute({List<_i36.PageRouteInfo>? children})
      : super(
          ManageCollectorsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ManageCollectorsRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i20.ManageRequestsScreen]
class ManageRequestsRoute extends _i36.PageRouteInfo<void> {
  const ManageRequestsRoute({List<_i36.PageRouteInfo>? children})
      : super(
          ManageRequestsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ManageRequestsRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i21.MarketplaceCategoryScreen]
class MarketplaceCategoryRoute
    extends _i36.PageRouteInfo<MarketplaceCategoryRouteArgs> {
  MarketplaceCategoryRoute({
    _i37.Key? key,
    required String category,
    List<_i36.PageRouteInfo>? children,
  }) : super(
          MarketplaceCategoryRoute.name,
          args: MarketplaceCategoryRouteArgs(
            key: key,
            category: category,
          ),
          initialChildren: children,
        );

  static const String name = 'MarketplaceCategoryRoute';

  static const _i36.PageInfo<MarketplaceCategoryRouteArgs> page =
      _i36.PageInfo<MarketplaceCategoryRouteArgs>(name);
}

class MarketplaceCategoryRouteArgs {
  const MarketplaceCategoryRouteArgs({
    this.key,
    required this.category,
  });

  final _i37.Key? key;

  final String category;

  @override
  String toString() {
    return 'MarketplaceCategoryRouteArgs{key: $key, category: $category}';
  }
}

/// generated route for
/// [_i22.MarketplaceScreen]
class MarketplaceRoute extends _i36.PageRouteInfo<void> {
  const MarketplaceRoute({List<_i36.PageRouteInfo>? children})
      : super(
          MarketplaceRoute.name,
          initialChildren: children,
        );

  static const String name = 'MarketplaceRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i23.MyListingScreen]
class MyListingRoute extends _i36.PageRouteInfo<void> {
  const MyListingRoute({List<_i36.PageRouteInfo>? children})
      : super(
          MyListingRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyListingRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i24.MyPurchasesScreen]
class MyPurchasesRoute extends _i36.PageRouteInfo<void> {
  const MyPurchasesRoute({List<_i36.PageRouteInfo>? children})
      : super(
          MyPurchasesRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyPurchasesRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i25.OnboardingScreen]
class OnboardingRoute extends _i36.PageRouteInfo<void> {
  const OnboardingRoute({List<_i36.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i26.PointsScreen]
class PointsRoute extends _i36.PageRouteInfo<void> {
  const PointsRoute({List<_i36.PageRouteInfo>? children})
      : super(
          PointsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PointsRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i27.ProfileScreen]
class ProfileRoute extends _i36.PageRouteInfo<void> {
  const ProfileRoute({List<_i36.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i28.RequestDetailsScreen]
class RequestDetailsRoute extends _i36.PageRouteInfo<void> {
  const RequestDetailsRoute({List<_i36.PageRouteInfo>? children})
      : super(
          RequestDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'RequestDetailsRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i29.RequestItemDetailsScreen]
class RequestItemDetailsRoute extends _i36.PageRouteInfo<void> {
  const RequestItemDetailsRoute({List<_i36.PageRouteInfo>? children})
      : super(
          RequestItemDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'RequestItemDetailsRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i30.RequestScreen]
class RequestRoute extends _i36.PageRouteInfo<void> {
  const RequestRoute({List<_i36.PageRouteInfo>? children})
      : super(
          RequestRoute.name,
          initialChildren: children,
        );

  static const String name = 'RequestRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i31.RequestSummaryScreen]
class RequestSummaryRoute extends _i36.PageRouteInfo<void> {
  const RequestSummaryRoute({List<_i36.PageRouteInfo>? children})
      : super(
          RequestSummaryRoute.name,
          initialChildren: children,
        );

  static const String name = 'RequestSummaryRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i32.RewardScreen]
class RewardRoute extends _i36.PageRouteInfo<void> {
  const RewardRoute({List<_i36.PageRouteInfo>? children})
      : super(
          RewardRoute.name,
          initialChildren: children,
        );

  static const String name = 'RewardRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i33.SchedulePickupScreen]
class SchedulePickupRoute extends _i36.PageRouteInfo<void> {
  const SchedulePickupRoute({List<_i36.PageRouteInfo>? children})
      : super(
          SchedulePickupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SchedulePickupRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i34.SelectLocationScreen]
class SelectLocationRoute extends _i36.PageRouteInfo<void> {
  const SelectLocationRoute({List<_i36.PageRouteInfo>? children})
      : super(
          SelectLocationRoute.name,
          initialChildren: children,
        );

  static const String name = 'SelectLocationRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}

/// generated route for
/// [_i35.SignUpScreen]
class SignUpRoute extends _i36.PageRouteInfo<void> {
  const SignUpRoute({List<_i36.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const _i36.PageInfo<void> page = _i36.PageInfo<void>(name);
}
