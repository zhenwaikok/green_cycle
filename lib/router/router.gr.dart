// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:green_cycle_fyp/view/auth/collector_additional_signup_screen.dart'
    as _i1;
import 'package:green_cycle_fyp/view/auth/login_screen.dart' as _i4;
import 'package:green_cycle_fyp/view/auth/signup_screen.dart' as _i9;
import 'package:green_cycle_fyp/view/customer/home/home_screen.dart' as _i3;
import 'package:green_cycle_fyp/view/customer/marketplace/marketplace_screen.dart'
    as _i5;
import 'package:green_cycle_fyp/view/customer/profile/profile_screen.dart'
    as _i7;
import 'package:green_cycle_fyp/view/customer/request/request_screen.dart'
    as _i8;
import 'package:green_cycle_fyp/view/onboarding_screen.dart' as _i6;
import 'package:green_cycle_fyp/widget/custom_bottom_nav_bar.dart' as _i2;

abstract class $AppRouter extends _i10.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    CollectorAdditionalSignupRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.CollectorAdditionalSignupScreen(),
      );
    },
    CustomBottomNavBar.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.CustomBottomNavBar(),
      );
    },
    CustomerHomeRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.CustomerHomeScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LoginScreen(),
      );
    },
    MarketplaceRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.MarketplaceScreen(),
      );
    },
    OnboardingRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.OnboardingScreen(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.ProfileScreen(),
      );
    },
    RequestRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.RequestScreen(),
      );
    },
    SignUpRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.SignUpScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.CollectorAdditionalSignupScreen]
class CollectorAdditionalSignupRoute extends _i10.PageRouteInfo<void> {
  const CollectorAdditionalSignupRoute({List<_i10.PageRouteInfo>? children})
      : super(
          CollectorAdditionalSignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'CollectorAdditionalSignupRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i2.CustomBottomNavBar]
class CustomBottomNavBar extends _i10.PageRouteInfo<void> {
  const CustomBottomNavBar({List<_i10.PageRouteInfo>? children})
      : super(
          CustomBottomNavBar.name,
          initialChildren: children,
        );

  static const String name = 'CustomBottomNavBar';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i3.CustomerHomeScreen]
class CustomerHomeRoute extends _i10.PageRouteInfo<void> {
  const CustomerHomeRoute({List<_i10.PageRouteInfo>? children})
      : super(
          CustomerHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'CustomerHomeRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoginScreen]
class LoginRoute extends _i10.PageRouteInfo<void> {
  const LoginRoute({List<_i10.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i5.MarketplaceScreen]
class MarketplaceRoute extends _i10.PageRouteInfo<void> {
  const MarketplaceRoute({List<_i10.PageRouteInfo>? children})
      : super(
          MarketplaceRoute.name,
          initialChildren: children,
        );

  static const String name = 'MarketplaceRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i6.OnboardingScreen]
class OnboardingRoute extends _i10.PageRouteInfo<void> {
  const OnboardingRoute({List<_i10.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i7.ProfileScreen]
class ProfileRoute extends _i10.PageRouteInfo<void> {
  const ProfileRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i8.RequestScreen]
class RequestRoute extends _i10.PageRouteInfo<void> {
  const RequestRoute({List<_i10.PageRouteInfo>? children})
      : super(
          RequestRoute.name,
          initialChildren: children,
        );

  static const String name = 'RequestRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i9.SignUpScreen]
class SignUpRoute extends _i10.PageRouteInfo<void> {
  const SignUpRoute({List<_i10.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}
