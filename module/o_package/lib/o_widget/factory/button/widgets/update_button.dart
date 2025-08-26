import 'package:flutter/material.dart';

import '../core/base/base_button.dart';
import 'button_colors.dart';

class UpdateButton extends IBaseButton {
  const UpdateButton({
    super.key,
    super.properties,
    required super.onPressed,
    required super.text,
    super.backgroundColor,
    //super.foregroundColor,
  });
  @override
  Widget? get getIcon => Icon(Icons.update);
  @override
  Color? getBackgroundColor(BuildContext context) =>
      ButtonColors.updateBackgroundColor;
  @override
  Color? getForegroundColor(BuildContext context) => Colors.white;
}
