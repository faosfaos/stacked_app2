import 'package:flutter/material.dart';

class OButtonStyle {
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderStorkeAlign;
  final Color? foregroundColor;
  final Color? textColor;
  final double? fontSize;
  final double? borderWidth;
  final String? text;
  final Widget? icon;
  final bool isBold;

  const OButtonStyle({
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.isBold = false,
    this.borderColor,
    this.borderWidth,
    this.text,
    this.foregroundColor,
    this.borderStorkeAlign,
    this.icon,
  });
}
