import 'package:flutter/material.dart';

import '../core/base/base_button.dart';
import 'button_colors.dart';

class ConfirmButton extends IBaseButton {
  const ConfirmButton({
    super.key,
    super.properties,
    required super.onPressed,
    required super.text,
    super.backgroundColor,
    //super.foregroundColor,
  });
  @override
  Widget? get getIcon => Icon(Icons.check);
  @override
  Color? getBackgroundColor(BuildContext context) =>
      ButtonColors.confirmBackgroundColor;
  @override
  Color? getForegroundColor(BuildContext context) => Colors.white;
}
