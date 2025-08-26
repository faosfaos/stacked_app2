import 'package:flutter/material.dart';
import '../core/base/base_button.dart';
import 'button_colors.dart';

class CancelButton extends IBaseButton {
  const CancelButton({
    super.key,
    super.properties,
    required super.onPressed,
    required super.text,
    super.backgroundColor,
    //super.foregroundColor,
  });
  @override
  Widget? get getIcon => Icon(Icons.cancel);
  @override
  Color? getBackgroundColor(BuildContext context) =>
      ButtonColors.cancelBackgroundColor;
  @override
  Color? getForegroundColor(BuildContext context) => Colors.white;
}
