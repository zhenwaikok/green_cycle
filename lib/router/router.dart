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
    AutoRoute(
      page: CustomBottomNavBar.page,
      children: [
        AutoRoute(page: CustomerHomeRoute.page),
        AutoRoute(page: RequestRoute.page),
        AutoRoute(page: MarketplaceRoute.page),
        AutoRoute(page: ProfileRoute.page),
        AutoRoute(page: AdminDashboardRoute.page),
        AutoRoute(page: ManageCollectorsRoute.page),
        AutoRoute(page: ManageRequestsRoute.page),
        AutoRoute(page: ManageAwarenessRoute.page),
        AutoRoute(page: AdminProfileRoute.page),
      ],
    ),
    AutoRoute(page: AwarenessRoute.page),
    AutoRoute(page: AwarenessDetailsRoute.page),
    AutoRoute(page: ChangePasswordRoute.page),
    AutoRoute(page: EditProfileRoute.page),
    AutoRoute(page: RewardRoute.page),
    AutoRoute(page: PointsRoute.page),
    AutoRoute(page: CompletedRequestRoute.page),
    AutoRoute(page: MyPurchasesRoute.page),
    AutoRoute(page: MyListingRoute.page),
    AutoRoute(page: MarketplaceCategoryRoute.page),
    AutoRoute(page: CreateListingRoute.page),
    AutoRoute(page: CartRoute.page),
    AutoRoute(page: ItemDetailsRoute.page),
    AutoRoute(page: CheckoutRoute.page),
    AutoRoute(page: RequestDetailsRoute.page),
    AutoRoute(page: SelectLocationRoute.page),
    AutoRoute(page: SchedulePickupRoute.page),
    AutoRoute(page: RequestItemDetailsRoute.page),
    AutoRoute(page: RequestSummaryRoute.page),
    AutoRoute(page: EditListingRoute.page),
    AutoRoute(page: AddOrEditAwarenessRoute.page),
    AutoRoute(page: CollectorDetailsRoute.page),
  ];
}
