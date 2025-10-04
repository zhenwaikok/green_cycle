import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
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
import 'package:green_cycle_fyp/widget/no_data_label.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class AwarenessScreen extends StatelessWidget {
  const AwarenessScreen({super.key});

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
      child: _AwarenessScreen(),
    );
  }
}

class _AwarenessScreen extends BaseStatefulPage {
  @override
  State<_AwarenessScreen> createState() => _AwarenessScreenState();
}

class _AwarenessScreenState extends BaseStatefulState<_AwarenessScreen> {
  List<AwarenessModel> _awarenessList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialLoad();
    });
  }

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Awareness Feed',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  Widget body() {
    return AdaptiveWidgets.buildRefreshableScrollView(
      context,
      onRefresh: initialLoad,
      color: ColorManager.blackColor,
      refreshIndicatorBackgroundColor: ColorManager.whiteColor,
      slivers: [
        ...getAwarenessContent(
          awarenessModel: _isLoading
              ? List.generate(
                  5,
                  (_) => AwarenessModel(awarenessTitle: 'Loading...'),
                )
              : _awarenessList,
          isLoading: _isLoading,
        ),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _AwarenessScreenState {
  Future<void> initialLoad() async {
    _setState(() => _isLoading = true);
    final awarenessList = await tryCatch(
      context,
      () => context.read<AwarenessViewModel>().getAwarenessList(),
    );
    if (awarenessList != null) {
      _setState(() => _awarenessList = awarenessList);
    }
    _setState(() => _isLoading = false);
  }

  void onBackButtonPressed() {
    context.router.maybePop();
  }

  void onAwarenessCardPressed({required int awarenessID}) {
    final user = context.read<UserViewModel>().user;

    context.router.push(
      AwarenessDetailsRoute(
        userRole: user?.userRole ?? '',
        awarenessId: awarenessID,
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _AwarenessScreenState {
  List<Widget> getAwarenessContent({
    required List<AwarenessModel> awarenessModel,
    required bool isLoading,
  }) {
    if (awarenessModel.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: NoDataAvailableLabel(noDataText: 'No Awareness Found'),
          ),
        ),
      ];
    }

    return [
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final item = awarenessModel[index];
          return Column(
            children: [
              Padding(
                padding: _Styles.awarenessContentPadding,
                child: TouchableOpacity(
                  isLoading: isLoading,
                  onPressed: () => onAwarenessCardPressed(
                    awarenessID: item.awarenessID ?? 0,
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
        }, childCount: awarenessModel.length),
      ),
    ];
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();
  static const awarenessContentPadding = EdgeInsets.symmetric(vertical: 15);
}
