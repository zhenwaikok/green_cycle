import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/model/api_model/awareness/awareness_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/repository/awareness_repository.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/utils/mixins/error_handling_mixin.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/viewmodel/awareness_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/awareness_card.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class AwarenessScreen extends StatelessWidget {
  const AwarenessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          AwarenessViewModel(awarenessRepository: AwarenessRepository()),
      child: _AwarenessScreen(),
    );
  }
}

class _AwarenessScreen extends StatefulWidget {
  @override
  State<_AwarenessScreen> createState() => _AwarenessScreenState();
}

class _AwarenessScreenState extends State<_AwarenessScreen>
    with ErrorHandlingMixin {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Awareness Feed',
        isBackButtonVisible: true,
        onPressed: onBackButtonPressed,
      ),
      body: SafeArea(
        child: Padding(
          padding: _Styles.screenPadding,
          child: Skeletonizer(
            enabled: _isLoading,
            child: getAwarenessContent(
              awarenessModel: _isLoading
                  ? List.generate(5, (_) => AwarenessModel())
                  : _awarenessList,
            ),
          ),
        ),
      ),
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
    //TODO: get user role from shared preferences
    context.router.push(
      AwarenessDetailsRoute(userRole: 'Customer', awarenessId: awarenessID),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _AwarenessScreenState {
  Widget getAwarenessContent({required List<AwarenessModel> awarenessModel}) {
    return ListView.builder(
      itemCount: awarenessModel.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Padding(
              padding: _Styles.awarenessContentPadding,
              child: GestureDetector(
                onTap: () => onAwarenessCardPressed(
                  awarenessID: awarenessModel[index].awarenessID ?? 0,
                ),
                child: CustomAwarenessCard(
                  imageURL: awarenessModel[index].awarenessImageURL ?? '',
                  awarenessTitle: awarenessModel[index].awarenessTitle ?? '',
                  date: WidgetUtil.dateFormatter(
                    awarenessModel[index].createdDate ?? DateTime.now(),
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

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const awarenessContentPadding = EdgeInsets.symmetric(vertical: 15);
}
