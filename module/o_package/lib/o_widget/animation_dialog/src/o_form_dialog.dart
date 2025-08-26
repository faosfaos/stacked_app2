import 'package:flutter/material.dart';
import '/o_extensions.dart';
import '../../factory/button/core/models/button_properties.dart';
import 'i_dialog.dart';
import 'dialog_action.dart';
import 'style.dart';
import '../../o_form_builder/src/form_builder.dart';

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
