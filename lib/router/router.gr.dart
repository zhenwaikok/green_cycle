// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i22;
import 'package:flutter/material.dart' as _i23;
import 'package:green_cycle_fyp/view/auth/collector_additional_signup_screen.dart'
    as _i5;
import 'package:green_cycle_fyp/view/auth/login_screen.dart' as _i11;
import 'package:green_cycle_fyp/view/auth/signup_screen.dart' as _i21;
import 'package:green_cycle_fyp/view/common/change_password_screen.dart' as _i4;
import 'package:green_cycle_fyp/view/common/edit_profile_screen.dart' as _i10;
import 'package:green_cycle_fyp/view/customer/awareness/awareness_details_screen.dart'
    as _i1;
import 'package:green_cycle_fyp/view/customer/awareness/awareness_screen.dart'
    as _i2;
import 'package:green_cycle_fyp/view/customer/cart/cart_screen.dart' as _i3;
import 'package:green_cycle_fyp/view/customer/completed_request/completed_request_screen.dart'
    as _i6;
import 'package:green_cycle_fyp/view/customer/create_listing/create_listing_screen.dart'
    as _i7;
import 'package:green_cycle_fyp/view/customer/home/home_screen.dart' as _i9;
import 'package:green_cycle_fyp/view/customer/marketplace/marketplace_screen.dart'
    as _i13;
import 'package:green_cycle_fyp/view/customer/marketplace_category/marketplace_category_screen.dart'
    as _i12;
import 'package:green_cycle_fyp/view/customer/my_listing/my_listing_screen.dart'
    as _i14;
import 'package:green_cycle_fyp/view/customer/my_purchases/my_purchases_screen.dart'
    as _i15;
import 'package:green_cycle_fyp/view/customer/points/points_screen.dart'
    as _i17;
import 'package:green_cycle_fyp/view/customer/profile/profile_screen.dart'
    as _i18;
import 'package:green_cycle_fyp/view/customer/request/request_screen.dart'
    as _i19;
import 'package:green_cycle_fyp/view/customer/reward/reward_screen.dart'
    as _i20;
import 'package:green_cycle_fyp/view/onboarding_screen.dart' as _i16;
import 'package:green_cycle_fyp/widget/custom_bottom_nav_bar.dart' as _i8;

abstract class $AppRouter extends _i22.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i22.PageFactory> pagesMap = {
    AwarenessDetailsRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AwarenessDetailsScreen(),
      );
    },
    AwarenessRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AwarenessScreen(),
      );
    },
    CartRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.CartScreen(),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.ChangePasswordScreen(),
      );
    },
    CollectorAdditionalSignupRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.CollectorAdditionalSignupScreen(),
      );
    },
    CompletedRequestRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.CompletedRequestScreen(),
      );
    },
    CreateListingRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.CreateListingScreen(),
      );
    },
    CustomBottomNavBar.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.CustomBottomNavBar(),
      );
    },
    CustomerHomeRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.CustomerHomeScreen(),
      );
    },
    EditProfileRoute.name: (routeData) {
      final args = routeData.argsAs<EditProfileRouteArgs>();
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.EditProfileScreen(
          key: args.key,
          selectedRole: args.selectedRole,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.LoginScreen(),
      );
    },
    MarketplaceCategoryRoute.name: (routeData) {
      final args = routeData.argsAs<MarketplaceCategoryRouteArgs>();
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.MarketplaceCategoryScreen(
          key: args.key,
          category: args.category,
        ),
      );
    },
    MarketplaceRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.MarketplaceScreen(),
      );
    },
    MyListingRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.MyListingScreen(),
      );
    },
    MyPurchasesRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.MyPurchasesScreen(),
      );
    },
    OnboardingRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.OnboardingScreen(),
      );
    },
    PointsRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.PointsScreen(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.ProfileScreen(),
      );
    },
    RequestRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.RequestScreen(),
      );
    },
    RewardRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.RewardScreen(),
      );
    },
    SignUpRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.SignUpScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AwarenessDetailsScreen]
class AwarenessDetailsRoute extends _i22.PageRouteInfo<void> {
  const AwarenessDetailsRoute({List<_i22.PageRouteInfo>? children})
      : super(
          AwarenessDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AwarenessDetailsRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AwarenessScreen]
class AwarenessRoute extends _i22.PageRouteInfo<void> {
  const AwarenessRoute({List<_i22.PageRouteInfo>? children})
      : super(
          AwarenessRoute.name,
          initialChildren: children,
        );

