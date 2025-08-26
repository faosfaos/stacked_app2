/* import 'package:flutter/material.dart';
import '/o_package/o_extensions.dart';
import '../../animated_dialog/classes/action_buttons_settings.dart';

mixin ConfirmableMixin {
  void Function()? onPressed;

  Widget confirmButton({
    required BuildContext context,
    required ActionButtonsSetting confirmButton,
    required ActionButtonsSetting cancelButton,
  }) =>
      [
        Divider(endIndent: 8, indent: 8, height: 0),
        [
          //Cancel
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: cancelButton.cancelBackgroundColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child:
                cancelButton.cancelText?.oText.bold
                    .color(cancelButton.cancelTextStyle?.color)
                    .size(cancelButton.cancelTextStyle?.fontSize)
                    .center
                    .make(),
          ).oBox.centerRight.make().pOnly(right: 12, top: 8),
          //Confirm
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: confirmButton.confirmBackgroundColor,
            ),
            onPressed: onPressed,
            child:
                confirmButton.confirmText?.oText
                    .color(confirmButton.confirmTextStyle?.color)
                    .size(confirmButton.confirmTextStyle?.fontSize)
                    .center
                    .make(),
          ).oBox.centerRight.make().pOnly(right: 12, top: 8),
        ].oRow.mainAxisEnd.make().pOnly(bottom: 16),
      ].oColumn.make();
}
 */
