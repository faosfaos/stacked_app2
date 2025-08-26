import 'package:flutter/material.dart';

import '../di/dependency_container.dart';
//import '../enums/button_type.dart';
import '../models/button_properties.dart';
import 'base_button.dart';

abstract class IButtonFactory {
  IBaseButton create({
    required ButtonType button,
    required String text,
    required VoidCallback? onPressed,
    Color? backgroundColor,
    ButtonProperties? properties,
  });
}
