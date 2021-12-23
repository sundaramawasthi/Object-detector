import 'package:flutter/material.dart';

class BouncyPageRoute extends PageRouteBuilder {
  final Widget widget;

  BouncyPageRoute({required this.widget})
      : super(
          transitionDuration: Duration(milliseconds: 1500),
          transitionsBuilder: (context, animation, secAnimation, child) {
            animation = CurvedAnimation(
              parent: animation,
              curve: Curves.elasticInOut,
            );
            return ScaleTransition(
              scale: animation,
              alignment: Alignment.bottomRight,
              child: child,
            );
          },
          pageBuilder: (context, animation, secAnimation) {
            return widget;
          },
        );
}
