import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/model/api_model/awareness/awareness_model.dart';
import 'package:green_cycle_fyp/repository/awareness_repository.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/services/awareness_services.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/awareness_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/awareness_card.dart';
import 'package:green_cycle_fyp/widget/custom_sort_by.dart';
import 'package:green_cycle_fyp/widget/no_data_label.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class ManageAwarenessScreen extends StatelessWidget {
  const ManageAwarenessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AwarenessViewModel(
        awarenessRepository: AwarenessRepository(
          awarenessServices: AwarenessServices(),
        ),
        firebaseRepository: FirebaseRepository(
          firebaseServices: FirebaseServices(),
        ),
      ),
      child: _ManageAwarenessScreen(),
    );
  }
}

class _ManageAwarenessScreen extends BaseStatefulPage {
  @override
  State<_ManageAwarenessScreen> createState() => _ManageAwarenessScreenState();
}

class _ManageAwarenessScreenState
    extends BaseStatefulState<_ManageAwarenessScreen> {
  final sortByItems = DropDownItems.awarenessSortByItems;
  String? selectedSortBy;
  bool _isLoading = true;
  List<AwarenessModel> _awarenessList = [];

  late final tabsRouter = AutoTabsRouter.of(context);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabsRouter.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    tabsRouter.removeListener(_onTabChanged);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchdata();
  }

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Awareness Management',
      isBackButtonVisible: false,
      actions: [
        IconButton(
          onPressed: onAddButtonPressed,
          icon: Icon(Icons.add, color: ColorManager.whiteColor),
        ),
      ],
    );
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  Widget body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getSortBy(),
        SizedBox(height: 15),
        Expanded(
          child: AdaptiveWidgets.buildRefreshableScrollView(
            context,
            onRefresh: fetchdata,
            color: ColorManager.blackColor,
            refreshIndicatorBackgroundColor: ColorManager.whiteColor,
            slivers: [
              ...getAwarenessContent(
                awarenessList: _isLoading
                    ? List.generate(
                        5,
                        (_) => AwarenessModel(awarenessTitle: 'Loading...'),
                      )
                    : _awarenessList,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ManageAwarenessScreenState {
  void _onTabChanged() {
    if (tabsRouter.activeIndex == 3) {
      _setState(() {
        selectedSortBy = sortByItems.first;
      });
    }
  }

  void onSortByChanged(String? value) {
    _setState(() {
      selectedSortBy = value;
    });
  }

  void onAwarenessCardPressed({required int awarenessId}) async {
    final user = context.read<UserViewModel>().user;
    final result = await context.router.push(
      AwarenessDetailsRoute(
        userRole: user?.userRole ?? '',
        awarenessId: awarenessId,
      ),
    );

    if (result == true && mounted) {
      fetchdata();
    }
  }

  void onAddButtonPressed() async {
    final result = await context.router.push(
      AddOrEditAwarenessRoute(isEdit: false),
    );

    if (result == true && mounted) {
      fetchdata();
    }
  }

  void sortAwarenessList({required List<AwarenessModel> awarenessList}) {
    if (selectedSortBy == sortByItems[1]) {
      awarenessList.sort(
        (a, b) => (a.awarenessTitle?.toLowerCase() ?? '').compareTo(
          b.awarenessTitle?.toLowerCase() ?? '',
        ),
      );
    } else if (selectedSortBy == sortByItems[2]) {
      awarenessList.sort(
        (a, b) => (b.awarenessTitle?.toLowerCase() ?? '').compareTo(
          a.awarenessTitle?.toLowerCase() ?? '',
        ),
      );
    } else if (selectedSortBy == sortByItems[3]) {
      awarenessList.sort(
        (a, b) => (b.createdDate ?? DateTime.now()).compareTo(
          a.createdDate ?? DateTime.now(),
        ),
      );
    } else {
      awarenessList.sort(
        (a, b) => (a.awarenessID ?? 0).compareTo(b.awarenessID ?? 0),
      );
    }
  }

  Future<void> fetchdata() async {
    _setState(() {
      _isLoading = true;

      selectedSortBy = sortByItems.first;
    });
    final awarenessList = await tryCatch(
      context,
      () => context.read<AwarenessViewModel>().getAwarenessList(),
    );
    if (awarenessList != null) {
      _setState(() => _awarenessList = awarenessList);
    }
    _setState(() => _isLoading = false);
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

  List<Widget> getAwarenessContent({
    required List<AwarenessModel> awarenessList,
    required bool isLoading,
  }) {
    sortAwarenessList(awarenessList: awarenessList);
    return [
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final item = awarenessList[index];

          if (awarenessList.isEmpty) {
            return SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: NoDataAvailableLabel(noDataText: 'No Awareness Found'),
              ),
            );
          }

          return Column(
            children: [
              Padding(
                padding: _Styles.awarenessContentPadding,
                child: TouchableOpacity(
                  isLoading: isLoading,
                  onPressed: () => onAwarenessCardPressed(
                    awarenessId: item.awarenessID ?? 0,
                  ),
                  child: Skeletonizer(
                    enabled: isLoading,
                    child: CustomAwarenessCard(
                      imageURL: item.awarenessImageURL ?? '',
                      awarenessTitle: item.awarenessTitle ?? '',
                      date: WidgetUtil.dateFormatter(
                        item.createdDate ?? DateTime.now(),
                      ),
                    ),
                  ),
                ),
              ),
              Divider(color: ColorManager.lightGreyColor),
            ],
          );
        }, childCount: awarenessList.length),
      ),
    ];
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const awarenessContentPadding = EdgeInsets.symmetric(vertical: 15);
}
