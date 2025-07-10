import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/view/customer/my_purchases/my_purchases_tab.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_tab_bar.dart';

@RoutePage()
class MyPurchasesScreen extends StatefulWidget {
  const MyPurchasesScreen({super.key});

  @override
  State<MyPurchasesScreen> createState() => _MyPurchasesScreenState();
}

class _MyPurchasesScreenState extends State<MyPurchasesScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'My Purchases',
          isBackButtonVisible: true,
          onPressed: onBackButtonPressed,
        ),
        body: SafeArea(
          child: Padding(
            padding: _Styles.screenPadding,
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
          ),
        ),
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

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const tabLabelTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.regular,
  );

  static const tabBarLabelPadding = EdgeInsets.symmetric(vertical: 10);
}
