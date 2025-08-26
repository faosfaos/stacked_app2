import 'package:flutter/material.dart';
import 'dialog_action.dart';
import 'dialog_properties.dart';
import 'o_delete_dialog.dart';
import 'simple_dialog.dart';
import 'o_form_dialog.dart';
import 'style.dart';
import 'animation_direction.dart';
import '../../o_form_builder/src/form_builder.dart';

class DialogFactory {
  static final DialogFactory _instance = DialogFactory._internal();
  factory DialogFactory() => _instance;
  DialogFactory._internal();

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

  Future<T?> showSimple<T>({
    required BuildContext context,
    required Widget? title,
    required Widget? content,
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
