import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/awareness/awareness_model.dart';
import 'package:green_cycle_fyp/repository/awareness_repository.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/services/awareness_services.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/awareness_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/bottom_sheet_action.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:provider/provider.dart';

@RoutePage()
class AwarenessDetailsScreen extends StatelessWidget {
  const AwarenessDetailsScreen({
    super.key,
    required this.userRole,
    required this.awarenessId,
  });

  final String userRole;
  final int awarenessId;
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
      child: _AwarenessDetailsScreen(
        userRole: userRole,
        awarenessId: awarenessId,
      ),
    );
  }
}

class _AwarenessDetailsScreen extends BaseStatefulPage {
  const _AwarenessDetailsScreen({
    required this.userRole,
    required this.awarenessId,
  });

  final String userRole;
  final int awarenessId;

  @override
  State<_AwarenessDetailsScreen> createState() =>
      _AwarenessDetailsScreenState();
}

class _AwarenessDetailsScreenState
    extends BaseStatefulState<_AwarenessDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialLoad();
    });
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Awareness Details',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
      actions: [
        if (widget.userRole == 'Admin')
          IconButton(
            onPressed: onMoreButtonPressed,
            icon: Icon(Icons.more_horiz, color: ColorManager.whiteColor),
          ),
      ],
    );
  }

  @override
  Widget body() {
    final awarenessDetails = context.select(
      (AwarenessViewModel vm) => vm.awarenessDetails,
    );

    return SingleChildScrollView(
      child: getAwarenessDetails(
        awarenessModel: awarenessDetails ?? AwarenessModel(),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _AwarenessDetailsScreenState {
  Future<void> initialLoad() async {
    await tryLoad(
      context,
      () => context.read<AwarenessViewModel>().getAwarenessDetails(
        awarenessID: widget.awarenessId,
      ),
    );
  }

  void onBackButtonPressed() {
    context.router.maybePop(true);
  }

  void onEditButtonPressed() async {
    await context.router.maybePop();
    final result = mounted
        ? await context.router.push(
            AddOrEditAwarenessRoute(
              isEdit: true,
              awarenessId: widget.awarenessId,
            ),
          )
        : null;

    if (result == true && mounted) {
      initialLoad();
    }
  }

  void onMoreButtonPressed() async {
    showModalBottomSheet(
      backgroundColor: ColorManager.whiteColor,
      context: context,
      builder: (context) {
        return getMoreBottomSheet();
      },
    );
  }

  void onRemovePressed() async {
    WidgetUtil.showAlertDialog(
      context,
      title: 'Delete Confirmation',
      content: 'Are you sure you want to delete this awareness content?',
      actions: [
        getAlertDialogTextButton(onPressed: () {}, text: 'Cancel'),
        getAlertDialogTextButton(onPressed: () {}, text: 'Confirm'),
      ],
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _AwarenessDetailsScreenState {
  Widget getAwarenessDetails({required AwarenessModel awarenessModel}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getImage(awarenessModel: awarenessModel),
        SizedBox(height: 25),
        getTitleDate(awarenessModel: awarenessModel),
        SizedBox(height: 30),
        getDescription(awarenessModel: awarenessModel),
      ],
    );
  }

  Widget getImage({required AwarenessModel awarenessModel}) {
    return CustomImage(
      borderRadius: _Styles.borderRadius,
      imageWidth: double.infinity,
      imageSize: MediaQuery.of(context).size.height * 0.4,
      imageURL: awarenessModel.awarenessImageURL ?? '',
    );
  }

  Widget getTitleDate({required AwarenessModel awarenessModel}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          awarenessModel.awarenessTitle ?? '-',
          style: _Styles.awarenessTitleTextStyle,
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Icon(
              Icons.access_time,
              color: ColorManager.greyColor,
              size: _Styles.iconSize,
            ),
            SizedBox(width: 5),
            Text(
              WidgetUtil.dateFormatter(
                awarenessModel.createdDate ?? DateTime.now(),
              ),
              style: _Styles.dateTextStyle,
            ),
          ],
        ),
      ],
    );
  }

  Widget getDescription({required AwarenessModel awarenessModel}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description:', style: _Styles.descTitleTextStyle),
        SizedBox(height: 5),
        Text(
          awarenessModel.awarenessContent ?? '-',
          style: _Styles.descTextStyle,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget getMoreBottomSheet() {
    return Padding(
      padding: _Styles.screenPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetAction(
            icon: Icons.edit,
            color: ColorManager.blackColor,
            text: 'Edit',
            onTap: onEditButtonPressed,
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

  static const borderRadius = 15.0;
  static const iconSize = 20.0;

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const awarenessTitleTextStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const dateTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const descTitleTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const descTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
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
