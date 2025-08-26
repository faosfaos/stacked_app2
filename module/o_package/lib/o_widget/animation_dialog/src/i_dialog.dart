import 'package:flutter/material.dart';
import 'animation_direction.dart';
import 'mixins.dart';
import 'dialog_action.dart';
import 'dialog_properties.dart';
import '../../factory/button/core/di/dependency_container.dart';

abstract class IDialog with MixinAnimation, MixinDialogMethod {
  final Widget? title;
  final Widget? content;
  final DialogProperties? dialogProperties;
  final List<DialogAction>? actions;
  final AnimationDirection animationDirection;
  final Curve animationCurve;
  final bool animationReverseExit;

  IDialog({
    this.dialogProperties,
    this.title,
    this.actions,
    this.animationDirection = AnimationDirection.bottom,
    this.animationCurve = Curves.easeOutBack,
    this.content,
    this.animationReverseExit = false,
  });

  Future<T?> show<T>(BuildContext context) async {
    return await showGeneralDialog(
      context: context,
      barrierDismissible: dialogProperties?.barrierDismissible ?? true,
      barrierLabel: 'Kapat',
      barrierColor: Colors.black54,
      transitionDuration: dialogProperties?.transitionDuration == null
          ? Duration(
              milliseconds: animationDirection == AnimationDirection.none
                  ? 0
                  : 400,
            )
          : Duration(milliseconds: dialogProperties?.transitionDuration ?? 0),
      pageBuilder: (context, animation, secondaryAnimation) {
        return PopScope(
          canPop: dialogProperties?.barrierDismissible ?? true,
          child: Opacity(
            opacity: animationDirection == AnimationDirection.none
                ? animation.value
                : 1,
            child: AlertDialog(
              shape: dialogProperties?.shape ?? getShape(context),
              title: title ?? getTitle(context),
              content: content ?? getContent(context),
              actions:
                  actions?.map((e) {
                    return oButton.create(
                      button: ButtonType.standard,
                      text: e.text,
                      onPressed: e.onPressed,
                      properties: e.properties,
                    );
                  }).toList() ??
                  getAction(context)?.map((e) {
                    return oButton.create(
                      button: ButtonType.standard,
                      text: e.text,
                      properties: e.properties,
                      onPressed: e.onPressed ?? () => Navigator.pop(context),
                    );
                  }).toList(),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return buildSlideTransition(
          animation: anim1,
          child: child,
          direction: animationDirection,
          curve: animationCurve,
          reverseExit: animationReverseExit,
        );
      },
    );
  }
}
