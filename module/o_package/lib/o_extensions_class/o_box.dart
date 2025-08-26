// ignore_for_file: unused_field

import 'package:flutter/material.dart';

class OBox {
  Widget child;

  OBox(this.child);

  AlignmentGeometry? _setAlignment;
  void Function()? _onTap;
  void Function()? _onDoubleTap;
  void Function()? _onLongPress;

  OBox get center => (_setAlignment = Alignment.center, this).$2;
  BoxShape _shape = BoxShape.rectangle;

  OBox shape(BoxShape shape) {
    _shape = shape;
    return this;
  }

  OBox get centerLeft {
    _setAlignment = Alignment.centerLeft;
    return this;
  }

  OBox get centerRight {
    _setAlignment = Alignment.centerRight;
    return this;
  }

  OBox get topCenter {
    _setAlignment = Alignment.topCenter;
    return this;
  }

  OBox get topLeft {
    _setAlignment = Alignment.topLeft;
    return this;
  }

  OBox get topRight {
    _setAlignment = Alignment.topRight;
    return this;
  }

  OBox get bottomCenter {
    _setAlignment = Alignment.bottomCenter;
    return this;
  }

  OBox get bottomLeft {
    _setAlignment = Alignment.bottomLeft;
    return this;
  }

  OBox get bottomRight {
    _setAlignment = Alignment.bottomRight;
    return this;
  }

  double? _height;
  double? _width;

  OBox height(double? value) => (_height = value, this).$2;

  OBox width(double? value) => (_width = value, this).$2;

  OBox size({required double width, required double height}) =>
      (_height = height, _width = width, this).$3;

  BoxConstraints? _constraints;

  OBox constraints(BoxConstraints value) {
    _constraints = value;
    return this;
  }

  Clip _clipBehavior = Clip.none;

  OBox clipBehavior(Clip value) {
    _clipBehavior = value;
    return this;
  }

  BoxBorder? _border;

  OBox border({
    Color? color = const Color(0xFF000000),
    BorderStyle style = BorderStyle.solid,
    double width = 1,
    double strokeAlign = BorderSide.strokeAlignInside,
  }) {
    _border = Border.all(
      color: color ?? const Color(0xFF000000),
      style: style,
      width: width,
      strokeAlign: strokeAlign,
    );
    return this;
  }

  BorderRadiusGeometry? _selectborderRadius;

  OBox get circle {
    _selectborderRadius = BorderRadius.circular(360);
    return this;
  }

  OBox radiusAll(double value) {
    _selectborderRadius = BorderRadius.all(Radius.circular(value));
    return this;
  }

  OBox radiusOnly({
    double topLeft = 0,
    double topRight = 0,
    double bottomRight = 0,
    double bottomLeft = 0,
  }) {
    _selectborderRadius = BorderRadius.only(
      topLeft: Radius.circular(topLeft),
      topRight: Radius.circular(topRight),
      bottomRight: Radius.circular(bottomRight),
      bottomLeft: Radius.circular(bottomLeft),
    );
    return this;
  }

  BlendMode? _backgroundBlendMode;

  OBox backgroundBlendMode(BlendMode backgroundBlendMode) {
    _backgroundBlendMode = backgroundBlendMode;
    return this;
  }

  Color? _bgColor;

  OBox color(Color? color) {
    _bgColor = color;
    return this;
  }

  List<BoxShadow>? _boxShadow;

  OBox boxShadow(List<BoxShadow>? boxShadow) {
    _boxShadow = boxShadow;
    return this;
  }

  EdgeInsets? _padding;
  EdgeInsets? _margin;

  OBox get p4 => (_padding = const EdgeInsets.all(4), this).$2;

  OBox get p6 => (_padding = const EdgeInsets.all(6), this).$2;

  OBox get p8 => (_padding = const EdgeInsets.all(8), this).$2;

  OBox get p10 => (_padding = const EdgeInsets.all(10), this).$2;

  OBox get p12 => (_padding = const EdgeInsets.all(12), this).$2;

  OBox get p14 => (_padding = const EdgeInsets.all(14), this).$2;

  OBox get p16 => (_padding = const EdgeInsets.all(16), this).$2;

  OBox get p18 => (_padding = const EdgeInsets.all(18), this).$2;

  OBox get p20 => (_padding = const EdgeInsets.all(20), this).$2;

  OBox get p22 => (_padding = const EdgeInsets.all(22), this).$2;

