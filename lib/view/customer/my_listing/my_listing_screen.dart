import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/customer/my_listing/my_listing_tab.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_sort_by.dart';

@RoutePage()
class MyListingScreen extends StatefulWidget {
  const MyListingScreen({super.key});

  @override
  State<MyListingScreen> createState() => _MyListingScreenState();
}

class _MyListingScreenState extends State<MyListingScreen> {
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
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'My Listing',
          isBackButtonVisible: true,
          onPressed: onBackButtonPressed,
        ),
        body: SafeArea(
          child: Padding(
            padding: _Styles.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                getSortBy(),
                getTabBar(),
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
          ),
        ),
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
          onChanged: onSortByChanged,
        ),
      ],
    );
  }

  Widget getTabBar() {
    return TabBar(
      tabs: [Text('All'), Text('Active'), Text('Sold')],
      dividerColor: Colors.transparent,
      indicatorColor: ColorManager.primary,
      labelColor: ColorManager.primary,
      unselectedLabelColor: ColorManager.greyColor,
      labelStyle: _Styles.tabLabelTextStyle,
      padding: _Styles.tabBarPadding,
      labelPadding: _Styles.tabBarLabelPadding,
      overlayColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.pressed)) {
          return ColorManager.lightGreyColor2;
        }
        return null;
      }),
    );
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
          getBottomSheetAction(
            icon: Icons.edit,
            color: ColorManager.blackColor,
            text: 'Edit',
            onTap: () {},
          ),
          SizedBox(height: 10),
          getBottomSheetAction(
            icon: Icons.check,
            color: ColorManager.blackColor,
            text: 'Mark as sold',
            onTap: () {},
          ),
          SizedBox(height: 10),
          getBottomSheetAction(
            icon: Icons.delete_outline,
            color: ColorManager.redColor,
            text: 'Remove',
            onTap: onRemovePressed,
          ),
        ],
      ),
    );
  }

  Widget getBottomSheetAction({
    required IconData icon,
    required Color color,
    required String text,
    required void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(_Styles.inkWellBorderRadus),
      child: Padding(
        padding: _Styles.inkWellPadding,
        child: Row(
          children: [
            Icon(icon, color: color, size: _Styles.bottomSheetActionIconSize),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: _Styles.bottomSheetActionTextStyle(color: color),
              ),
            ),
          ],
        ),
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

  static const bottomSheetActionIconSize = 25.0;
  static const inkWellBorderRadus = 10.0;

  static const inkWellPadding = EdgeInsets.all(5);

  static const tabBarPadding = EdgeInsets.symmetric(vertical: 20);

  static const tabBarLabelPadding = EdgeInsets.symmetric(vertical: 10);

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const tabLabelTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.regular,
  );

  static const sortByTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static TextStyle bottomSheetActionTextStyle({required Color color}) =>
      TextStyle(
        fontSize: 16,
        fontWeight: FontWeightManager.regular,
        color: color,
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
