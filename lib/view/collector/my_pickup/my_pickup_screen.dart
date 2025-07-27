import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/view/collector/my_pickup/my_pickup_tab.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_tab_bar.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';

@RoutePage()
class MyPickupScreen extends StatefulWidget {
  const MyPickupScreen({super.key});

  @override
  State<MyPickupScreen> createState() => _MyPickupScreenState();
}

class _MyPickupScreenState extends State<MyPickupScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(title: 'My Pickup', isBackButtonVisible: false),
        body: SafeArea(
          child: Padding(
            padding: _Styles.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                getTabBar(),
                SizedBox(height: 10),
                Expanded(
                  child: TabBarView(
                    children: [
                      getPickupList(
                        status: 'On The Way',
                        statusBarColor: ColorManager.orangeColor,
                        buttonText: 'Arrived',
                        onPressed: () {},
                      ),
                      getPickupList(
                        status: 'Accepted',
                        buttonText: 'On My Way',
                        onPressed: () {},
                      ),
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
extension _Actions on _MyPickupScreenState {
  void onRequestCardPressed() {
    context.router.push(
      CollectorPickupRequestDetailsRoute(requestStatus: 'Arrived'),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _MyPickupScreenState {
  Widget getTabBar() {
    return CustomTabBar(tabs: [Text('Ongoing'), Text('Upcoming')]);
  }

  Widget getPickupList({
    required String status,
    Color? statusBarColor,
    required String buttonText,
    required void Function() onPressed,
  }) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return TouchableOpacity(
          onPressed: onRequestCardPressed,
          child: MyPickupTab(
            statusBarColor: statusBarColor,
            status: status,
            buttonText: buttonText,
            onPressed: onPressed,
          ),
        );
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
}
