import 'package:flutter/material.dart';

class OFloatinActionButton {
  final Widget _child;

  bool _autofocus = false;
  Color? _backgroundColor;
  String? _tooltip;

  double? _elevation;

  OFloatinActionButton get autofocus => (_autofocus = true, this).$2;
  OFloatinActionButton backgroundColor(Color color) =>
      (_backgroundColor = color, this).$2;
  OFloatinActionButton tooltip(String tooltip) => (_tooltip = tooltip, this).$2;
  OFloatinActionButton elevation(double elevation) =>
      (_elevation = elevation, this).$2;
  void Function()? _onPressed = () {};
  OFloatinActionButton onPressed(void Function()? onPressed) =>
      (_onPressed = onPressed, this).$2;
  OFloatinActionButton(this._child);
  FloatingActionButton make({Key? key, Object? heroTag}) {
    return FloatingActionButton(
      key: key,
      heroTag: heroTag,
      onPressed: _onPressed,
      autofocus: _autofocus,
      backgroundColor: _backgroundColor,
      tooltip: _tooltip,
      elevation: _elevation,
      child: _child,
    );
  }
}

/*class MyFloatinActionButton {
  final Widget _child;

  bool _autofocus = false;
  Color? _backgroundColor;
  String? _tooltip;

  double? _elevation;

  MyFloatinActionButton get autofocus => (_autofocus = true, this).$2;
  MyFloatinActionButton backgroundColor(Color color) =>
      (_backgroundColor = color, this).$2;
  MyFloatinActionButton tooltip(String tooltip) =>
      (_tooltip = tooltip, this).$2;
  MyFloatinActionButton elevation(double elevation) =>
      (_elevation = elevation, this).$2;

  MyFloatinActionButton(this._child);
  FloatingActionButton make({Key? key, required void Function()? onPressed}) {
    return FloatingActionButton(
      key: key,
      onPressed: onPressed,
      autofocus: _autofocus,
      backgroundColor: _backgroundColor,
      tooltip: _tooltip,
      elevation: _elevation,
      child: _child,
    );
  }
}*/
