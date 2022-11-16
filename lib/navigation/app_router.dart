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
        final isOnboardingComplete = ref.watch(onboardedProvider);
        return Navigator(
          restorationScopeId: 'riverpodPocRestorationScopeId',
          key: navigatorKey,
          observers: [HeroController()],
          transitionDelegate: const DefaultTransitionDelegate(),
          onPopPage: (route, result) => _handlePopPage(ref, route, result),
          pages: [
            if (!isOnboardingComplete) OnboardingScreen.page(),
            if (isOnboardingComplete && navState.isLoggedIn) HomeScreen.page(),
            if (isOnboardingComplete && !navState.isLoggedIn)
              LoginScreen.page(),
            if (isOnboardingComplete && navState.isSettingsSelected)
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
