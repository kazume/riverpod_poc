import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_poc/preferences/preferences.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Onboarding'),
            Consumer(
              builder: (_, ref, __) {
                final settings = ref.read(settingsServiceProvider);
                return ElevatedButton(
                  onPressed: () => ref
                      .read(settingsStateProvider.notifier)
                      .setOnboardingComplete(true),
                  child: const Text('GO'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
