import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/awareness_card.dart';
import 'package:green_cycle_fyp/widget/custom_sort_by.dart';

@RoutePage()
class ManageAwarenessScreen extends StatefulWidget {
  const ManageAwarenessScreen({super.key});

  @override
  State<ManageAwarenessScreen> createState() => _ManageAwarenessScreenState();
}

class _ManageAwarenessScreenState extends State<ManageAwarenessScreen> {
  final List<String> sortByItems = ['All', 'Name: A-Z', 'Name: Z-A', 'Latest'];

  String? selectedSortBy;

  @override
  void initState() {
    selectedSortBy = sortByItems.first;
    super.initState();
  }

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Awareness Management',
        isBackButtonVisible: false,
        actions: [
          IconButton(
            onPressed: onAddButtonPressed,
            icon: Icon(Icons.add, color: ColorManager.whiteColor),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: _Styles.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getSortBy(),
              SizedBox(height: 15),
              Expanded(child: getAwarenessContent()),
            ],
          ),
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ManageAwarenessScreenState {
  void onSortByChanged(String? value) {
    _setState(() {
      selectedSortBy = value;
    });
  }

  void onAwarenessCardPressed() {
    //TODO: get user role from shared preferences
    context.router.push(
      AwarenessDetailsRoute(userRole: 'Admin', awarenessId: 0),
    );
  }

  void onAddButtonPressed() {
    context.router.push(AddOrEditAwarenessRoute(isEdit: false));
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ManageAwarenessScreenState {
  Widget getSortBy() {
    return CustomSortBy(
      sortByItems: sortByItems,
      selectedValue: selectedSortBy,
      onChanged: (value) {
        onSortByChanged(value);
      },
    );
  }

  Widget getAwarenessContent() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Padding(
              padding: _Styles.awarenessContentPadding,
              child: GestureDetector(
                onTap: onAwarenessCardPressed,
                child: CustomAwarenessCard(
                  imageURL:
                      'https://images.pexels.com/photos/1667088/pexels-photo-1667088.jpeg',
                  awarenessTitle:
                      'MyGOV Malaysia Mobile App Set To Transform Public Service Delivery',
                  date: '21/2/2025',
                ),
              ),
            ),

            Divider(color: ColorManager.lightGreyColor),
          ],
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

  static const awarenessContentPadding = EdgeInsets.symmetric(vertical: 15);
}
