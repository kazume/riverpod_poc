import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/navigation_notifier.dart';
import '../common/pages.dart';
import '../screens.dart';
import '../../app/settings_notifier.dart';

class HomeScreen extends ConsumerWidget {
  static FadingPage page() {
    return const FadingPage(
      name: Screens.home,
      key: ValueKey(Screens.home),
      child: HomeScreen(
        title: 'Home',
      ),
    );
  }

  final String title;

  const HomeScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () => ref
                .read(navigationNotifierProvider.notifier)
                .setSettingsSelected(true),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home'),
            Text(
              'Mode: ${ref.watch(settingsNotifierProvider).themeMode.name}',
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(settingsNotifierProvider.notifier).toggleThemeMode();
              },
              child: const Text('toggle mode'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(navigationNotifierProvider.notifier).setLoggedIn(false);
        },
        tooltip: 'Clear',
        child: const Icon(Icons.clear),
      ),
    );
  }
}
