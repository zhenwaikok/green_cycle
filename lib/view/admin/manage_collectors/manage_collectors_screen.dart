import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_sort_by.dart';

@RoutePage()
class ManageCollectorsScreen extends StatefulWidget {
  const ManageCollectorsScreen({super.key});

  @override
  State<ManageCollectorsScreen> createState() => _ManageCollectorsScreenState();
}

class _ManageCollectorsScreenState extends State<ManageCollectorsScreen> {
  final List<String> sortByItems = [
    'All',
    'Collector Name: A-Z',
    'Collector Name: Z - A',
    'Approved',
    'Pending',
    'Latest',
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
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Collectors Management',
        isBackButtonVisible: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: _Styles.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getSortBy(),
              SizedBox(height: 15),
              Expanded(child: getCollectorList()),
            ],
          ),
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ManageCollectorsScreenState {
  void onSortByChanged(String? value) {
    _setState(() {
      selectedSort = value;
    });
  }

  void onCollectorCardPressed() {
    context.router.push(CollectorDetailsRoute());
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ManageCollectorsScreenState {
  Widget getSortBy() {
    return CustomSortBy(
      sortByItems: sortByItems,
      selectedValue: selectedSort,
      onChanged: (value) {
        onSortByChanged(value);
      },
    );
  }

  Widget getCollectorList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return getCollectorCard();
      },
    );
  }

  Widget getCollectorCard() {
    return GestureDetector(
      onTap: onCollectorCardPressed,
      child: Padding(
        padding: _Styles.cardPadding,
        child: CustomCard(
          padding: _Styles.customCardPadding,
          needBoxShadow: false,
          needBorder: true,
          child: Row(
            children: [
              getCollectorImage(),
              SizedBox(width: 20),
              Expanded(child: getCollectorDetails()),
              Icon(
                Icons.keyboard_arrow_right_rounded,
                color: ColorManager.greyColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCollectorImage() {
    return CustomImage(
      imageSize: _Styles.imageSize,
      borderRadius: _Styles.imageBorderRadius,
      imageURL:
          'https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D',
    );
  }

  Widget getCollectorDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Collector Name',
          style: _Styles.collectorNameTextStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          'Company/Organization',
          style: _Styles.companyTextStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const imageSize = 60.0;
  static const imageBorderRadius = 40.0;

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const customCardPadding = EdgeInsets.all(10);
  static const cardPadding = EdgeInsets.symmetric(vertical: 5);

  static const collectorNameTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const companyTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );
}
