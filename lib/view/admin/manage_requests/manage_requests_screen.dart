import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/view/admin/manage_requests/manage_request_tab.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_tab_bar.dart';
import 'package:green_cycle_fyp/widget/search_bar.dart';

@RoutePage()
class ManageRequestsScreen extends StatefulWidget {
  const ManageRequestsScreen({super.key});

  @override
  State<ManageRequestsScreen> createState() => _ManageRequestsScreenState();
}

class _ManageRequestsScreenState extends State<ManageRequestsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Pickup Request',
          isBackButtonVisible: false,
        ),
        body: SafeArea(
          child: Padding(
            padding: _Styles.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                getTotalRequestCard(),
                SizedBox(height: 60),
                getSearchBar(),
                SizedBox(height: 20),
                getTabBar(),
                SizedBox(height: 10),
                Expanded(
                  child: TabBarView(
                    children: [
                      getRequestList(status: 'Pending'),
                      getRequestList(status: 'Pending'),
                      getRequestList(status: 'Ongoing'),
                      getRequestList(status: 'Completed'),
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
extension _Actions on _ManageRequestsScreenState {
  void onRequestCardPressed() {
    context.router.push(PickupRequestDetailsRoute());
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ManageRequestsScreenState {
  Widget getRequestList({required String status}) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ManageRequestTab(status: status, onTap: onRequestCardPressed);
      },
    );
  }

  Widget getTabBar() {
    return CustomTabBar(
      tabs: [Text('All'), Text('Pending'), Text('Ongoing'), Text('Completed')],
    );
  }

  Widget getTotalRequestCard() {
    return CustomCard(
      padding: _Styles.customCardPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total Request', style: _Styles.blackTextStyle),
          Text('144', style: _Styles.primaryTextStyle),
        ],
      ),
    );
  }

  Widget getSearchBar() {
    return CustomSearchBar(hintText: 'Search request here');
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 30,
  );

  static const customCardPadding = EdgeInsets.all(10);

  static const blackTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const primaryTextStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );
}
