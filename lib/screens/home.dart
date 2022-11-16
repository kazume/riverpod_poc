import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../elements/pages.dart';
import '../navigation/navigation_state.dart';
import '../preferences/preferences.dart';
import '../screens/screens.dart';

class Home extends ConsumerWidget {
  static FadingPage page() {
    return const FadingPage(
      name: Screens.home,
      key: ValueKey(Screens.home),
      child: Home(
        title: 'Home',
      ),
    );
  }

  final String title;

  const Home({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('Build Home');
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () => ref
                .read(navigationControllerProvider.notifier)
                .setSettingsSelected(true),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Home'),
            Text(
              'Mode: ${ref.watch(settingsNotifierProvider).themeMode.name}',
            ),
            ElevatedButton(
              onPressed: () => ref
                  .read(settingsNotifierProvider.notifier)
                  .toggleThemeMode(),
              child: const Text('toggle mode'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            ref.read(navigationControllerProvider.notifier).setLoggedIn(false),
        tooltip: 'Clear',
        child: const Icon(Icons.clear),
      ),
    );
  }
}
