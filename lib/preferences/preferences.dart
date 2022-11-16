import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final isOnboardedProvider =
    StateNotifierProvider<OnboardedState, bool>((ref) => OnboardedState(ref));

class OnboardedState extends StateNotifier<bool> {
  final Ref ref;

  OnboardedState(this.ref) : super(false) {
    state = ref.read(settingsServiceProvider).onboardingComplete();
  }

  setOnboarded(bool onboarded) {
    state = onboarded;
    ref.read(settingsServiceProvider).setOnboardingComplete(onboarded);
  }
}

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final settingsServiceProvider = Provider<SettingsService>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return SettingsService(sharedPreferences);
});

final settingsStateProvider =
    NotifierProvider<SettingsController, SettingsState>(
  () => SettingsController(),
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

class SettingsController extends Notifier<SettingsState> {
  late final SettingsService settingsService;

  SettingsController() {
    settingsService = ref.read(settingsServiceProvider);
  }

  @override
  SettingsState build() {
    return SettingsState(
      settingsService.onboardingComplete(),
      settingsService.themeMode(),
    );
  }

  setOnboardingComplete(bool onboarding) {
    state = state.copyWith(onboardingComplete: onboarding);
    ref.read(settingsServiceProvider).setOnboardingComplete(onboarding);
  }

  setThemeMode(ThemeMode themeMode) => state = state.copyWith(
        themeMode: themeMode,
      );

  toggleThemeMode() {
    switch (state.themeMode) {
      case ThemeMode.system:
        state = state.copyWith(themeMode: ThemeMode.light);
        break;
      case ThemeMode.light:
        state = state.copyWith(themeMode: ThemeMode.dark);
        break;
      case ThemeMode.dark:
        state = state.copyWith(themeMode: ThemeMode.system);
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
