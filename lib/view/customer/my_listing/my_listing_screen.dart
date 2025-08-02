import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/view/customer/my_listing/my_listing_tab.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/bottom_sheet_action.dart';
import 'package:green_cycle_fyp/widget/custom_sort_by.dart';
import 'package:green_cycle_fyp/widget/custom_tab_bar.dart';

@RoutePage()
class MyListingScreen extends StatelessWidget {
  const MyListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _MyListingScreen();
  }
}

class _MyListingScreen extends BaseStatefulPage {
  @override
  State<_MyListingScreen> createState() => _MyListingScreenState();
}

class _MyListingScreenState extends BaseStatefulState<_MyListingScreen> {
  final List<String> sortByItems = [
    'All',
    'Ascending Name',
    'Descending Name',
    'Price: Low-High',
    'Price: High-Low',
  ];

  String? selectedSort;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    selectedSort = sortByItems.first;
    super.initState();
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'My Listing',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  Widget body() {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          getSortBy(),
          SizedBox(height: 20),
          getTabBar(),
          SizedBox(height: 15),
          Expanded(
            child: TabBarView(
              children: [
                getMyListingList(listingStatus: ''),
                getMyListingList(listingStatus: 'Active'),
                getMyListingList(listingStatus: 'Sold'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _MyListingScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  void onSortByChanged(String? value) {
    _setState(() {
      selectedSort = value;
    });
  }

  void onListingLongPressed() async {
    showModalBottomSheet(
      backgroundColor: ColorManager.whiteColor,
      context: context,
      builder: (context) {
        return getListingBottomSheet();
      },
    );
  }

  void onRemovePressed() async {
    WidgetUtil.showAlertDialog(
      context,
      title: 'Delete Confirmation',
      content: 'Are you sure you want to delete this item from your listing?',
      actions: [
        getAlertDialogTextButton(onPressed: () {}, text: 'No'),
        getAlertDialogTextButton(onPressed: () {}, text: 'Yes'),
      ],
    );
  }

  void onEditPressed() {
    context.router.push(EditListingRoute());
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _MyListingScreenState {
  Widget getSortBy() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sort By', style: _Styles.sortByTextStyle),
        SizedBox(height: 5),
        CustomSortBy(
          selectedValue: selectedSort,
          sortByItems: sortByItems,
          onChanged: (String? value) {
            onSortByChanged(value);
          },
        ),
      ],
    );
  }

  Widget getTabBar() {
    return CustomTabBar(tabs: [Text('All'), Text('Active'), Text('Sold')]);
  }

  Widget getMyListingList({required String listingStatus}) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return MyListingTab(
          onLongPress: onListingLongPressed,
          listingStatus: listingStatus,
        );
      },
    );
  }

  Widget getListingBottomSheet() {
    return Padding(
      padding: _Styles.screenPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetAction(
            icon: Icons.edit,
            color: ColorManager.blackColor,
            text: 'Edit',
            onTap: onEditPressed,
          ),
          SizedBox(height: 10),
          BottomSheetAction(
            icon: Icons.check,
            color: ColorManager.blackColor,
            text: 'Mark as sold',
            onTap: () {},
          ),
          SizedBox(height: 10),
          BottomSheetAction(
            icon: Icons.delete_outline,
            color: ColorManager.redColor,
            text: 'Remove',
            onTap: onRemovePressed,
          ),
        ],
      ),
    );
  }

  Widget getAlertDialogTextButton({
    required void Function()? onPressed,
    required String text,
  }) {
    return TextButton(
      style: _Styles.textButtonStyle,
      onPressed: onPressed,
      child: Text(text, style: _Styles.textButtonTextStyle),
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

  static const sortByTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static final textButtonStyle = ButtonStyle(
    overlayColor: WidgetStateProperty.all(ColorManager.lightGreyColor2),
  );

  static const textButtonTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );
}
