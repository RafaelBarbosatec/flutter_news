import 'package:flutter/material.dart';
class FadeInRoute extends PageRouteBuilder {
  final Widget widget;
  FadeInRoute({this.widget})
      : super(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return widget;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return new FadeTransition(
          opacity: new CurvedAnimation(
              parent: new Tween<double>(
                  begin: 0.0,
                  end: 1.0
              ).animate(animation),
              curve: Curves.ease
          ),
          child: child,
        );
      }
  );
}
