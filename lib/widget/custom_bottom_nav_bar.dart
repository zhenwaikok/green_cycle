import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';

@RoutePage()
class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key, required this.userRole});

  final String userRole;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: getRoutes(),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: child,
          bottomNavigationBar: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                boxShadow: [getTabBarShadow()],
              ),
              child: BottomNavigationBar(
                backgroundColor: ColorManager.whiteColor,
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: ColorManager.blackColor.withValues(
                  alpha: 0.5,
                ),
                selectedItemColor: ColorManager.primary,
                selectedLabelStyle: _Styles.selectedItemLabelStyle,
                unselectedLabelStyle: _Styles.unselectedItemLabelStyle,
                showUnselectedLabels: true,
                currentIndex: tabsRouter.activeIndex,
                onTap: (index) =>
                    onItemTapped(index: index, tabsRouter: tabsRouter),
                items: getBottomNavBarItems(),
              ),
            ),
          ),
        );
      },
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CustomBottomNavBarState {
  void onItemTapped({required int index, required TabsRouter tabsRouter}) {
    tabsRouter.setActiveIndex(index);
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CustomBottomNavBarState {
  BoxShadow getTabBarShadow() {
    return BoxShadow(
      color: ColorManager.greyColor.withValues(alpha: 0.1),
      blurRadius: 6,
      offset: const Offset(0, -1),
    );
  }

  List<PageRouteInfo> getRoutes() {
    return [
      if (widget.userRole == 'Customer') ...[
        CustomerHomeRoute(),
        RequestRoute(),
        MarketplaceRoute(),
        ProfileRoute(),
      ] else if (widget.userRole == 'Admin') ...[
        AdminDashboardRoute(),
        ManageCollectorsRoute(),
        ManageRequestsRoute(),
        ManageAwarenessRoute(),
        AdminProfileRoute(),
      ] else if (widget.userRole == 'Collector') ...[
        CollectorHomeRoute(),
        AvailablePickupRequestRoute(),
        MyPickupRoute(),
        CollectorProfileRoute(),
      ],
    ];
  }

  List<BottomNavigationBarItem> getBottomNavBarItems() {
    return [
      if (widget.userRole == 'Customer') ...[
        getBottomNavBarIcon(icon: Icons.home, label: 'Home'),
        getBottomNavBarIcon(icon: Icons.local_shipping, label: 'Request'),
        getBottomNavBarIcon(icon: Icons.shopping_bag, label: 'Marketplace'),
        getBottomNavBarIcon(icon: Icons.person, label: 'Profile'),
      ] else if (widget.userRole == 'Admin') ...[
        getBottomNavBarIcon(icon: Icons.home, label: 'Home'),
        getBottomNavBarIcon(icon: Icons.people_rounded, label: 'Collectors'),
        getBottomNavBarIcon(icon: Icons.local_shipping, label: 'Request'),
        getBottomNavBarIcon(icon: Icons.campaign, label: 'Awareness'),
        getBottomNavBarIcon(icon: Icons.person, label: 'Profile'),
      ] else if (widget.userRole == 'Collector') ...[
        getBottomNavBarIcon(icon: Icons.home, label: 'Home'),
        getBottomNavBarIcon(icon: Icons.pending_actions, label: 'Available'),
        getBottomNavBarIcon(icon: Icons.work, label: 'My Pickup'),
        getBottomNavBarIcon(icon: Icons.person, label: 'Profile'),
      ],
    ];
  }

  BottomNavigationBarItem getBottomNavBarIcon({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon, size: _Styles.bottomNavBarIconSize),
      label: label,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const bottomNavBarIconSize = 28.0;

  static const selectedItemLabelStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeightManager.bold,
  );

  static const unselectedItemLabelStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeightManager.regular,
  );
}
