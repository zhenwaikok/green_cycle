import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';

@RoutePage()
class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialLoad();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _InitScreenState {
  void initialLoad() {
    final hasOnboarded = SharedPreferenceHandler().getHasOnboarded() ?? false;
    if (hasOnboarded) {
      context.router.replaceAll([LoginRoute()]);
    } else {
      context.router.replaceAll([OnboardingRoute()]);
    }
  }
}
