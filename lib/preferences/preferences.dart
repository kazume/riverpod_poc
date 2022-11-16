import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

final onboardedProvider = StateProvider<bool>(
  (ref) => ref.watch(settingsNotifierProvider).onboardingComplete,
);

class OnboardedNotifier extends Notifier<bool> {
  setOnboarded(bool onboarded) {
    state = onboarded;
    ref.read(_settingsServiceProvider).setOnboardingComplete(onboarded);
  }

  @override
  bool build() {
    return ref.read(_settingsServiceProvider).onboardingComplete();
  }
}

final _settingsServiceProvider = Provider<SettingsService>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return SettingsService(sharedPreferences);
});

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
    final settingsService = ref.read(_settingsServiceProvider);
    return SettingsState(
      settingsService.onboardingComplete(),
      settingsService.themeMode(),
    );
  }

  setOnboardingComplete(bool onboarding) {
    state = state.copyWith(onboardingComplete: onboarding);
    ref.read(_settingsServiceProvider).setOnboardingComplete(onboarding);
  }

  setThemeMode(ThemeMode themeMode) {
    state = state.copyWith(themeMode: themeMode);
    ref.read(_settingsServiceProvider).setThemeMode(themeMode);
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

class SettingsService {
  final SharedPreferences sharedPreferences;

  SettingsService(this.sharedPreferences);

  ThemeMode themeMode() {
    return ThemeMode.values.byName(
      sharedPreferences.getString('themeMode') ?? ThemeMode.system.name,
    );
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await sharedPreferences.setString('themeMode', themeMode.name);
  }

  bool onboardingComplete() {
    return sharedPreferences.getBool('onboardingComplete') ?? false;
  }

  Future<void> setOnboardingComplete(bool complete) async {
    await sharedPreferences.setBool('onboardingComplete', complete);
  }
}
