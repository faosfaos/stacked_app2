/* import 'package:flutter/material.dart';
import '/o_package/o_extensions.dart';

import '../../animated_dialog/classes/action_buttons_settings.dart';
import '../mixins/confirmable_mixin.dart';
import 'o_bottom_sheet_inform.dart';

class OBottomSheetConfirm extends OBottomSheetInform with ConfirmableMixin {
  void Function()? onConfirm;
  ActionButtonsSetting? buttonsSettings;

  OBottomSheetConfirm({
    super.title,
    super.titleBackgrundColor,
    super.contentBackgrundColor,
    super.titleSize,
    super.content,
    super.centerContent,
    super.contentHeight,
    super.icon,
    super.showIcon,
    super.titleTextShadow,
    super.isDismissible = false,
    this.buttonsSettings,
    required this.onConfirm,
  });

  @override
  void Function()? get onPressed => onConfirm;

  @override
  Widget? getBottomWidget(context) => confirmButton(
    context: context,
    confirmButton:
        buttonsSettings ??
        ActionButtonsSetting(
          confirmText: "Tamam",
          confirmBackgroundColor: Colors.green,
          confirmTextStyle: TextStyle(color: Colors.white),
        ),
    cancelButton:
        buttonsSettings ??
        ActionButtonsSetting(
          cancelText: "Vazgeç",
          cancelTextStyle: TextStyle(color: Colors.white),
          cancelBackgroundColor: Colors.red,
        ),
  ).pOnly(right: 8, bottom: 4);
}
 */
