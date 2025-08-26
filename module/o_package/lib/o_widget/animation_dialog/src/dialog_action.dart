import 'package:flutter/material.dart';

import '../../factory/button/core/models/button_properties.dart';

class DialogAction {
  final String text;
  final VoidCallback? onPressed;
  final ButtonProperties? properties;

  DialogAction({required this.text, this.onPressed, this.properties});
}
