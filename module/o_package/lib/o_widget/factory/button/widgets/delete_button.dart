import 'package:flutter/material.dart';
import '../core/base/base_button.dart';
import 'button_colors.dart';

class DeleteButton extends IBaseButton {
  const DeleteButton({
    super.key,
    super.properties,
    required super.onPressed,
    required super.text,
    super.backgroundColor,
    //super.foregroundColor,
  });
  @override
  Widget? get getIcon => Icon(Icons.delete_forever);

  @override
  Color? getBackgroundColor(BuildContext context) =>
      ButtonColors.deleteBackgroundColor;
  @override
  Color? getForegroundColor(BuildContext context) => Colors.white;
}
