import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';

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
    return SizedBox();
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _InitScreenState {
  Future<void> initialLoad() async {
    EasyLoading.show();
    await Future.delayed(const Duration(milliseconds: 700));

    final hasOnboarded = SharedPreferenceHandler().getHasOnboarded() ?? false;
    if (hasOnboarded) {
      final isLoggedIn = mounted
          ? context.read<UserViewModel>().isLoggedIn
          : false;
      final userRole = mounted
          ? context.read<UserViewModel>().user.userRole ?? ''
          : '';

      if (isLoggedIn) {
        if (mounted) {
          await context.router.replaceAll([
            CustomBottomNavBar(userRole: userRole),
          ]);
        }
      } else {
        if (mounted) {
          await context.router.replaceAll([LoginRoute()]);
        }
      }
    } else {
      if (mounted) {
        await context.router.replaceAll([OnboardingRoute()]);
      }
    }

    EasyLoading.dismiss();
  }
}
