import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/settings_repository.dart';

final settingsNotifierProvider =
    NotifierProvider<SettingsNotifier, SettingsState>(
  () => SettingsNotifier(),
);

@immutable
class SettingsState {
  final bool onboardingComplete;
  final ThemeMode themeMode;

  const SettingsState(this.onboardingComplete, this.themeMode);

  SettingsState copyWith({bool? onboardingComplete, ThemeMode? themeMode}) =>
      SettingsState(
        onboardingComplete ?? this.onboardingComplete,
        themeMode ?? this.themeMode,
      );
}

class SettingsNotifier extends Notifier<SettingsState> {
  @override
  SettingsState build() {
    final settingsService = ref.read(settingsRepositoryProvider);
    return SettingsState(
      settingsService.onboardingComplete(),
      settingsService.themeMode(),
    );
  }

  setOnboardingComplete(bool complete) {
    state = state.copyWith(onboardingComplete: complete);
    ref.read(settingsRepositoryProvider).setOnboardingComplete(complete);
  }

  setThemeMode(ThemeMode themeMode) {
    state = state.copyWith(themeMode: themeMode);
    ref.read(settingsRepositoryProvider).setThemeMode(themeMode);
  }

  toggleThemeMode() {
    switch (state.themeMode) {
      case ThemeMode.system:
        setThemeMode(ThemeMode.light);
        break;
      case ThemeMode.light:
        setThemeMode(ThemeMode.dark);
        break;
      case ThemeMode.dark:
        setThemeMode(ThemeMode.system);
        break;
    }
  }
}
