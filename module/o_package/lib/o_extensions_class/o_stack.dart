import 'package:flutter/material.dart';

class OStackH {
  final List<Widget> _child;

  OStackH(this._child);

  VerticalDirection _verticalDirection = VerticalDirection.down;
  CrossAxisAlignment _crossAxisAlignment = CrossAxisAlignment.center;
  MainAxisAlignment _mainAxisAlignment = MainAxisAlignment.start;
  MainAxisSize _mainAxisSize = MainAxisSize.max;

  OStackH get mainAxisSizeMax => (_mainAxisSize = MainAxisSize.max, this).$2;

  OStackH get mainAxisSizeMin => (_mainAxisSize = MainAxisSize.min, this).$2;

  OStackH get down => (_verticalDirection = VerticalDirection.down, this).$2;

  OStackH get up => (_verticalDirection = VerticalDirection.up, this).$2;

  OStackH get crossAxisCenter =>
      (_crossAxisAlignment = CrossAxisAlignment.center, this).$2;

  OStackH get crossAxisbaseline =>
      (_crossAxisAlignment = CrossAxisAlignment.baseline, this).$2;

  OStackH get crossAxisEnd =>
      (_crossAxisAlignment = CrossAxisAlignment.end, this).$2;

  OStackH get crossAxisStart =>
      (_crossAxisAlignment = CrossAxisAlignment.start, this).$2;

  OStackH get crossAxisStretch =>
      (_crossAxisAlignment = CrossAxisAlignment.stretch, this).$2;

  OStackH get mainAxisCenter =>
      (_mainAxisAlignment = MainAxisAlignment.center, this).$2;

  OStackH get mainAxisEnd =>
      (_mainAxisAlignment = MainAxisAlignment.end, this).$2;

  OStackH get mainAxisSpaceAround =>
      (_mainAxisAlignment = MainAxisAlignment.spaceAround, this).$2;

  OStackH get mainAxisSpaceBetween =>
      (_mainAxisAlignment = MainAxisAlignment.spaceBetween, this).$2;

  OStackH get mainAxisSpaceEvenly =>
      (_mainAxisAlignment = MainAxisAlignment.spaceEvenly, this).$2;

  OStackH get mainAxisStart =>
      (_mainAxisAlignment = MainAxisAlignment.start, this).$2;
  double? _width;
  double? _height;

  OStackH width(double width) => (_width = width, this).$2;

  OStackH height(double height) => (_height = height, this).$2;

  Widget make({Key? key}) {
    return SizedBox(
      height: _height,
      width: _width,
      child: Row(
        key: key,
        verticalDirection: _verticalDirection,
        crossAxisAlignment: _crossAxisAlignment,
        mainAxisAlignment: _mainAxisAlignment,
        mainAxisSize: _mainAxisSize,
        children: _child,
      ),
    );
  }
}

class OStackV {
  final List<Widget> _child;

  OStackV(this._child);

  VerticalDirection _verticalDirection = VerticalDirection.down;
  CrossAxisAlignment _crossAxisAlignment = CrossAxisAlignment.center;
  MainAxisAlignment _mainAxisAlignment = MainAxisAlignment.start;
  MainAxisSize _mainAxisSize = MainAxisSize.max;

  OStackV get mainAxisSizeMax => (_mainAxisSize = MainAxisSize.max, this).$2;

  OStackV get mainAxisSizeMin => (_mainAxisSize = MainAxisSize.min, this).$2;

  OStackV get down => (_verticalDirection = VerticalDirection.down, this).$2;

  OStackV get up => (_verticalDirection = VerticalDirection.up, this).$2;

  OStackV get crossAxisCenter =>
      (_crossAxisAlignment = CrossAxisAlignment.center, this).$2;

  OStackV get crossAxisbaseline =>
      (_crossAxisAlignment = CrossAxisAlignment.baseline, this).$2;

  OStackV get crossAxisEnd =>
      (_crossAxisAlignment = CrossAxisAlignment.end, this).$2;

  OStackV get crossAxisStart =>
      (_crossAxisAlignment = CrossAxisAlignment.start, this).$2;

  OStackV get crossAxisStretch =>
      (_crossAxisAlignment = CrossAxisAlignment.stretch, this).$2;

  OStackV get mainAxisCenter =>
      (_mainAxisAlignment = MainAxisAlignment.center, this).$2;

  OStackV get mainAxisEnd =>
      (_mainAxisAlignment = MainAxisAlignment.end, this).$2;

  OStackV get mainAxisSpaceAround =>
      (_mainAxisAlignment = MainAxisAlignment.spaceAround, this).$2;

  OStackV get mainAxisSpaceBetween =>
      (_mainAxisAlignment = MainAxisAlignment.spaceBetween, this).$2;

  OStackV get mainAxisSpaceEvenly =>
      (_mainAxisAlignment = MainAxisAlignment.spaceEvenly, this).$2;

