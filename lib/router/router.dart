import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: OnboardingRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: CollectorAdditionalSignupRoute.page),
    AutoRoute(page: SignUpRoute.page),
  ];
}
