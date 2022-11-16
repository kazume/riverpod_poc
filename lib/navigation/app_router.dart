import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_poc/preferences/preferences.dart';

import '../navigation/navigation_state.dart';
import '../screens/screens.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouter() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final navState = ref.watch(navigationNotifierProvider);
        final isOnboarded = ref.watch(onboardedProvider);
        return Navigator(
          key: navigatorKey,
          observers: [HeroController()],
          transitionDelegate: const DefaultTransitionDelegate(),
          onPopPage: (route, result) => _handlePopPage(ref, route, result),
          pages: [
            if (!isOnboarded) OnboardingScreen.page(),
            if (isOnboarded && navState.isLoggedIn) HomeScreen.page(),
            if (isOnboarded && !navState.isLoggedIn) LoginScreen.page(),
            if (isOnboarded && navState.isSettingsSelected)
              SettingsScreen.page(),
          ],
        );
      },
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) async {}

  bool _handlePopPage(WidgetRef ref, Route<dynamic> route, result) {
    final navigationController = ref.read(
      navigationNotifierProvider.notifier,
    );
    if (!route.didPop(result)) {
      return false;
    }
    if (route.settings.name == Screens.settings) {
      navigationController.setSettingsSelected(false);
    }
    return true;
  }
}
