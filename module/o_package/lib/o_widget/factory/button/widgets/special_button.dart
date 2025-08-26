import 'package:flutter/material.dart';
import '/o_extensions.dart';

import '../core/base/base_button.dart';

class Standard extends IBaseButton {
  const Standard({
    super.key,
    super.properties,
    required super.onPressed,
    required super.text,
    super.backgroundColor,
    //super.foregroundColor,
  });

  @override
  Color? getBackgroundColor(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceContainerLow;
  @override
  Color? getForegroundColor(BuildContext context) => context.themePrimaryColor;
}
