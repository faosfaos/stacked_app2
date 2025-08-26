import 'package:flutter/material.dart';
import '../../widgets/cancel_button.dart';
import '../../widgets/confirm_button.dart';
import '../../widgets/delete_button.dart';
import '../../widgets/special_button.dart';
import '../../widgets/update_button.dart';

import '../base/base_button.dart';
import '../base/button_factory.dart';
import '../di/dependency_container.dart';

import '../models/button_properties.dart';

class ButtonFactory extends IButtonFactory {
  @override
  IBaseButton create({
    required ButtonType button,
    required String text,
    required VoidCallback? onPressed,
    Key? key,
    Color? backgroundColor,
    ButtonProperties? properties,
  }) {
    //ButtonProperties? finalProperties = properties;
    switch (button) {
      case ButtonType.delete:
        return DeleteButton(
          key: key,
          onPressed: onPressed,
          text: text,
          backgroundColor: backgroundColor,
          properties: properties,
        );
      case ButtonType.confirm:
        return ConfirmButton(
          key: key,
          onPressed: onPressed,
          text: text,
          backgroundColor: backgroundColor,
          properties: properties,
        );
      case ButtonType.cancel:
        //finalProperties = ButtonProperties();
        return CancelButton(
          key: key,
          onPressed: onPressed,
          text: text,
          backgroundColor: backgroundColor,
          properties: properties,
        );
      case ButtonType.update:
        // finalProperties = ButtonProperties();
        return UpdateButton(
          key: key,
          onPressed: onPressed,
          text: text,
          backgroundColor: backgroundColor,
          properties: properties,
        );
      case ButtonType.standard:
        return Standard(
          key: key,
          onPressed: onPressed,
          text: text,
          backgroundColor: backgroundColor,
          properties: properties,
        );
    }
  }
}