  OStackV get mainAxisStart =>
      (_mainAxisAlignment = MainAxisAlignment.start, this).$2;
  double? _height;
  double? _width;

  OStackV width(double width) => (_width = width, this).$2;

  OStackV height(double height) => (_height = height, this).$2;

  Widget make({Key? key}) {
    return SizedBox(
      height: _height,
      width: _width,
      child: Column(
        key: key,
        verticalDirection: _verticalDirection,
        crossAxisAlignment: _crossAxisAlignment,
        mainAxisAlignment: _mainAxisAlignment,
        mainAxisSize: _mainAxisSize,
        children: _child,
      ),
    );
  }
}

// Stack widget'ını yapılandırmak için fluent API sınıfı
class OStack {
  final List<Widget> _children;
  AlignmentGeometry _alignment = AlignmentDirectional.topStart;
  TextDirection? _textDirection;
  StackFit _fit = StackFit.loose;
  Clip _clipBehavior = Clip.hardEdge;
  EdgeInsets? _margin;
  EdgeInsets? _padding;

  OStack(this._children);

  // Hizalama ayarları
  OStack get topStart => (_alignment = AlignmentDirectional.topStart, this).$2;

  OStack get topCenter =>
      (_alignment = AlignmentDirectional.topCenter, this).$2;

  OStack get topEnd => (_alignment = AlignmentDirectional.topEnd, this).$2;

  OStack get centerStart =>
      (_alignment = AlignmentDirectional.centerStart, this).$2;

  OStack get center => (_alignment = AlignmentDirectional.center, this).$2;

  OStack get centerEnd =>
      (_alignment = AlignmentDirectional.centerEnd, this).$2;

  OStack get bottomStart =>
      (_alignment = AlignmentDirectional.bottomStart, this).$2;

  OStack get bottomCenter =>
      (_alignment = AlignmentDirectional.bottomCenter, this).$2;

  OStack get bottomEnd =>
      (_alignment = AlignmentDirectional.bottomEnd, this).$2;

  // Özel hizalama ayarı
  OStack alignment(AlignmentGeometry value) => (_alignment = value, this).$2;

  // Metin yönü ayarları
  OStack get textDirectionLtr => (_textDirection = TextDirection.ltr, this).$2;

  OStack get textDirectionRtl => (_textDirection = TextDirection.rtl, this).$2;

  OStack textDirection(TextDirection? value) =>
      (_textDirection = value, this).$2;

  // Fit (boyutlandırma) ayarları
  OStack get fitLoose => (_fit = StackFit.loose, this).$2;

  OStack get fitExpand => (_fit = StackFit.expand, this).$2;

  OStack get fitPassthrough => (_fit = StackFit.passthrough, this).$2;

  // Kırpma davranışı ayarları
  OStack get clipHardEdge => (_clipBehavior = Clip.hardEdge, this).$2;

  OStack get clipAntiAlias => (_clipBehavior = Clip.antiAlias, this).$2;

  OStack get clipNone => (_clipBehavior = Clip.none, this).$2;

  OStack get clipAntiAliasWithSaveLayer =>
      (_clipBehavior = Clip.antiAliasWithSaveLayer, this).$2;

  // Margin ayarları
  OStack marginAll(double value) => (_margin = EdgeInsets.all(value), this).$2;

  OStack marginSymmetric({double? horizontal, double? vertical}) => (
    _margin = EdgeInsets.symmetric(
      horizontal: horizontal ?? 0,
      vertical: vertical ?? 0,
    ),
    this,
  ).$2;

  OStack marginOnly({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) => (
    _margin = EdgeInsets.only(
      left: left ?? 0,
      top: top ?? 0,
      right: right ?? 0,
      bottom: bottom ?? 0,
    ),
    this,
  ).$2;

  // Padding ayarları
  OStack paddingAll(double value) =>
      (_padding = EdgeInsets.all(value), this).$2;

  OStack paddingSymmetric({double? horizontal, double? vertical}) => (
    _padding = EdgeInsets.symmetric(
      horizontal: horizontal ?? 0,
      vertical: vertical ?? 0,
    ),
    this,
  ).$2;

  OStack paddingOnly({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) => (
    _padding = EdgeInsets.only(
      left: left ?? 0,
      top: top ?? 0,
      right: right ?? 0,
      bottom: bottom ?? 0,
    ),
    this,
  ).$2;

  // Stack widget'ını oluştur
  Widget make({Key? key}) {
    Widget stack = Stack(
      key: key,
      alignment: _alignment,
      textDirection: _textDirection,
      fit: _fit,
      clipBehavior: _clipBehavior,
      children: _children,
    );
    // Margin ve padding uygulanması
    if (_padding != null) {
      stack = Padding(padding: _padding!, child: stack);
    }
    if (_margin != null) {
      stack = Container(margin: _margin, child: stack);
    }
    return stack;
  }
}
