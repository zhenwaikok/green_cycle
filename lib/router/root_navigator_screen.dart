import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/utils/notification_handler.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';

@RoutePage()
class RootNavigatorScreen extends StatefulWidget {
  const RootNavigatorScreen({super.key});

  @override
  State<RootNavigatorScreen> createState() => _RootNavigatorScreenState();
}

class _RootNavigatorScreenState extends State<RootNavigatorScreen> {
  late final UserViewModel _userVM;
  bool _isUserLoggedIn = false;
  StreamSubscription<String>? _deepLinkSubscription;

  @override
  void initState() {
    super.initState();

    _userVM = context.read<UserViewModel>();

    _isUserLoggedIn = _userVM.isLoggedIn;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _navigateBasedOnState();

      //Handle deep links
      _deepLinkSubscription = NotificationHandler.instance.deepLinkStream
          .listen(deeplinkHandler);

      // Initialize Notification Handler
      unawaited(NotificationHandler.instance.init());
    });

    // Listen to login state changes using ChangeNotifier
    _userVM.addListener(_onUserVMChanged);
  }

  void deeplinkHandler(String deepLink) {
    if (mounted) {
      print('pushing to $deepLink');
      context.router.pushNamed(
        deepLink,
        onFailure: (failure) {
          debugPrint(failure.toString());
        },
      );
    }
  }

  @override
  void dispose() {
    _deepLinkSubscription?.cancel();
    _userVM.removeListener(_onUserVMChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AutoRouter();
  }

  Future<void> _navigateBasedOnState() async {
    final hasOnboarded = SharedPreferenceHandler().getHasOnboarded() ?? false;
    final userRole = _userVM.user?.userRole;
    print('user: ${_userVM.user}');
    if (hasOnboarded) {
      if (_isUserLoggedIn) {
        print('is log in');
        print('user role2: $userRole');
        await context.router.replaceAll([
          CustomBottomNavBar(userRole: userRole ?? ''),
        ]);
      } else {
        print('is not log in');
        await context.router.replaceAll([LoginRoute()]);
      }
    } else {
      print('is onbaord');
      await context.router.replaceAll([OnboardingRoute()]);
    }
  }

  void _onUserVMChanged() {
    if (mounted && _isUserLoggedIn != _userVM.isLoggedIn) {
      _isUserLoggedIn = _userVM.isLoggedIn;
      // Since we're in a listener, we might need to schedule the navigation after the current frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        NotificationHandler.instance.updateTokenToServer();
        _navigateBasedOnState();
      });
    }
  }
}