  static const String name = 'AwarenessRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i3.CartScreen]
class CartRoute extends _i22.PageRouteInfo<void> {
  const CartRoute({List<_i22.PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i4.ChangePasswordScreen]
class ChangePasswordRoute extends _i22.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i22.PageRouteInfo>? children})
      : super(
          ChangePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i5.CollectorAdditionalSignupScreen]
class CollectorAdditionalSignupRoute extends _i22.PageRouteInfo<void> {
  const CollectorAdditionalSignupRoute({List<_i22.PageRouteInfo>? children})
      : super(
          CollectorAdditionalSignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'CollectorAdditionalSignupRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i6.CompletedRequestScreen]
class CompletedRequestRoute extends _i22.PageRouteInfo<void> {
  const CompletedRequestRoute({List<_i22.PageRouteInfo>? children})
      : super(
          CompletedRequestRoute.name,
          initialChildren: children,
        );

  static const String name = 'CompletedRequestRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i7.CreateListingScreen]
class CreateListingRoute extends _i22.PageRouteInfo<void> {
  const CreateListingRoute({List<_i22.PageRouteInfo>? children})
      : super(
          CreateListingRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateListingRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i8.CustomBottomNavBar]
class CustomBottomNavBar extends _i22.PageRouteInfo<void> {
  const CustomBottomNavBar({List<_i22.PageRouteInfo>? children})
      : super(
          CustomBottomNavBar.name,
          initialChildren: children,
        );

  static const String name = 'CustomBottomNavBar';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i9.CustomerHomeScreen]
class CustomerHomeRoute extends _i22.PageRouteInfo<void> {
  const CustomerHomeRoute({List<_i22.PageRouteInfo>? children})
      : super(
          CustomerHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'CustomerHomeRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i10.EditProfileScreen]
class EditProfileRoute extends _i22.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    _i23.Key? key,
    required String selectedRole,
    List<_i22.PageRouteInfo>? children,
  }) : super(
          EditProfileRoute.name,
          args: EditProfileRouteArgs(
            key: key,
            selectedRole: selectedRole,
          ),
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const _i22.PageInfo<EditProfileRouteArgs> page =
      _i22.PageInfo<EditProfileRouteArgs>(name);
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({
    this.key,
    required this.selectedRole,
  });

  final _i23.Key? key;

  final String selectedRole;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, selectedRole: $selectedRole}';
  }
}

/// generated route for
/// [_i11.LoginScreen]
class LoginRoute extends _i22.PageRouteInfo<void> {
  const LoginRoute({List<_i22.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i12.MarketplaceCategoryScreen]
class MarketplaceCategoryRoute
    extends _i22.PageRouteInfo<MarketplaceCategoryRouteArgs> {
  MarketplaceCategoryRoute({
    _i23.Key? key,
    required String category,
    List<_i22.PageRouteInfo>? children,
  }) : super(
          MarketplaceCategoryRoute.name,
          args: MarketplaceCategoryRouteArgs(
            key: key,
            category: category,
          ),
          initialChildren: children,
        );

  static const String name = 'MarketplaceCategoryRoute';

  static const _i22.PageInfo<MarketplaceCategoryRouteArgs> page =
      _i22.PageInfo<MarketplaceCategoryRouteArgs>(name);
}

class MarketplaceCategoryRouteArgs {
  const MarketplaceCategoryRouteArgs({
    this.key,
    required this.category,
  });

  final _i23.Key? key;

  final String category;

  @override
  String toString() {
    return 'MarketplaceCategoryRouteArgs{key: $key, category: $category}';
  }
}

/// generated route for
/// [_i13.MarketplaceScreen]
class MarketplaceRoute extends _i22.PageRouteInfo<void> {
  const MarketplaceRoute({List<_i22.PageRouteInfo>? children})
      : super(
          MarketplaceRoute.name,
          initialChildren: children,
        );

  static const String name = 'MarketplaceRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i14.MyListingScreen]
class MyListingRoute extends _i22.PageRouteInfo<void> {
  const MyListingRoute({List<_i22.PageRouteInfo>? children})
      : super(
          MyListingRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyListingRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i15.MyPurchasesScreen]
class MyPurchasesRoute extends _i22.PageRouteInfo<void> {
  const MyPurchasesRoute({List<_i22.PageRouteInfo>? children})
      : super(
          MyPurchasesRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyPurchasesRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i16.OnboardingScreen]
class OnboardingRoute extends _i22.PageRouteInfo<void> {
  const OnboardingRoute({List<_i22.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i17.PointsScreen]
class PointsRoute extends _i22.PageRouteInfo<void> {
  const PointsRoute({List<_i22.PageRouteInfo>? children})
      : super(
          PointsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PointsRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i18.ProfileScreen]
class ProfileRoute extends _i22.PageRouteInfo<void> {
  const ProfileRoute({List<_i22.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i19.RequestScreen]
class RequestRoute extends _i22.PageRouteInfo<void> {
  const RequestRoute({List<_i22.PageRouteInfo>? children})
      : super(
          RequestRoute.name,
          initialChildren: children,
        );

  static const String name = 'RequestRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i20.RewardScreen]
class RewardRoute extends _i22.PageRouteInfo<void> {
  const RewardRoute({List<_i22.PageRouteInfo>? children})
      : super(
          RewardRoute.name,
          initialChildren: children,
        );

  static const String name = 'RewardRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i21.SignUpScreen]
class SignUpRoute extends _i22.PageRouteInfo<void> {
  const SignUpRoute({List<_i22.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}
