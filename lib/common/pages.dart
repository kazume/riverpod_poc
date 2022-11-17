import 'package:flutter/widgets.dart';

class FadingPage extends Page {
  final Widget child;

  const FadingPage({
    LocalKey? key,
    required this.child,
    String? name,
  }) : super(
          key: key,
          name: name,
        );

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}

class TransparentPage extends Page {
  final Widget child;

  const TransparentPage({required this.child, LocalKey? key}) : super(key: key);

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      opaque: false,
      settings: this,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
