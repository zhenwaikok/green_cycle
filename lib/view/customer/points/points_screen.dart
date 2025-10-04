import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/points/points_model.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/view/customer/points/points_tab.dart';
import 'package:green_cycle_fyp/viewmodel/point_transaction_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_tab_bar.dart';
import 'package:green_cycle_fyp/widget/no_data_label.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class PointsScreen extends StatelessWidget {
  const PointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        UserViewModel(
          userRepository: UserRepository(
            sharePreferenceHandler: SharedPreferenceHandler(),
            userServices: UserServices(),
          ),
          firebaseRepository: FirebaseRepository(
            firebaseServices: FirebaseServices(),
          ),
        );
      },
      child: _PointsScreen(),
    );
  }
}

class _PointsScreen extends BaseStatefulPage {
  @override
  State<_PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends BaseStatefulState<_PointsScreen> {
  bool isLoading = true;

  void _setState(fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Points',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  EdgeInsets defaultPadding() {
    return EdgeInsets.zero;
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  Widget body() {
    final currentPoints = context.select(
      (UserViewModel vm) => vm.userDetails?.currentPoint ?? 0,
    );

    final pointTransactionList = context.select(
      (PointTransactionViewModel vm) => vm.pointTransactionList,
    );

    final earnedPointTransactionList = pointTransactionList
        .where((list) => list.type == 'earn')
        .toList();
    final usedPointTransactionList = pointTransactionList
        .where((list) => list.type == 'used')
        .toList();

    final loadingList = List.generate(
      5,
      (index) => PointsModel(
        description: 'Loading...',
        type: 'Loading...',
        point: 0,
        createdAt: DateTime.now(),
      ),
    );

    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: _Styles.screenPadding,
        child: Column(
          children: [
            Skeletonizer(
              enabled: isLoading,
              child: getCurrentPoints(currentPoints: currentPoints),
            ),
            SizedBox(height: 20),
            getTabBar(),
            SizedBox(height: 15),
            Expanded(
              child: TabBarView(
                children: [
                  buildTabContent(
                    pointTransactionList: isLoading
                        ? loadingList
                        : earnedPointTransactionList,
                  ),
                  buildTabContent(
                    pointTransactionList: isLoading
                        ? loadingList
                        : usedPointTransactionList,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _PointsScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  Future<void> fetchData() async {
    _setState(() {
      isLoading = true;
    });
    final userID = context.read<UserViewModel>().user?.userID ?? '';

    await tryCatch(
      context,
      () => context.read<UserViewModel>().getUserDetails(
        userID: userID,
        noNeedUpdateUserSharedPreference: true,
      ),
    );

    if (mounted) {
      await tryCatch(
        context,
        () => context
            .read<PointTransactionViewModel>()
            .getPointTransactionsWithUserID(userID: userID),
      );
    }

    _setState(() {
      isLoading = false;
    });
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _PointsScreenState {
  Widget getCurrentPoints({required int currentPoints}) {
    return CustomCard(
      child: Row(
        children: [
          Icon(
            FontAwesomeIcons.coins,
            color: ColorManager.blackColor,
            size: _Styles.coinIconSize,
          ),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              'Current Points',
              style: _Styles.currentPointsTextStyle,
            ),
          ),
          Text('$currentPoints', style: _Styles.pointsTextStyle),
        ],
      ),
    );
  }

  Widget getTabBar() {
    return CustomTabBar(tabs: [Text('Earned'), Text('Used')]);
  }

  Widget buildTabContent({required List<PointsModel> pointTransactionList}) {
    return AdaptiveWidgets.buildRefreshableScrollView(
      context,
      onRefresh: fetchData,
      color: ColorManager.blackColor,
      refreshIndicatorBackgroundColor: ColorManager.whiteColor,
      slivers: getPointTransactionList(
        pointTransactionList: pointTransactionList,
        isLoading: isLoading,
      ),
    );
  }

  List<Widget> getPointTransactionList({
    required List<PointsModel> pointTransactionList,
    required bool isLoading,
  }) {
    if (pointTransactionList.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: NoDataAvailableLabel(noDataText: 'No Transactions Found'),
          ),
        ),
      ];
    }

    return [
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return PointsTab(
            pointTransactionDetails: pointTransactionList[index],
            isLoading: isLoading,
          );
        }, childCount: pointTransactionList.length),
      ),
    ];
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 40,
  );

  static const coinIconSize = 28.0;
  static const currentPointsTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const pointsTextStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );
}
