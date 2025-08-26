/* import 'package:flutter/material.dart';
import 'package:ileri_seviye/o_package/o_extensions.dart';
import 'package:ileri_seviye/o_package/o_widget/factory/button/core/di/dependency_container.dart';
import '../factory/button/core/models/button_properties.dart';
import '../o_form_builder/src/form_builder.dart';

enum DialogType { delete, form, normal }

enum AnimationDirection { left, right, bottom, up, none }

class Style {
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderStorkeAlign;
  final Color? foregroundColor;
  final Color? textColor;
  final double? fontSize;
  final double? borderWidth;
  final String? text;
  final Widget? icon;
  final bool isBold;

  const Style({
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.isBold = false,
    this.borderColor,
    this.borderWidth,
    this.text,
    this.foregroundColor,
    this.borderStorkeAlign,
    this.icon,
  });
}

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
  ShapeBorder? getShape(BuildContext context) =>
      context.oShape
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

class DialogAction {
  final String text;
  final VoidCallback? onPressed;
  final ButtonProperties? properties;
  //final Color? textColor;
  DialogAction({
    required this.text,
    this.onPressed,
    this.properties,
    //this.textColor,
  });
}

class DialogProperties {
  final ShapeBorder? shape;
  final int? transitionDuration;
  final double? height;
  final bool barrierDismissible;
  DialogProperties({
    this.shape,
    this.transitionDuration,
    this.barrierDismissible = true,
    this.height,
  });
}

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
    //this.shape,
    //this.transitionDuration,
  });
  Future<T?> show<T>(BuildContext context) async {
    return await showGeneralDialog(
      context: context,
      barrierDismissible: dialogProperties?.barrierDismissible ?? true,
      barrierLabel: 'Kapat',
      barrierColor: Colors.black54,
      transitionDuration:
          dialogProperties?.transitionDuration == null
              ? Duration(
                milliseconds:
                    animationDirection == AnimationDirection.none ? 0 : 400,
              )
              : Duration(
                milliseconds: dialogProperties?.transitionDuration ?? 0,
              ),
      pageBuilder: (context, animation, secondaryAnimation) {
        return PopScope(
          canPop: dialogProperties?.barrierDismissible ?? true,
          child: Opacity(
            opacity:
                animationDirection == AnimationDirection.none
                    ? animation.value
                    : 1,
            child: AlertDialog(
              shape: dialogProperties?.shape ?? getShape(context),
              title: title ?? getTitle(context),
              content: content ?? getContent(context),
              actions:
                  actions?.map((e) {
                    return oButtonFactory.create(
                      button: ButtonType.normal,
                      text: e.text,
                      onPressed: e.onPressed,
                      properties: e.properties,
                    );
                  }).toList() ??
                  getAction(context)?.map((e) {
                    return oButtonFactory.create(
                      button: ButtonType.normal,
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

class ODeleteDialog extends IDialog {
  ODeleteDialog({
    super.title,
    required this.onConfirm,
    this.deletedItemName,
    super.animationDirection,
    super.actions,
    super.dialogProperties,
    super.animationCurve,
    super.animationReverseExit,
  });
  final VoidCallback? onConfirm;
  final String? deletedItemName;
  @override
  List<DialogAction>? getAction(BuildContext context) {
    return [
      DialogAction(
        text: "Vazgeç",
        properties: ButtonProperties(
          icon: Icon(Icons.cancel),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
      ),
      DialogAction(
        text: "Evet",
        onPressed: onConfirm,
        properties: ButtonProperties(
          icon: Icon(Icons.check),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
      ),
    ];
  }

  @override
  Widget? getContent(BuildContext context) {
    if (deletedItemName != null) {
      return Text(
        "$deletedItemName silinecek, silmek istediğinizden emin misiniz?",
      );
    } else {
      return Text("Silmek istediğinizden emin misiniz?");
    }
  }

  @override
  Widget? getTitle(BuildContext context) {
    return Text("Silme Onayı");
  }
}

class OFormDialog extends IDialog {
  OFormDialog({
    required super.title,
    required this.formFields,
    required this.onConfirm,
    super.animationDirection,
    super.dialogProperties,
    this.topWidget,
    this.bottomWidget,
    this.styleCancelButton,
    this.styleConfirmButton,
    super.animationCurve,
    super.animationReverseExit,
  });
  final Widget? topWidget;
  final Widget? bottomWidget;
  final List<Widget> formFields;
  final void Function(GlobalKey<OFormBuilderState> formKey)? onConfirm;
  final formKey = GlobalKey<OFormBuilderState>();
  final Style? styleCancelButton;
  final Style? styleConfirmButton;
  @override
  Widget? getContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topWidget ?? SizedBox.shrink(),
        OFormBuilder(
          key: formKey,
          child: Column(children: formFields),
        ).oScrollV.make().oSizedBox(height: dialogProperties?.height),
        bottomWidget ?? SizedBox.shrink(),
      ],
    );
  }

  @override
  List<DialogAction>? getAction(BuildContext context) {
    return [
      DialogAction(
        text: styleCancelButton?.text ?? "İptal",
        properties: ButtonProperties(
          icon: styleCancelButton?.icon ?? Icon(Icons.cancel),
          backgroundColor: styleCancelButton?.backgroundColor ?? Colors.red,
          foregroundColor: styleCancelButton?.foregroundColor ?? Colors.white,
          borderColor: styleCancelButton?.borderColor ?? Colors.transparent,
          borderWidth: styleCancelButton?.borderWidth ?? 0,
          borderStrokeAlign: styleCancelButton?.borderStorkeAlign ?? 0,
          fontSize: styleCancelButton?.fontSize,
          isBold: styleCancelButton?.isBold ?? false,
        ),
      ),
      DialogAction(
        text: styleConfirmButton?.text ?? "Tamam",
        onPressed: () {
          if (formKey.currentState?.saveAndValidate() ?? false) {
            onConfirm!(formKey);
            Navigator.pop(context);
          }
        },
        properties: ButtonProperties(
          icon: styleConfirmButton?.icon ?? Icon(Icons.check),
          backgroundColor: styleConfirmButton?.backgroundColor ?? Colors.green,
          foregroundColor: styleConfirmButton?.foregroundColor ?? Colors.white,
        ),
      ),
    ];
  }
}

class NormalDialog extends IDialog {
  NormalDialog({
    required super.title,
    required super.content,
    super.actions,
    required super.animationDirection,
    super.dialogProperties,
    super.animationCurve,
    super.animationReverseExit,
  });
}
 */
