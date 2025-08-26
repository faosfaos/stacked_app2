import 'package:flutter/material.dart';

// Card widget'ını yapılandırmak için fluent API sınıfı
class OCard {
  final Widget _child;
  double _elevation = 1.0;
  EdgeInsets? _margin;
  EdgeInsets? _padding;
  Color? _color;
  Color? _shadowColor;
  Color? _surfaceTintColor;
  ShapeBorder? _shape;
  bool _borderOnForeground = true;
  Clip _clipBehavior = Clip.none;
  bool _semanticContainer = true;

  OCard(this._child);

  // Elevation (yükseklik) ayarları
  OCard get elevationLow => (_elevation = 1.0, this).$2;
  OCard get elevationMedium => (_elevation = 4.0, this).$2;
  OCard get elevationHigh => (_elevation = 8.0, this).$2;
  OCard elevation(double value) => (_elevation = value, this).$2;

  // Margin ayarları
  OCard marginAll(double value) => (_margin = EdgeInsets.all(value), this).$2;
  OCard marginSymmetric({double? horizontal, double? vertical}) => (
    _margin = EdgeInsets.symmetric(
      horizontal: horizontal ?? 0,
      vertical: vertical ?? 0,
    ),
    this,
  ).$2;
  OCard marginOnly({
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
  OCard paddingAll(double value) => (_padding = EdgeInsets.all(value), this).$2;
  OCard paddingSymmetric({double? horizontal, double? vertical}) => (
    _padding = EdgeInsets.symmetric(
      horizontal: horizontal ?? 0,
      vertical: vertical ?? 0,
    ),
    this,
  ).$2;
  OCard paddingOnly({
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

  // Arka plan rengi ayarı
  OCard color(Color? value) => (_color = value, this).$2;

  // Gölge rengi ayarı
  OCard shadowColor(Color value) => (_shadowColor = value, this).$2;

  // Yüzey ton rengi ayarı
  OCard surfaceTintColor(Color value) => (_surfaceTintColor = value, this).$2;

  // Köşe yuvarlaklığı ayarı
  OCard borderRadius(double radius) => (
    _shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    ),
    this,
  ).$2;

  // Kenarlık ön planda mı ayarı
  OCard get borderOnForeground => (_borderOnForeground = true, this).$2;
  OCard get noBorderOnForeground => (_borderOnForeground = false, this).$2;

  // Kırpma davranışı ayarları
  OCard get clipNone => (_clipBehavior = Clip.none, this).$2;
  OCard get clipAntiAlias => (_clipBehavior = Clip.antiAlias, this).$2;
  OCard get clipHardEdge => (_clipBehavior = Clip.hardEdge, this).$2;
  OCard get clipAntiAliasWithSaveLayer =>
      (_clipBehavior = Clip.antiAliasWithSaveLayer, this).$2;

  // Semantik konteyner ayarı
  OCard get semanticContainer => (_semanticContainer = true, this).$2;
  OCard get noSemanticContainer => (_semanticContainer = false, this).$2;

  // Card widget'ını oluştur
  Widget make({Key? key}) {
    return Padding(
      padding: _padding ?? EdgeInsets.zero,
      child: Card(
        key: key,
        elevation: _elevation,
        margin: _margin,
        color: _color,
        shadowColor: _shadowColor,
        surfaceTintColor: _surfaceTintColor,
        shape: _shape,
        borderOnForeground: _borderOnForeground,
        clipBehavior: _clipBehavior,
        semanticContainer: _semanticContainer,
        child: _child,
      ),
    );
  }
}
