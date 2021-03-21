import 'package:flutter/material.dart';

enum TransitionType {
  defaultTransition,
  slideDown,
  scale,
  slideUp,
  slideLeft,
  slideRight
}

class Transitions<T> extends PageRouteBuilder<T> {
  final TransitionType transitionType;
  final Curve curve;
  final Curve reverseCurve;
  final Duration duration;
  final Widget widget;

  Transitions({this.transitionType,this.curve,this.reverseCurve,this.duration,this.widget}) :super(
    transitionDuration: duration,
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return widget;
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      switch (transitionType) {
         case TransitionType.slideDown:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: const Offset(0.0, 0.0),
            ).animate(animation),
            child: child,
          );
          break;
        case TransitionType.slideUp:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: const Offset(0.0, 0.0),
            ).animate(animation),
            
            child: child,
          );
          break;
        case TransitionType.scale:
          return ScaleTransition(
            scale: animation,
            alignment: Alignment.topRight,
            child: child,
          );
          break;
        case TransitionType.slideLeft:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: const Offset(0.0, 0.0),
            ).animate(animation),
            //).animate(CurvedAnimation(parent: animation,curve: curve, reverseCurve: reverseCurve)),
            child: child,
          );
          break;
        case TransitionType.slideRight:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: const Offset(0.0, 0.0),
            ).animate(animation),
            child: child,
          );
          break;
        default:
          return child;
      }
    }
  );
}

