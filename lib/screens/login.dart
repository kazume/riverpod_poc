import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_poc/elements/pages.dart';
import 'package:riverpod_poc/navigation/navigation_state.dart';
import 'package:riverpod_poc/screens/screens.dart';

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
    print('build Login');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ref.read(navigationControllerProvider.notifier).setLoggedIn(true);
          },
          child: const Text('LOGIN'),
        ),
      ),
    );
  }
}
