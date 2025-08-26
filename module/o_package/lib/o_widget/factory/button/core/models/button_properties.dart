import 'package:flutter/material.dart';

class ButtonProperties {
  final Widget? icon;
  final double? fontSize;
  final double? elevation;
  final double? height;
  final double? width;
  final double? borderWidth;
  final double? borderStrokeAlign;
  final double? borderRadius;
  final bool isBold;
  final bool iconEnd;
  final Color? foregroundColor;
  final Color? overlayColor;
  final Color? backgroundColor;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final Color? borderColor;
  final Size? fixedSize;
  final Size? maximumSize;
  final Size? minimumSize;
  final EdgeInsetsGeometry? padding;
  final VisualDensity? visualDensity;
  final MaterialTapTargetSize? tapTargetSize;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final MouseCursor? mouseCursor;

  ButtonProperties({
    this.icon,
    this.fontSize,
    this.isBold = false,
    this.iconEnd = false,
    this.foregroundColor,
    this.overlayColor,
    this.backgroundColor,
    this.elevation,
    this.shadowColor,
    this.padding,
    this.height,
    this.width,
    this.borderColor,
    this.borderWidth,
    this.borderStrokeAlign,
    this.borderRadiusGeometry,
    this.borderRadius,
    this.fixedSize,
    this.maximumSize,
    this.minimumSize,
    this.visualDensity,
    this.tapTargetSize,
    this.mouseCursor,
    this.surfaceTintColor,
  });
}
