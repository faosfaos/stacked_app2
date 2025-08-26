/* import 'package:flutter/material.dart';

// Dialog yönleri için enum
enum DialogTransition {
  leftToRight,
  rightToLeft,
  topToBottom,
  bottomToTop,
  scale,
}

// Widget üzerine Dialog için extension tanımlama
extension DialogExtensions on Widget {
  ODialogSingleWidget get oDialog => ODialogSingleWidget(this);
}

// Dialog widget'ını yapılandırmak için fluent API sınıfı
class ODialogSingleWidget {
  final Widget _child;
  Color? _backgroundColor;
  double? _elevation;
  ShapeBorder? _shape;
  Clip _clipBehavior = Clip.none;
  EdgeInsets? _margin;
  EdgeInsets? _padding;
  DialogTransition _transition = DialogTransition.scale;
  Duration _transitionDuration = const Duration(milliseconds: 300);
  Curve _curve = Curves.easeInOut;

  ODialogSingleWidget(this._child);

  // Arka plan rengi ayarı
  ODialogSingleWidget backgroundColor(Color value) =>
      (_backgroundColor = value, this).$2;

  // Elevation (yükseklik) ayarları
  ODialogSingleWidget get elevationLow => (_elevation = 4.0, this).$2;
  ODialogSingleWidget get elevationMedium => (_elevation = 8.0, this).$2;
  ODialogSingleWidget get elevationHigh => (_elevation = 12.0, this).$2;
  ODialogSingleWidget elevation(double value) => (_elevation = value, this).$2;

  // Köşe yuvarlaklığı ayarı
  ODialogSingleWidget borderRadius(double radius) =>
      (
        _shape = RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        this,
      ).$2;

  // Kırpma davranışı ayarları
  ODialogSingleWidget get clipNone => (_clipBehavior = Clip.none, this).$2;
  ODialogSingleWidget get clipAntiAlias =>
      (_clipBehavior = Clip.antiAlias, this).$2;
  ODialogSingleWidget get clipHardEdge =>
      (_clipBehavior = Clip.hardEdge, this).$2;
  ODialogSingleWidget get clipAntiAliasWithSaveLayer =>
      (_clipBehavior = Clip.antiAliasWithSaveLayer, this).$2;

  // Margin ayarları
  ODialogSingleWidget marginAll(double value) =>
      (_margin = EdgeInsets.all(value), this).$2;
  ODialogSingleWidget marginSymmetric({double? horizontal, double? vertical}) =>
      (
        _margin = EdgeInsets.symmetric(
          horizontal: horizontal ?? 0,
          vertical: vertical ?? 0,
        ),
        this,
      ).$2;
  ODialogSingleWidget marginOnly({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) =>
      (
        _margin = EdgeInsets.only(
          left: left ?? 0,
          top: top ?? 0,
          right: right ?? 0,
          bottom: bottom ?? 0,
        ),
        this,
      ).$2;

  // Padding ayarları
  ODialogSingleWidget paddingAll(double value) =>
      (_padding = EdgeInsets.all(value), this).$2;
  ODialogSingleWidget paddingSymmetric({
    double? horizontal,
    double? vertical,
  }) =>
      (
        _padding = EdgeInsets.symmetric(
          horizontal: horizontal ?? 0,
          vertical: vertical ?? 0,
        ),
        this,
      ).$2;
  ODialogSingleWidget paddingOnly({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) =>
      (
        _padding = EdgeInsets.only(
          left: left ?? 0,
          top: top ?? 0,
          right: right ?? 0,
          bottom: bottom ?? 0,
        ),
        this,
      ).$2;

  // Geçiş animasyonu yönü ayarı
  ODialogSingleWidget get leftToRight =>
      (_transition = DialogTransition.leftToRight, this).$2;
  ODialogSingleWidget get rightToLeft =>
      (_transition = DialogTransition.rightToLeft, this).$2;
  ODialogSingleWidget get topToBottom =>
      (_transition = DialogTransition.topToBottom, this).$2;
  ODialogSingleWidget get bottomToTop =>
      (_transition = DialogTransition.bottomToTop, this).$2;
  ODialogSingleWidget get scale =>
      (_transition = DialogTransition.scale, this).$2;

  // Geçiş süresi ayarı
  ODialogSingleWidget transitionDuration(Duration duration) =>
      (_transitionDuration = duration, this).$2;

  // Geçiş eğrisi ayarı
  ODialogSingleWidget curve(Curve curve) => (_curve = curve, this).$2;

  // Dialogu göster
  Future<T?> show<T>(BuildContext context, {Key? key}) {
    Widget dialog = Dialog(
      key: key,
      backgroundColor: _backgroundColor,
      elevation: _elevation,
      shape: _shape,
      clipBehavior: _clipBehavior,

      child:
          _padding != null
              ? Padding(padding: _padding!, child: _child)
              : _child,
    );

    if (_margin != null) {
      dialog = Padding(padding: _margin!, child: dialog);
    }

    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: _transitionDuration,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        switch (_transition) {
          case DialogTransition.leftToRight:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(parent: animation, curve: _curve)),
              child: child,
            );
          case DialogTransition.rightToLeft:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(parent: animation, curve: _curve)),
              child: child,
            );
          case DialogTransition.topToBottom:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, -1.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(parent: animation, curve: _curve)),
              child: child,
            );
          case DialogTransition.bottomToTop:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(parent: animation, curve: _curve)),
              child: child,
            );
          case DialogTransition.scale:
            return ScaleTransition(
              scale: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(CurvedAnimation(parent: animation, curve: _curve)),
              child: child,
            );
        }
      },
      pageBuilder: (context, animation, secondaryAnimation) => dialog,
    );
  }
}
 */
