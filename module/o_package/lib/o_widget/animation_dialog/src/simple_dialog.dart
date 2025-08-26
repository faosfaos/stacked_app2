import 'i_dialog.dart';

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
