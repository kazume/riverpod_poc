import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationControllerProvider =
    NotifierProvider<NavigationController, NavigationState>(
  () => NavigationController(),
);

class NavigationController extends Notifier<NavigationState> {
  @override
  NavigationState build() {
    return const NavigationState(
      isLoggedIn: false,
      isSettingsSelected: false,
    );
  }

  void setSettingsSelected(bool selected) {
    state = state.copyWith(isSettingsSelected: selected);
  }

  void setLoggedIn(bool loggedIn) {
    state = state.copyWith(isLoggedIn: loggedIn);
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

  const NavigationState({
    required this.isLoggedIn,
    required this.isSettingsSelected,
  });

  NavigationState copyWith({
    bool? isLoggedIn,
    bool? isSettingsSelected,
  }) {
    return NavigationState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isSettingsSelected: isSettingsSelected ?? this.isSettingsSelected,
    );
  }
}