/* import 'package:flutter/material.dart';
import 'package:ileri_seviye/o_package/o_extensions.dart';
import 'package:ileri_seviye/o_package/o_widget/factory/button/core/di/dependency_container.dart';
import '../factory/button/core/models/button_properties.dart';
import '../o_form_builder/src/form_builder.dart';

enum DialogType { delete, form, normal }

enum AnimationDirection { left, right, bottom, up, none }

class Style {
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderStorkeAlign;
  final Color? foregroundColor;
  final Color? textColor;
  final double? fontSize;
  final double? borderWidth;
  final String? text;
  final Widget? icon;
  final bool isBold;

  const Style({
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.isBold = false,
    this.borderColor,
    this.borderWidth,
    this.text,
    this.foregroundColor,
    this.borderStorkeAlign,
    this.icon,
  });
}

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
  ShapeBorder? getShape(BuildContext context) =>
      context.oShape
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

class DialogAction {
  final String text;
  final VoidCallback? onPressed;
  final ButtonProperties? properties;

  DialogAction({required this.text, this.onPressed, this.properties});
}

class DialogProperties {
  final ShapeBorder? shape;
  final int? transitionDuration;
  final double? height;
  final bool barrierDismissible;

  DialogProperties({
    this.shape,
    this.transitionDuration,
    this.barrierDismissible = true,
    this.height,
  });
}

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
      transitionDuration:
          dialogProperties?.transitionDuration == null
              ? Duration(
                milliseconds:
                    animationDirection == AnimationDirection.none ? 0 : 400,
              )
              : Duration(
                milliseconds: dialogProperties?.transitionDuration ?? 0,
              ),
      pageBuilder: (context, animation, secondaryAnimation) {
        return PopScope(
          canPop: dialogProperties?.barrierDismissible ?? true,
          child: Opacity(
            opacity:
                animationDirection == AnimationDirection.none
                    ? animation.value
                    : 1,
            child: AlertDialog(
              shape: dialogProperties?.shape ?? getShape(context),
              title: title ?? getTitle(context),
              content: content ?? getContent(context),
              actions:
                  actions?.map((e) {
                    return oButtonFactory.create(
                      button: ButtonType.normal,
                      text: e.text,
                      onPressed: e.onPressed,
                      properties: e.properties,
                    );
                  }).toList() ??
                  getAction(context)?.map((e) {
                    return oButtonFactory.create(
                      button: ButtonType.normal,
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

class ODeleteDialog extends IDialog {
  ODeleteDialog({
    super.title,
    required this.onConfirm,
    this.deletedItemName,
    super.animationDirection,
    super.actions,
    super.dialogProperties,
    super.animationCurve,
    super.animationReverseExit,
  });

  final VoidCallback? onConfirm;
  final String? deletedItemName;

  @override
  List<DialogAction>? getAction(BuildContext context) {
    return [
      DialogAction(
        text: "Vazgeç",
        properties: ButtonProperties(
          icon: Icon(Icons.cancel),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
      ),
      DialogAction(
        text: "Evet",
        onPressed: onConfirm,
        properties: ButtonProperties(
          icon: Icon(Icons.check),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
      ),
    ];
  }

  @override
  Widget? getContent(BuildContext context) {
    if (deletedItemName != null) {
      return Text(
        "$deletedItemName silinecek,\nsilmek istediğinizden emin misiniz?",
      );
    } else {
      return Text("Silmek istediğinizden emin misiniz?");
    }
  }

  @override
  Widget? getTitle(BuildContext context) {
    return Text("Silme Onayı", textAlign: TextAlign.center);
  }
}

class OFormDialog extends IDialog {
  OFormDialog({
    required super.title,
    required this.formFields,
    required this.onConfirm,
    super.animationDirection,
    super.dialogProperties,
    this.topWidget,
    this.bottomWidget,
    this.styleCancelButton,
    this.styleConfirmButton,
    super.animationCurve,
    super.animationReverseExit,
  });

  final Widget? topWidget;
  final Widget? bottomWidget;
  final List<Widget> formFields;
  final void Function(GlobalKey<OFormBuilderState> formKey)? onConfirm;
  final formKey = GlobalKey<OFormBuilderState>();
  final Style? styleCancelButton;
  final Style? styleConfirmButton;

  @override
  Widget? getContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topWidget ?? SizedBox.shrink(),
        OFormBuilder(
          key: formKey,
          child: Column(children: formFields),
        ).oScrollV.make().oSizedBox(height: dialogProperties?.height),
        bottomWidget ?? SizedBox.shrink(),
      ],
    );
  }

  @override
  List<DialogAction>? getAction(BuildContext context) {
    return [
      DialogAction(
        text: styleCancelButton?.text ?? "İptal",
        properties: ButtonProperties(
          icon: styleCancelButton?.icon ?? Icon(Icons.cancel),
          backgroundColor: styleCancelButton?.backgroundColor ?? Colors.red,
          foregroundColor: styleCancelButton?.foregroundColor ?? Colors.white,
          borderColor: styleCancelButton?.borderColor ?? Colors.transparent,
          borderWidth: styleCancelButton?.borderWidth ?? 0,
          borderStrokeAlign: styleCancelButton?.borderStorkeAlign ?? 0,
          fontSize: styleCancelButton?.fontSize,
          isBold: styleCancelButton?.isBold ?? false,
        ),
      ),
      DialogAction(
        text: styleConfirmButton?.text ?? "Tamam",
        onPressed: () {
          if (formKey.currentState?.saveAndValidate() ?? false) {
            onConfirm!(formKey);
            Navigator.pop(context);
          }
        },
        properties: ButtonProperties(
          icon: styleConfirmButton?.icon ?? Icon(Icons.check),
          backgroundColor: styleConfirmButton?.backgroundColor ?? Colors.green,
          foregroundColor: styleConfirmButton?.foregroundColor ?? Colors.white,
        ),
      ),
    ];
  }
}

class NormalDialog extends IDialog {
  NormalDialog({
    required super.title,
    required super.content,
    super.actions,
    required super.animationDirection,
    super.dialogProperties,
    super.animationCurve,
    super.animationReverseExit,
  });
}

// Dialog Factory sınıfı
// ... (önceki kodlar aynı kalacak) ...

class DialogFactory {
  static final DialogFactory _instance = DialogFactory._internal();
  factory DialogFactory() => _instance;
  DialogFactory._internal();

  // Common parameters for all dialogs
  /* IDialog _baseDialog({
    required Widget? title,
    required Widget? content,
    required List<DialogAction>? actions,
    required DialogProperties? dialogProperties,
    required AnimationDirection animationDirection,
    required Curve animationCurve,
    required bool animationReverseExit,
  }) {
    return NormalDialog(
      title: title ?? const SizedBox.shrink(),
      content: content ?? const SizedBox.shrink(),
      actions: actions,
      dialogProperties: dialogProperties,
      animationDirection: animationDirection,
      animationCurve: animationCurve,
      animationReverseExit: animationReverseExit,
    );
  }
 */
  // Delete Dialog - Sadece silme dialoguna özel parametreler
  ODeleteDialog delete({
    String? deletedItemName,
    required VoidCallback onConfirm,
    Widget? title,
    DialogProperties? dialogProperties,
    AnimationDirection animationDirection = AnimationDirection.bottom,
    Curve animationCurve = Curves.easeOutBack,
    bool animationReverseExit = false,
  }) {
    return ODeleteDialog(
      title: title,
      onConfirm: onConfirm,
      deletedItemName: deletedItemName,
      animationDirection: animationDirection,
      dialogProperties: dialogProperties,
      animationCurve: animationCurve,
      animationReverseExit: animationReverseExit,
    );
  }

  // Form Dialog - Sadece form dialoguna özel parametreler
  OFormDialog form({
    required Widget title,
    required List<Widget> formFields,
    required void Function(GlobalKey<OFormBuilderState> formKey) onConfirm,
    Widget? topWidget,
    Widget? bottomWidget,
    Style? styleCancelButton,
    Style? styleConfirmButton,
    DialogProperties? dialogProperties,
    AnimationDirection animationDirection = AnimationDirection.bottom,
    Curve animationCurve = Curves.easeOutBack,
    bool animationReverseExit = false,
  }) {
    return OFormDialog(
      title: title,
      formFields: formFields,
      onConfirm: onConfirm,
      topWidget: topWidget,
      bottomWidget: bottomWidget,
      styleCancelButton: styleCancelButton,
      styleConfirmButton: styleConfirmButton,
      animationDirection: animationDirection,
      dialogProperties: dialogProperties,
      animationCurve: animationCurve,
      animationReverseExit: animationReverseExit,
    );
  }

  // Normal Dialog - Sadece normal dialoga özel parametreler
  NormalDialog simple({
    required Widget title,
    required Widget content,
    List<DialogAction>? actions,
    DialogProperties? dialogProperties,
    AnimationDirection animationDirection = AnimationDirection.bottom,
    Curve animationCurve = Curves.easeOutBack,
    bool animationReverseExit = false,
  }) {
    return NormalDialog(
      title: title,
      content: content,
      actions: actions,
      animationDirection: animationDirection,
      dialogProperties: dialogProperties,
      animationCurve: animationCurve,
      animationReverseExit: animationReverseExit,
    );
  }
}

