import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

class SettingsRepository {
  final SharedPreferences sharedPreferences;

  SettingsRepository(this.sharedPreferences);

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

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return SettingsRepository(sharedPreferences);
});