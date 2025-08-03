import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
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
  final List<String> sortByItems = ['All', 'Name: A-Z', 'Name: Z-A', 'Latest'];

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
          child: Skeletonizer(
            enabled: _isLoading,
            child: getAwarenessContent(
              awarenessList: _isLoading
                  ? List.generate(
                      5,
                      (_) => AwarenessModel(awarenessTitle: 'Loading...'),
                    )
                  : _awarenessList,
            ),
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
      initialLoad();
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
      initialLoad();
    }
  }

  void onAddButtonPressed() async {
    final result = await context.router.push(
      AddOrEditAwarenessRoute(isEdit: false),
    );

    if (result == true && mounted) {
      initialLoad();
    }
  }

  Future<void> initialLoad() async {
    _setState(() => _isLoading = true);
    final awarenessList = await tryLoad(
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

  Widget getAwarenessContent({required List<AwarenessModel> awarenessList}) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: awarenessList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Padding(
              padding: _Styles.awarenessContentPadding,
              child: TouchableOpacity(
                onPressed: () => onAwarenessCardPressed(
                  awarenessId: awarenessList[index].awarenessID ?? 0,
                ),
                child: CustomAwarenessCard(
                  imageURL: awarenessList[index].awarenessImageURL ?? '',
                  awarenessTitle: awarenessList[index].awarenessTitle ?? '',
                  date: WidgetUtil.dateFormatter(
                    awarenessList[index].createdDate ?? DateTime.now(),
                  ),
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

  static const awarenessContentPadding = EdgeInsets.symmetric(vertical: 15);
}
