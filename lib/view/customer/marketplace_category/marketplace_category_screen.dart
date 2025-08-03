import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_sort_by.dart';
import 'package:green_cycle_fyp/widget/second_hand_item.dart';

@RoutePage()
class MarketplaceCategoryScreen extends StatelessWidget {
  const MarketplaceCategoryScreen({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return _MarketplaceCategoryScreen(category: category);
  }
}

class _MarketplaceCategoryScreen extends BaseStatefulPage {
  const _MarketplaceCategoryScreen({required this.category});

  final String category;

  @override
  State<_MarketplaceCategoryScreen> createState() =>
      _MarketplaceCategoryScreenState();
}

class _MarketplaceCategoryScreenState
    extends BaseStatefulState<_MarketplaceCategoryScreen> {
  final List<String> sortByItems = [
    'All',
    'Name: A-Z',
    'Name: Z-A',
    'Price: Low-High',
    'Price: High-Low',
  ];

  final List<String> conditionItems = [
    'All',
    'Brand New',
    'Like New',
    'Very Good',
    'Good',
  ];

  String? selectedSort;
  String? selectedCondition;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    selectedSort = sortByItems.first;
    selectedCondition = conditionItems.first;
    super.initState();
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: widget.category,
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  Widget body() {
    return Column(
      children: [
        getFilterOptions(),
        SizedBox(height: 35),
        Expanded(child: getCategoryItems()),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _MarketplaceCategoryScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  void onSortByChanged(String? value) {
    _setState(() {
      selectedSort = value;
    });
  }

  void onConditionChanged(String? value) {
    _setState(() {
      selectedCondition = value;
    });
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _MarketplaceCategoryScreenState {
  Widget getFilterOptions() {
    return Row(
      children: [
        getFilterDetails(
          text: 'Sort By',
          filterItems: sortByItems,
          selectedValue: selectedSort ?? '',
          onChanged: onSortByChanged,
        ),
        SizedBox(width: 10),
        getFilterDetails(
          text: 'Condition',
          filterItems: conditionItems,
          selectedValue: selectedCondition ?? '',
          onChanged: onConditionChanged,
        ),
      ],
    );
  }

  Widget getFilterDetails({
    required String text,
    required List<String> filterItems,
    required String selectedValue,
    required void Function(String?)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: _Styles.sortByTextStyle),
        SizedBox(height: 5),
        CustomSortBy(
          sortByItems: filterItems,
          selectedValue: selectedValue,
          onChanged: onChanged,
          isExpanded: false,
        ),
      ],
    );
  }

  Widget getCategoryItems() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        mainAxisExtent: 210,
      ),
      itemCount: 7,
      itemBuilder: (context, index) {
        return Padding(
          padding: _Styles.itemPadding,
          child: SecondHandItem(
            imageURL:
                'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHx8MA%3D%3D',
            productName: 'Product Nameasdasdsad',
            productPrice: 'RM xx.xx',
            text: 'Like New',
          ),
        );
      },
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const itemPadding = EdgeInsets.all(5);

  static const sortByTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );
}
