import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_poc/app/navigation/navigation_notifier.dart';

import 'screens.dart';

class SettingsScreen extends StatelessWidget {
  static MaterialPage page() {
    return const MaterialPage(
      name: Screens.settings,
      key: ValueKey(Screens.settings),
      child: SettingsScreen(),
    );
  }

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          Consumer(
            builder: (context, ref, child) => OutlinedButton(
              onPressed: () {
                ref
                    .read(navigationNotifierProvider.notifier)
                    .setOnboarded(false);
              },
              child: child ?? const Text('click me'),
            ),
            child: const Text('De-Onboard'),
          )
        ],
      ),
    );
  }
}
