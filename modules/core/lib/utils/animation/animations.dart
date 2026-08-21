import 'package:flutter/material.dart';

 class AppAnimations {
   AppAnimations._();

  static AnimatedBuilder flipAnimation(Animation<double> animation, Widget child) {
    const begin = 1.0;
    const end = 0.0;
    const curve = Curves.easeInOut;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var rotationAnimation = animation.drive(tween);

    return AnimatedBuilder(
      animation: rotationAnimation,
      child: child,
      builder: (context, child) {
        final angle =
            rotationAnimation.value * 3.14159; // 3.14159 radians = 180 degrees
        return Transform(
          transform: Matrix4.rotationY(angle),
          alignment: Alignment.center,
          child: child,
        );
      },
    );
  }

 static SlideTransition slideAnimation(Animation<double> animation, Widget child) {
    const begin = Offset(2.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    final offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }

 // static ScaleTransition scaleAnimation(Animation<double> animation, Widget child) {
 //    const begin = 4.0;
 //    const end = 1.0;
 //    const curve = Curves.ease;
 //
 //    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
 //    final scaleAnimation = animation.drive(tween);
 //
 //    return ScaleTransition(
 //      scale: scaleAnimation,
 //      child: child,
 //    );
 //  }
}
