// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:flutter/material.dart' as _i17;
import 'package:green_cycle_fyp/view/auth/collector_additional_signup_screen.dart'
    as _i4;
import 'package:green_cycle_fyp/view/auth/login_screen.dart' as _i8;
import 'package:green_cycle_fyp/view/auth/signup_screen.dart' as _i15;
import 'package:green_cycle_fyp/view/common/change_password_screen.dart' as _i3;
import 'package:green_cycle_fyp/view/common/edit_profile_screen.dart' as _i7;
import 'package:green_cycle_fyp/view/customer/awareness/awareness_details_screen.dart'
    as _i1;
import 'package:green_cycle_fyp/view/customer/awareness/awareness_screen.dart'
    as _i2;
import 'package:green_cycle_fyp/view/customer/home/home_screen.dart' as _i6;
import 'package:green_cycle_fyp/view/customer/marketplace/marketplace_screen.dart'
    as _i9;
import 'package:green_cycle_fyp/view/customer/points/points_screen.dart'
    as _i11;
import 'package:green_cycle_fyp/view/customer/profile/profile_screen.dart'
    as _i12;
import 'package:green_cycle_fyp/view/customer/request/request_screen.dart'
    as _i13;
import 'package:green_cycle_fyp/view/customer/reward/reward_screen.dart'
    as _i14;
import 'package:green_cycle_fyp/view/onboarding_screen.dart' as _i10;
import 'package:green_cycle_fyp/widget/custom_bottom_nav_bar.dart' as _i5;

abstract class $AppRouter extends _i16.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i16.PageFactory> pagesMap = {
    AwarenessDetailsRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AwarenessDetailsScreen(),
      );
    },
    AwarenessRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AwarenessScreen(),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.ChangePasswordScreen(),
      );
    },
    CollectorAdditionalSignupRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.CollectorAdditionalSignupScreen(),
      );
    },
    CustomBottomNavBar.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.CustomBottomNavBar(),
      );
    },
    CustomerHomeRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.CustomerHomeScreen(),
      );
    },
    EditProfileRoute.name: (routeData) {
      final args = routeData.argsAs<EditProfileRouteArgs>();
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.EditProfileScreen(
          key: args.key,
          selectedRole: args.selectedRole,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.LoginScreen(),
      );
    },
    MarketplaceRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.MarketplaceScreen(),
      );
    },
    OnboardingRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.OnboardingScreen(),
      );
    },
    PointsRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.PointsScreen(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.ProfileScreen(),
      );
    },
    RequestRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.RequestScreen(),
      );
    },
    RewardRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.RewardScreen(),
      );
    },
    SignUpRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.SignUpScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AwarenessDetailsScreen]
class AwarenessDetailsRoute extends _i16.PageRouteInfo<void> {
  const AwarenessDetailsRoute({List<_i16.PageRouteInfo>? children})
      : super(
          AwarenessDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AwarenessDetailsRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AwarenessScreen]
class AwarenessRoute extends _i16.PageRouteInfo<void> {
  const AwarenessRoute({List<_i16.PageRouteInfo>? children})
      : super(
          AwarenessRoute.name,
          initialChildren: children,
        );

  static const String name = 'AwarenessRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ChangePasswordScreen]
class ChangePasswordRoute extends _i16.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i16.PageRouteInfo>? children})
      : super(
          ChangePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i4.CollectorAdditionalSignupScreen]
class CollectorAdditionalSignupRoute extends _i16.PageRouteInfo<void> {
  const CollectorAdditionalSignupRoute({List<_i16.PageRouteInfo>? children})
      : super(
          CollectorAdditionalSignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'CollectorAdditionalSignupRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i5.CustomBottomNavBar]
class CustomBottomNavBar extends _i16.PageRouteInfo<void> {
  const CustomBottomNavBar({List<_i16.PageRouteInfo>? children})
      : super(
          CustomBottomNavBar.name,
          initialChildren: children,
        );

  static const String name = 'CustomBottomNavBar';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i6.CustomerHomeScreen]
class CustomerHomeRoute extends _i16.PageRouteInfo<void> {
  const CustomerHomeRoute({List<_i16.PageRouteInfo>? children})
      : super(
          CustomerHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'CustomerHomeRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i7.EditProfileScreen]
class EditProfileRoute extends _i16.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    _i17.Key? key,
    required String selectedRole,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          EditProfileRoute.name,
          args: EditProfileRouteArgs(
            key: key,
            selectedRole: selectedRole,
          ),
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const _i16.PageInfo<EditProfileRouteArgs> page =
      _i16.PageInfo<EditProfileRouteArgs>(name);
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({
    this.key,
    required this.selectedRole,
  });

  final _i17.Key? key;

  final String selectedRole;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, selectedRole: $selectedRole}';
  }
}

/// generated route for
/// [_i8.LoginScreen]
class LoginRoute extends _i16.PageRouteInfo<void> {
  const LoginRoute({List<_i16.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i9.MarketplaceScreen]
class MarketplaceRoute extends _i16.PageRouteInfo<void> {
  const MarketplaceRoute({List<_i16.PageRouteInfo>? children})
      : super(
          MarketplaceRoute.name,
          initialChildren: children,
        );

  static const String name = 'MarketplaceRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i10.OnboardingScreen]
class OnboardingRoute extends _i16.PageRouteInfo<void> {
  const OnboardingRoute({List<_i16.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i11.PointsScreen]
class PointsRoute extends _i16.PageRouteInfo<void> {
  const PointsRoute({List<_i16.PageRouteInfo>? children})
      : super(
          PointsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PointsRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i12.ProfileScreen]
class ProfileRoute extends _i16.PageRouteInfo<void> {
  const ProfileRoute({List<_i16.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i13.RequestScreen]
class RequestRoute extends _i16.PageRouteInfo<void> {
  const RequestRoute({List<_i16.PageRouteInfo>? children})
      : super(
          RequestRoute.name,
          initialChildren: children,
        );

  static const String name = 'RequestRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i14.RewardScreen]
class RewardRoute extends _i16.PageRouteInfo<void> {
  const RewardRoute({List<_i16.PageRouteInfo>? children})
      : super(
          RewardRoute.name,
          initialChildren: children,
        );

  static const String name = 'RewardRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i15.SignUpScreen]
class SignUpRoute extends _i16.PageRouteInfo<void> {
  const SignUpRoute({List<_i16.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}
