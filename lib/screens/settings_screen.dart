import 'package:flutter/material.dart';

import '../screens/screens.dart';

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
    );
  }
}
