import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../elements/pages.dart';
import '../preferences/preferences.dart';
import 'screens.dart';

class OnboardingScreen extends ConsumerWidget {
  static FadingPage page() {
    return const FadingPage(
      name: Screens.onboarding,
      key: ValueKey(Screens.onboarding),
      child: OnboardingScreen(),
    );
  }

  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Onboarding'),
            ElevatedButton(
              onPressed: () => ref
                  .read(settingsNotifierProvider.notifier)
                  .setOnboardingComplete(true),
              child: const Text('GO'),
            ),
          ],
        ),
      ),
    );
  }
}
