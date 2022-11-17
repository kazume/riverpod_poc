import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../navigation/app_router.dart';
import '../presentation/state/settings_state.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Riverpod Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ref.watch(settingsNotifierProvider).themeMode,
      home: Router(
        routerDelegate: AppRouter(),
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}
