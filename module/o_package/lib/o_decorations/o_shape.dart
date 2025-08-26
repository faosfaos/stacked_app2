import 'package:flutter/material.dart';

import '../o_extensions.dart';

// MyShape sınıfı: Zincirleme API tasarımı
class OShape {
  // Parametreler
  ShapeType? _shapeType; // Hangi şekil türünün kullanılacağını belirler
  double? _borderRadius; // Yuvarlatma yarıçapı
  Color? _borderColor; // Kenarlık rengi
  double? _borderWidth; // Kenarlık kalınlığı
  BorderStyle? _borderStyle; // Kenarlık stili
  Gradient? _gradient; // Gradient kenarlık
  Color? _fillColor; // Dolgu rengi
  double? _opacity; // Şeffaflık
  BoxShadow? _shadow; // Gölge

  // ShapeType seçimi
  OShape shapeType(ShapeType? shapeType) {
    _shapeType = shapeType ?? ShapeType.roundedRectangle;
    return this;
  }

  // BorderRadius ayarı
  OShape borderRadius(double? borderRadius) {
    _borderRadius = borderRadius ?? 16;
    return this;
  }

  // BorderColor ayarı
  OShape borderColor(Color borderColor) {
    _borderColor = borderColor;
    return this;
  }

  // BorderWidth ayarı
  OShape borderWidth(double borderWidth) {
    _borderWidth = borderWidth;
    return this;
  }

  // BorderStyle ayarı
  OShape borderStyle(BorderStyle borderStyle) {
    _borderStyle = borderStyle;
    return this;
  }

  // Gradient kenarlık ayarı
  OShape gradient(Gradient gradient) {
    _gradient = gradient;
    return this;
  }

  // Dolgu rengi ayarı
  OShape fillColor(Color fillColor) {
    _fillColor = fillColor;
    return this;
  }

  // Şeffaflık ayarı
  OShape opacity(double opacity) {
    _opacity = opacity;
    return this;
  }

  // Gölge ayarı (varsayılan parametrelerle)
  OShape shadow({
    Color color = const Color(0xFF000000), // Varsayılan: Siyah
    double blurRadius = 0.0, // Varsayılan: 0.0
    List<double> offset = const [0, 0], // Varsayılan: [0, 0]
  }) {
    _shadow = BoxShadow(
      color: color,
      blurRadius: blurRadius,
      offset: Offset(offset[0], offset[1]),
    );
    return this;
  }

  // ShapeBorder oluştur
  ShapeBorder make() {
    _shapeType ??= ShapeType.roundedRectangle;

    // Kenarlık oluşturma
    final BorderSide side = BorderSide(
      color: _borderColor ?? Colors.black, // Varsayılan renk: Siyah
      width: _borderWidth ?? 1.0, // Varsayılan kalınlık: 1.0
      style: _borderStyle ?? BorderStyle.solid, // Varsayılan stil: Solid
    );

    switch (_shapeType!) {
      case ShapeType.roundedRectangle:
        return _applyDecorations(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius ?? 24),
            side: side,
          ),
        );

      case ShapeType.circle:
        return _applyDecorations(CircleBorder(side: side));

      case ShapeType.beveledRectangle:
        return _applyDecorations(
          BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius ?? 0),
            side: side,
          ),
        );

      case ShapeType.stadium:
        return _applyDecorations(StadiumBorder(side: side));

      case ShapeType.continuousRectangle:
        return _applyDecorations(
          ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius ?? 0),
            side: side,
          ),
        );
    }
  }

  // Kenarlık, dolgu rengi, şeffaflık ve gölge gibi özellikleri uygula
  ShapeBorder _applyDecorations(ShapeBorder shape) {
    return _CustomShapeBorder(
      shape: shape,
      gradient: _gradient,
      fillColor: _fillColor,
      opacity: _opacity,
      shadow: _shadow,
    );
  }
}

// Özel ShapeBorder sınıfı: Ekstra özellikleri uygular
class _CustomShapeBorder extends ShapeBorder {
  final ShapeBorder shape;
  final Gradient? gradient;
  final Color? fillColor;
  final double? opacity;
  final BoxShadow? shadow;

  const _CustomShapeBorder({
    required this.shape,
    this.gradient,
    this.fillColor,
    this.opacity,
    this.shadow,
  });

  @override
  EdgeInsetsGeometry get dimensions => shape.dimensions;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return shape.getInnerPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return shape.getOuterPath(rect, textDirection: textDirection);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // Gölge çizme
    if (shadow != null) {
      final Paint shadowPaint = Paint()
        ..color = shadow!.color.withValues(
          alpha: shadow!.color.a * (opacity ?? 1),
        )
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadow!.blurRadius);
      canvas.drawPath(shape.getOuterPath(rect), shadowPaint);
    }

    // Dolgu rengi çizme
    if (fillColor != null) {
      final Paint fillPaint = Paint()
        ..color = fillColor!.withValues(alpha: opacity ?? 1)
        ..style = PaintingStyle.fill;
      canvas.drawPath(shape.getOuterPath(rect), fillPaint);
    }

    // Gradient kenarlık çizme
    if (gradient != null) {
      final Paint gradientPaint = Paint()
        ..shader = gradient!.createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = shape.dimensions.horizontal.abs();
      canvas.drawPath(shape.getOuterPath(rect), gradientPaint);
    } else {
      // Normal kenarlık çizme
      shape.paint(canvas, rect, textDirection: textDirection);
    }
  }

  @override
  ShapeBorder scale(double t) {
    return _CustomShapeBorder(
      shape: shape.scale(t),
      gradient: gradient,
      fillColor: fillColor,
      opacity: opacity,
      shadow: shadow,
    );
  }
}
