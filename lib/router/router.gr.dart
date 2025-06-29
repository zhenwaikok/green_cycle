// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:green_cycle_fyp/view/auth/collector_additional_signup_screen.dart'
    as _i1;
import 'package:green_cycle_fyp/view/auth/login_screen.dart' as _i2;
import 'package:green_cycle_fyp/view/auth/signup_screen.dart' as _i4;
import 'package:green_cycle_fyp/view/onboarding_screen.dart' as _i3;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    CollectorAdditionalSignupRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.CollectorAdditionalSignupScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LoginScreen(),
      );
    },
    OnboardingRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.OnboardingScreen(),
      );
    },
    SignUpRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SignUpScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.CollectorAdditionalSignupScreen]
class CollectorAdditionalSignupRoute extends _i5.PageRouteInfo<void> {
  const CollectorAdditionalSignupRoute({List<_i5.PageRouteInfo>? children})
      : super(
          CollectorAdditionalSignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'CollectorAdditionalSignupRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i5.PageRouteInfo<void> {
  const LoginRoute({List<_i5.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.OnboardingScreen]
class OnboardingRoute extends _i5.PageRouteInfo<void> {
  const OnboardingRoute({List<_i5.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SignUpScreen]
class SignUpRoute extends _i5.PageRouteInfo<void> {
  const SignUpRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
