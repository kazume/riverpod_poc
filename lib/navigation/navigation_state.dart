import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../settings/settings.dart';

final navigationNotifierProvider =
    NotifierProvider<NavigationNotifier, NavigationState>(
  NavigationNotifier.new,
);

class NavigationNotifier extends Notifier<NavigationState> {
  @override
  NavigationState build() {
    final settings = ref.read(settingsNotifierProvider);
    return NavigationState(
      isLoggedIn: false,
      isSettingsSelected: false,
      isOnboarded: settings.onboardingComplete,
    );
  }

  void setSettingsSelected(bool selected) {
    state = state.copyWith(isSettingsSelected: selected);
  }

  void setLoggedIn(bool loggedIn) {
    state = state.copyWith(isLoggedIn: loggedIn);
  }

  void setOnboarded(bool onboarded) {
    state = state.copyWith(
      isOnboarded: onboarded,
      isLoggedIn: onboarded && state.isLoggedIn,
      isSettingsSelected: onboarded && state.isSettingsSelected,
    );

    ref
        .read(settingsNotifierProvider.notifier)
        .setOnboardingComplete(onboarded);
  }

  void exitApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else {
      exit(0);
    }
  }
}

@immutable
class NavigationState {
  final bool isLoggedIn;
  final bool isSettingsSelected;
  final bool isOnboarded;

  const NavigationState({
    required this.isLoggedIn,
    required this.isSettingsSelected,
    required this.isOnboarded,
  });

  NavigationState copyWith({
    bool? isLoggedIn,
    bool? isSettingsSelected,
    bool? isOnboarded,
  }) {
    return NavigationState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isSettingsSelected: isSettingsSelected ?? this.isSettingsSelected,
      isOnboarded: isOnboarded ?? this.isOnboarded,
    );
  }
}
