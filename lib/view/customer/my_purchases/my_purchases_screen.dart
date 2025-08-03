import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/view/customer/my_purchases/my_purchases_tab.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_tab_bar.dart';

@RoutePage()
class MyPurchasesScreen extends StatelessWidget {
  const MyPurchasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _MyPurchasesScreen();
  }
}

class _MyPurchasesScreen extends BaseStatefulPage {
  @override
  State<_MyPurchasesScreen> createState() => _MyPurchasesScreenState();
}

class _MyPurchasesScreenState extends BaseStatefulState<_MyPurchasesScreen> {
  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'My Purchases',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  Widget body() {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          getTabBar(),
          SizedBox(height: 15),
          Expanded(
            child: TabBarView(
              children: [
                getPurchasesList(purchaseStatus: ''),
                getPurchasesList(purchaseStatus: 'Shipped'),
                getPurchasesList(purchaseStatus: 'Completed'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _MyPurchasesScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _MyPurchasesScreenState {
  Widget getTabBar() {
    return CustomTabBar(
      tabs: [Text('All'), Text('In Progress'), Text('Completed')],
    );
  }

  Widget getPurchasesList({required String purchaseStatus}) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return MyPurchasesTab(purchaseStatus: purchaseStatus);
      },
    );
  }
}
