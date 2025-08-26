import 'package:flutter/material.dart';

extension OAlign on Widget {}

class OAlignBuilder {
  Widget child;
  AlignmentGeometry? _alignment;
  double? _widthFactor;
  double? _heightFactor;
  EdgeInsetsGeometry? _padding;

  OAlignBuilder({required this.child}) {
    // Varsayılan alignment: centerLeft
    _alignment = Alignment.center;
  }

  OAlignBuilder get bottomCenter =>
      (_alignment = AlignmentDirectional.bottomCenter, this).$2;
  OAlignBuilder get bottomEnd =>
      (_alignment = AlignmentDirectional.bottomEnd, this).$2;
  OAlignBuilder get bottomStart =>
      (_alignment = AlignmentDirectional.bottomStart, this).$2;
  OAlignBuilder get center =>
      (_alignment = AlignmentDirectional.center, this).$2;
  OAlignBuilder get centerEnd =>
      (_alignment = AlignmentDirectional.centerEnd, this).$2;
  OAlignBuilder get centerStart =>
      (_alignment = AlignmentDirectional.centerStart, this).$2;
  OAlignBuilder get topCenter =>
      (_alignment = AlignmentDirectional.topCenter, this).$2;
  OAlignBuilder get topEnd =>
      (_alignment = AlignmentDirectional.topEnd, this).$2;
  OAlignBuilder get topStart =>
      (_alignment = AlignmentDirectional.topStart, this).$2;

  OAlignBuilder widthFactor(double? value) {
    _widthFactor = value;
    return this;
  }

  OAlignBuilder heightFactor(double? value) {
    _heightFactor = value;
    return this;
  }

  OAlignBuilder padding(EdgeInsetsGeometry? value) {
    _padding = value;
    return this;
  }

  Widget make({Key? key}) {
    Widget widget = Align(
      key: key,
      alignment: _alignment!,
      widthFactor: _widthFactor,
      heightFactor: _heightFactor,
      child: child,
    );

    if (_padding != null) {
      widget = Padding(padding: _padding!, child: widget);
    }

    return widget;
  }
}
