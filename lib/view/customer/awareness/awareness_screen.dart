import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/awareness_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class AwarenessScreen extends StatefulWidget {
  const AwarenessScreen({super.key});

  @override
  State<AwarenessScreen> createState() => _AwarenessScreenState();
}

class _AwarenessScreenState extends State<AwarenessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Awareness Feed',
        isBackButtonVisible: true,
        onPressed: onBackButtonPressed,
      ),
      body: Skeletonizer(
        //TODO: Change loading state later
        enabled: false,
        child: SafeArea(
          child: Padding(
            padding: _Styles.screenPadding,
            child: getAwarenessContent(),
          ),
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _AwarenessScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  void onAwarenessCardPressed() {
    //TODO: get user role from shared preferences
    context.router.push(AwarenessDetailsRoute(userRole: 'Customer'));
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _AwarenessScreenState {
  Widget getAwarenessContent() {
    return ListView.builder(
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
