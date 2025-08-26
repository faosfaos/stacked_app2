import 'package:flutter/material.dart';
import '/o_extensions.dart';
import '/o_widget/factory/button/core/mixins/button_mixin.dart';
import '/o_widget/factory/button/core/models/button_properties.dart';
import '/o_widget/factory/button/core/util/wspa.dart';

abstract class IBaseButton extends StatelessWidget with ButtonMixin {
  const IBaseButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.properties,
    this.backgroundColor,
    this.foregroundColor,
  });
  final VoidCallback? onPressed;
  final String text;
  final ButtonProperties? properties;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: properties?.height,
      width: properties?.width,
      child: ElevatedButton.icon(
        icon: properties?.icon ?? getIcon,
        iconAlignment: properties?.iconEnd == true
            ? IconAlignment.end
            : IconAlignment.start,
        onPressed: onPressed,
        label: Text(
          text,
          style: TextStyle(
            color:
                properties?.foregroundColor ??
                (getForegroundColor(context) ?? context.themePrimaryColor),
          ),
        ),
        key: key,
        style: ButtonStyle(
          textStyle: wspAll(
            TextStyle(
              fontSize: properties?.fontSize,
              fontWeight: properties?.isBold == true
                  ? FontWeight.bold
                  : FontWeight.w500,
            ),
          ),

          foregroundColor: wspAll(properties?.foregroundColor ?? Colors.white),
          backgroundColor: wspAll(
            properties?.backgroundColor ??
                (backgroundColor ?? getBackgroundColor(context)),
          ),
          shadowColor: wspAll(
            properties?.shadowColor ?? Theme.of(context).colorScheme.onPrimary,
          ),

          elevation: wspAll(properties?.elevation ?? (isDark ? 0 : 2)),
          padding: wspAll(properties?.padding),
          side: wspAll(
            BorderSide(
              color: properties?.borderColor ?? Colors.transparent,
              width: properties?.borderWidth ?? 0,
              strokeAlign: properties?.borderStrokeAlign ?? 0,
            ),
          ),
          overlayColor: wspAll(
            properties?.overlayColor ?? getOverlayColor(context),
          ),
          shape: wspAll(
            RoundedRectangleBorder(
              borderRadius:
                  properties?.borderRadiusGeometry ??
                  (BorderRadius.circular(properties?.borderRadius ?? 24)),
            ),
          ),
          fixedSize: wspAll(properties?.fixedSize),
          maximumSize: wspAll(properties?.maximumSize),
          minimumSize: wspAll(properties?.minimumSize),
          visualDensity: properties?.visualDensity,
          tapTargetSize: properties?.tapTargetSize,
          mouseCursor: wspAll(properties?.mouseCursor),
          surfaceTintColor: wspAll(properties?.surfaceTintColor),
        ),
      ),
    );
  }
}