  OBox get p24 => (_padding = const EdgeInsets.all(24), this).$2;

  OBox get m4 => (_margin = const EdgeInsets.all(4), this).$2;

  OBox get m6 => (_margin = const EdgeInsets.all(6), this).$2;

  OBox get m8 => (_margin = const EdgeInsets.all(8), this).$2;

  OBox get m10 => (_margin = const EdgeInsets.all(10), this).$2;

  OBox get m12 => (_margin = const EdgeInsets.all(12), this).$2;

  OBox get m14 => (_margin = const EdgeInsets.all(14), this).$2;

  OBox get m16 => (_margin = const EdgeInsets.all(16), this).$2;

  OBox get m18 => (_margin = const EdgeInsets.all(18), this).$2;

  OBox get m20 => (_margin = const EdgeInsets.all(20), this).$2;

  OBox get m22 => (_margin = const EdgeInsets.all(22), this).$2;

  OBox get m24 => (_margin = const EdgeInsets.all(24), this).$2;

  OBox get px4 =>
      (_padding = const EdgeInsets.symmetric(horizontal: 4), this).$2;

  OBox get px6 =>
      (_padding = const EdgeInsets.symmetric(horizontal: 6), this).$2;

  OBox get px8 =>
      (_padding = const EdgeInsets.symmetric(horizontal: 8), this).$2;

  OBox get px10 =>
      (_padding = const EdgeInsets.symmetric(horizontal: 10), this).$2;

  OBox get px12 =>
      (_padding = const EdgeInsets.symmetric(horizontal: 12), this).$2;

  OBox get px14 =>
      (_padding = const EdgeInsets.symmetric(horizontal: 14), this).$2;

  OBox get px16 =>
      (_padding = const EdgeInsets.symmetric(horizontal: 16), this).$2;

  OBox get px18 =>
      (_padding = const EdgeInsets.symmetric(horizontal: 18), this).$2;

  OBox get px20 =>
      (_padding = const EdgeInsets.symmetric(horizontal: 20), this).$2;

  OBox get px22 =>
      (_padding = const EdgeInsets.symmetric(horizontal: 22), this).$2;

  OBox get px24 =>
      (_padding = const EdgeInsets.symmetric(horizontal: 24), this).$2;

  OBox get py4 => (_padding = const EdgeInsets.symmetric(vertical: 4), this).$2;

  OBox get py6 => (_padding = const EdgeInsets.symmetric(vertical: 6), this).$2;

  OBox get py8 => (_padding = const EdgeInsets.symmetric(vertical: 8), this).$2;

  OBox get py10 =>
      (_padding = const EdgeInsets.symmetric(vertical: 10), this).$2;

  OBox get py12 =>
      (_padding = const EdgeInsets.symmetric(vertical: 12), this).$2;

  OBox get py14 =>
      (_padding = const EdgeInsets.symmetric(vertical: 14), this).$2;

  OBox get py16 =>
      (_padding = const EdgeInsets.symmetric(vertical: 16), this).$2;

  OBox get py18 =>
      (_padding = const EdgeInsets.symmetric(vertical: 18), this).$2;

  OBox get py20 =>
      (_padding = const EdgeInsets.symmetric(vertical: 20), this).$2;

  OBox get py22 =>
      (_padding = const EdgeInsets.symmetric(vertical: 22), this).$2;

  OBox get py24 =>
      (_padding = const EdgeInsets.symmetric(vertical: 24), this).$2;

  OBox get mx4 =>
      (_margin = const EdgeInsets.symmetric(horizontal: 4), this).$2;

  OBox get mx6 =>
      (_margin = const EdgeInsets.symmetric(horizontal: 6), this).$2;

  OBox get mx8 =>
      (_margin = const EdgeInsets.symmetric(horizontal: 8), this).$2;

  OBox get mx10 =>
      (_margin = const EdgeInsets.symmetric(horizontal: 10), this).$2;

  OBox get mx12 =>
      (_margin = const EdgeInsets.symmetric(horizontal: 12), this).$2;

  OBox get mx14 =>
      (_margin = const EdgeInsets.symmetric(horizontal: 14), this).$2;

  OBox get mx16 =>
      (_margin = const EdgeInsets.symmetric(horizontal: 16), this).$2;

  OBox get mx18 =>
      (_margin = const EdgeInsets.symmetric(horizontal: 18), this).$2;

