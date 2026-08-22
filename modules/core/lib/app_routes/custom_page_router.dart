import 'dart:io';

import 'package:flutter/material.dart';

import '../utils/animation/animations.dart';

class CustomPageRouter {
  static PageRoute createRoute({required Widget page}) {
    if (Platform.isIOS) {
      return MaterialPageRoute(builder: (context) => page);
    } else if (Platform.isAndroid) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return AppAnimations.slideAnimation(animation, child);
        },
      );
    } else {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return AppAnimations.slideAnimation(animation, child);
        },
      );
    }
  }
}