final oDialog = DialogFactory(); */

//enum DialogType { delete, form, simple }

/* import 'package:flutter/material.dart';
import 'package:ileri_seviye/o_package/o_extensions.dart';
import 'package:ileri_seviye/o_package/o_widget/factory/button/core/di/dependency_container.dart';
import '../factory/button/core/models/button_properties.dart';
import '../o_form_builder/src/form_builder.dart';

enum AnimationDirection { left, right, bottom, up, none }

class Style {
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderStorkeAlign;
  final Color? foregroundColor;
  //final Color? textColor;
  final double? fontSize;
  final double? borderWidth;
  final String? text;
  final Widget? icon;
  final bool isBold;

  const Style({
    this.backgroundColor,
    //this.textColor,
    this.fontSize,
    this.isBold = false,
    this.borderColor,
    this.borderWidth,
    this.text,
    this.foregroundColor,
    this.borderStorkeAlign,
    this.icon,
  });
}

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
  ShapeBorder? getShape(BuildContext context) =>
      context.oShape
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

class DialogAction {
  final String text;
  final VoidCallback? onPressed;
  final ButtonProperties? properties;

  DialogAction({required this.text, this.onPressed, this.properties});
}

class DialogProperties {
  final ShapeBorder? shape;
  final int? transitionDuration;
  final double? height;
  final bool barrierDismissible;

  DialogProperties({
    this.shape,
    this.transitionDuration,
    this.barrierDismissible = true,
    this.height,
  });
}

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
      transitionDuration:
          dialogProperties?.transitionDuration == null
              ? Duration(
                milliseconds:
                    animationDirection == AnimationDirection.none ? 0 : 400,
              )
              : Duration(
                milliseconds: dialogProperties?.transitionDuration ?? 0,
              ),
      pageBuilder: (context, animation, secondaryAnimation) {
        return PopScope(
          canPop: dialogProperties?.barrierDismissible ?? true,
          child: Opacity(
            opacity:
                animationDirection == AnimationDirection.none
                    ? animation.value
                    : 1,
            child: AlertDialog(
              shape: dialogProperties?.shape ?? getShape(context),
              title: title ?? getTitle(context),
              content: content ?? getContent(context),
              actions:
                  actions?.map((e) {
                    return oButtonFactory.create(
                      button: ButtonType.normal,
                      text: e.text,
                      onPressed: e.onPressed,
                      properties: e.properties,
                    );
                  }).toList() ??
                  getAction(context)?.map((e) {
                    return oButtonFactory.create(
                      button: ButtonType.normal,
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

class ODeleteDialog extends IDialog {
  ODeleteDialog({
    super.title,
    required this.onConfirm,
    this.deletedItemName,
    super.animationDirection,
    super.actions,
    super.dialogProperties,
    super.animationCurve,
    super.animationReverseExit,
  });

  final VoidCallback? onConfirm;
  final String? deletedItemName;

  @override
  List<DialogAction>? getAction(BuildContext context) {
    return [
      DialogAction(
        text: "Vazgeç",
        properties: ButtonProperties(
          icon: Icon(Icons.cancel),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
      ),
      DialogAction(
        text: "Evet",
        onPressed: onConfirm,
        properties: ButtonProperties(
          icon: Icon(Icons.check),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
      ),
    ];
  }

  @override
  Widget? getContent(BuildContext context) {
    if (deletedItemName != null) {
      return Text(
        "$deletedItemName silinecek,\nsilmek istediğinizden emin misiniz?",
      );
    } else {
      return Text("Silmek istediğinizden emin misiniz?");
    }
  }

  @override
  Widget? getTitle(BuildContext context) {
    return Text("Silme Onayı", textAlign: TextAlign.center);
  }
}

class Simple extends IDialog {
  Simple({
    required super.title,
    required super.content,
    required super.actions,
    required super.animationDirection,
    super.dialogProperties,
    super.animationCurve,
    super.animationReverseExit,
  });
}

class OFormDialog extends IDialog {
  OFormDialog({
    required super.title,
    required this.formFields,
    required this.onConfirm,
    super.animationDirection,
    super.dialogProperties,
    this.topWidget,
    this.bottomWidget,
    this.styleCancelButton,
    this.styleConfirmButton,
    super.animationCurve,
    super.animationReverseExit,
  });

  final Widget? topWidget;
  final Widget? bottomWidget;
  final List<Widget> formFields;
  final void Function(GlobalKey<OFormBuilderState> formKey)? onConfirm;
  final formKey = GlobalKey<OFormBuilderState>();
  final Style? styleCancelButton;
  final Style? styleConfirmButton;

  @override
  Widget? getContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topWidget ?? SizedBox.shrink(),
        OFormBuilder(
          key: formKey,
          child: Column(children: formFields),
        ).oScrollV.make().oSizedBox(height: dialogProperties?.height),
        bottomWidget ?? SizedBox.shrink(),
      ],
    );
  }

  @override
  List<DialogAction>? getAction(BuildContext context) {
    return [
      DialogAction(
        text: styleCancelButton?.text ?? "İptal",
        properties: ButtonProperties(
          icon: styleCancelButton?.icon ?? Icon(Icons.cancel),
          backgroundColor: styleCancelButton?.backgroundColor ?? Colors.red,
          foregroundColor: styleCancelButton?.foregroundColor ?? Colors.white,
          borderColor: styleCancelButton?.borderColor ?? Colors.transparent,
          borderWidth: styleCancelButton?.borderWidth ?? 0,
          borderStrokeAlign: styleCancelButton?.borderStorkeAlign ?? 0,
          fontSize: styleCancelButton?.fontSize,
          isBold: styleCancelButton?.isBold ?? false,
        ),
      ),
      DialogAction(
        text: styleConfirmButton?.text ?? "Tamam",
        onPressed: () {
          if (formKey.currentState?.saveAndValidate() ?? false) {
            onConfirm!(formKey);
          }
        },
        properties: ButtonProperties(
          icon: styleConfirmButton?.icon ?? Icon(Icons.check),
          backgroundColor: styleConfirmButton?.backgroundColor ?? Colors.green,
          foregroundColor: styleConfirmButton?.foregroundColor ?? Colors.white,
        ),
      ),
    ];
  }
}

// Dialog Factory sınıfı
class DialogFactory {
  static final DialogFactory _instance = DialogFactory._internal();
  factory DialogFactory() => _instance;
  DialogFactory._internal();

  // Delete Dialog - Sadece silme dialoguna özel parametreler
  Future<T?> showDelete<T>({
    required BuildContext context,
    required VoidCallback onConfirm,
    String? deletedItemName,
    Widget? title,
    DialogProperties? dialogProperties,
    AnimationDirection animationDirection = AnimationDirection.bottom,
    Curve animationCurve = Curves.easeOutBack,
    bool animationReverseExit = false,
    List<DialogAction>? actions,
  }) async {
    final dialog = ODeleteDialog(
      title: title,
      onConfirm: onConfirm,
      deletedItemName: deletedItemName,
      animationDirection: animationDirection,
      dialogProperties: dialogProperties,
      animationCurve: animationCurve,
      animationReverseExit: animationReverseExit,
      actions: actions,
    );
    return await dialog.show<T>(context);
  }

  // Form Dialog - Sadece form dialoguna özel parametreler
  Future<T?> showForm<T>({
    required BuildContext context,
    required Widget title,
    required List<Widget> formFields,
    required void Function(GlobalKey<OFormBuilderState> formKey) onConfirm,
    Widget? topWidget,
    Widget? bottomWidget,
    Style? styleCancelButton,
    Style? styleConfirmButton,
    DialogProperties? dialogProperties,
    AnimationDirection animationDirection = AnimationDirection.bottom,
    Curve animationCurve = Curves.easeOutBack,
    bool animationReverseExit = false,
  }) async {
    final dialog = OFormDialog(
      title: title,
      formFields: formFields,
      onConfirm: onConfirm,
      topWidget: topWidget,
      bottomWidget: bottomWidget,
      styleCancelButton: styleCancelButton,
      styleConfirmButton: styleConfirmButton,
      animationDirection: animationDirection,
      dialogProperties: dialogProperties,
      animationCurve: animationCurve,
      animationReverseExit: animationReverseExit,
    );
    return await dialog.show<T>(context);
  }

  // Normal Dialog - Sadece normal dialoga özel parametreler
  Future<T?> showSimple<T>({
    required BuildContext context,
    required Widget title,
    required Widget content,
    required List<DialogAction>? actions,
    DialogProperties? dialogProperties,
    AnimationDirection animationDirection = AnimationDirection.bottom,
    Curve animationCurve = Curves.easeOutBack,
    bool animationReverseExit = false,
  }) async {
    final dialog = Simple(
      title: title,
      content: content,
      actions: actions,
      animationDirection: animationDirection,
      dialogProperties: dialogProperties,
      animationCurve: animationCurve,
      animationReverseExit: animationReverseExit,
    );
    return await dialog.show<T>(context);
  }
}

final oDialog = DialogFactory();
 */