  OBox get mx20 =>
      (_margin = const EdgeInsets.symmetric(horizontal: 20), this).$2;

  OBox get mx22 =>
      (_margin = const EdgeInsets.symmetric(horizontal: 22), this).$2;

  OBox get mx24 =>
      (_margin = const EdgeInsets.symmetric(horizontal: 24), this).$2;

  OBox get my4 => (_margin = const EdgeInsets.symmetric(vertical: 4), this).$2;

  OBox get my6 => (_margin = const EdgeInsets.symmetric(vertical: 6), this).$2;

  OBox get my8 => (_margin = const EdgeInsets.symmetric(vertical: 8), this).$2;

  OBox get my10 =>
      (_margin = const EdgeInsets.symmetric(vertical: 10), this).$2;

  OBox get my12 =>
      (_margin = const EdgeInsets.symmetric(vertical: 12), this).$2;

  OBox get my14 =>
      (_margin = const EdgeInsets.symmetric(vertical: 14), this).$2;

  OBox get my16 =>
      (_margin = const EdgeInsets.symmetric(vertical: 16), this).$2;

  OBox get my18 =>
      (_margin = const EdgeInsets.symmetric(vertical: 18), this).$2;

  OBox get my20 =>
      (_margin = const EdgeInsets.symmetric(vertical: 20), this).$2;

  OBox get my22 =>
      (_margin = const EdgeInsets.symmetric(vertical: 22), this).$2;

  OBox get my24 =>
      (_margin = const EdgeInsets.symmetric(vertical: 24), this).$2;

  OBox p(double value) => (_padding = EdgeInsets.all(value), this).$2;

  OBox px(double value) =>
      (_padding = EdgeInsets.symmetric(horizontal: value), this).$2;

  OBox py(double value) =>
      (_padding = EdgeInsets.symmetric(vertical: value), this).$2;

  OBox m(double value) => (_margin = EdgeInsets.all(value), this).$2;

  OBox mSymmetric(double? horizontal, double? vertical) => (
    _margin = EdgeInsets.symmetric(
      horizontal: horizontal ?? 0.0,
      vertical: vertical ?? 0.0,
    ),
    this,
  ).$2;

  OBox onLongPress(void Function()? onLongPress) {
    _onLongPress = onLongPress;
    return this;
  }

  OBox onDoubleTap(void Function()? onDoubleTap) {
    _onDoubleTap = onDoubleTap;
    return this;
  }

  OBox onTap(void Function()? onTap) {
    _onTap = onTap;
    return this;
  }

  OBox pOnly({
    double left = 0,
    double right = 0,
    double bottom = 0,
    double top = 0,
  }) => (
    _padding = EdgeInsets.only(
      left: left,
      right: right,
      bottom: bottom,
      top: top,
    ),
    this,
  ).$2;

  OBox mOnly({
    double left = 0,
    double right = 0,
    double bottom = 0,
    double top = 0,
  }) => (
    _margin = EdgeInsets.only(
      left: left,
      right: right,
      bottom: bottom,
      top: top,
    ),
    this,
  ).$2;

  Gradient? _gradient;

  OBox gradientLinear(List<Color> colors) =>
      (_gradient = LinearGradient(colors: colors), this).$2;

  OBox gradientRadial(List<Color> colors) =>
      (_gradient = RadialGradient(colors: colors), this).$2;

  OBox gradienSweep(List<Color> colors) =>
      (_gradient = SweepGradient(colors: colors), this).$2;
  DecorationImage? _image;

  OBox imageDecoration(DecorationImage image) => (_image = image, this).$2;

  Widget make({Key? key}) {
    return GestureDetector(
      onTap: _onTap,
      onDoubleTap: _onDoubleTap,
      onLongPress: _onLongPress,
      child: Container(
        margin: _margin ?? const EdgeInsets.all(0),
        padding: _padding ?? const EdgeInsets.all(0),
        key: key,
        //color: _color,
        alignment: _setAlignment,
        height: _height,
        width: _width,
        constraints: _constraints,
        clipBehavior: _clipBehavior,
        decoration: BoxDecoration(
          color: _bgColor,
          border: _border,
          borderRadius: _selectborderRadius,
          backgroundBlendMode: _backgroundBlendMode,
          boxShadow: _boxShadow,
          gradient: _gradient,
          image: _image,
        ),
        child: child,
      ),
    );
  }
}
