import 'package:flutter/material.dart';

class FadeInRoute extends PageRouteBuilder {
  final Widget widget;
  FadeInRoute({required this.widget})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return widget;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: Tween<double>(
                  begin: 0.0,
                  end: 1.0,
                ).animate(animation),
                curve: Curves.ease,
              ),
              child: child,
            );
          },
        );
}
