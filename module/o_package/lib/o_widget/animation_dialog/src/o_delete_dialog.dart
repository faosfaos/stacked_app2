import 'package:flutter/material.dart';
import '../../factory/button/core/models/button_properties.dart';
import 'i_dialog.dart';
import 'dialog_action.dart';

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
        textAlign: TextAlign.center,
      );
    } else {
      return Text(
        "Silmek istediğinizden emin misiniz?",
        textAlign: TextAlign.center,
      );
    }
  }

  @override
  Widget? getTitle(BuildContext context) {
    return Text("Silme Onayı", textAlign: TextAlign.center);
  }
}
