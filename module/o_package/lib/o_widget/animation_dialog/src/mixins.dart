import 'package:flutter/material.dart';
import '/o_extensions.dart';
import 'animation_direction.dart';
import 'dialog_action.dart';

mixin MixinAnimation {
  Offset getAnimationOffset(
    AnimationDirection direction, {
    bool reverse = false,
  }) {
    switch (direction) {
      case AnimationDirection.bottom:
        return Offset(0, reverse ? -1 : 1);
      case AnimationDirection.right:
        return Offset(reverse ? -1 : 1, 0);
      case AnimationDirection.left:
        return Offset(reverse ? 1 : -1, 0);
      case AnimationDirection.up:
        return Offset(0, reverse ? 1 : -1);
      case AnimationDirection.none:
        return Offset(0, reverse ? 0 : 0);
    }
  }

  SlideTransition buildSlideTransition({
    required Animation<double> animation,
    required Widget child,
    required AnimationDirection direction,
    required Curve curve,
    required bool reverseExit,
  }) {
    final curved = CurvedAnimation(parent: animation, curve: curve);
    final begin = getAnimationOffset(
      direction,
      reverse: reverseExit && animation.status == AnimationStatus.reverse,
    );
    final tween = Tween<Offset>(begin: begin, end: Offset.zero);
    return SlideTransition(position: tween.animate(curved), child: child);
  }
}

mixin MixinDialogMethod {
  List<DialogAction>? getAction(BuildContext context) => null;
  Widget? getContent(BuildContext context) => null;
  Widget? getTitle(BuildContext context) => null;

  ShapeBorder? getShape(BuildContext context) => context.oShape
      .borderWidth(1.3)
      .gradient(
        LinearGradient(
          colors: [
            Colors.transparent,
            Colors.red,
            Colors.amber,
            Colors.teal,
            Colors.transparent,
          ],
        ),
      )
      .make();
}
