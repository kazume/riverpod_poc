import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/navigation/navigation_notifier.dart';
import '../common/pages.dart';
import 'screens.dart';

class LoginScreen extends ConsumerWidget {
  static FadingPage page() {
    return const FadingPage(
      name: Screens.login,
      key: ValueKey(Screens.login),
      child: LoginScreen(),
    );
  }

  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ref.read(navigationNotifierProvider.notifier).setLoggedIn(true);
          },
          child: const Text('LOGIN'),
        ),
      ),
    );
  }
}
