import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/settings_repository.dart';

@immutable
class SettingsState {
  final ThemeMode themeMode;

  const SettingsState(this.themeMode);

  SettingsState copyWith({bool? onboardingComplete, ThemeMode? themeMode}) =>
      SettingsState(themeMode ?? this.themeMode);
}

class SettingsNotifier extends Notifier<SettingsState> {
  @override
  SettingsState build() {
    final settingsService = ref.read(settingsRepositoryProvider);
    return SettingsState(
      settingsService.themeMode(),
    );
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

final settingsNotifierProvider =
    NotifierProvider<SettingsNotifier, SettingsState>(() => SettingsNotifier());
