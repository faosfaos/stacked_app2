import 'package:flutter/material.dart';

abstract class ButtonColors {
  static const Color deleteBackgroundColor = Colors.red;
  static const Color confirmBackgroundColor = Colors.green;
  static Color cancelBackgroundColor = Colors.pink.shade400;
  static const Color updateBackgroundColor = Colors.purple;
  static Color specialBackgroundColor(BuildContext context) =>
      Theme.of(context).colorScheme.onPrimary;
}
