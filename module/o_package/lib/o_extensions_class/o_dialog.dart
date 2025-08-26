import 'package:flutter/material.dart';

// Dialog yönleri için enum
enum DialogTransition {
  leftToRight,
  rightToLeft,
  topToBottom,
  bottomToTop,
  scale,
}

// List<Widget> üzerine Dialog için extension tanımlama
extension DialogExtensions on List<Widget> {
  ODialog get oDialog => ODialog(this);
}

// Dialog widget'ını yapılandırmak için fluent API sınıfı
class ODialog {
  final List<Widget> _children;
  Color? _backgroundColor;
  double? _elevation;
  ShapeBorder? _shape;
  Clip _clipBehavior = Clip.none;
  EdgeInsets? _margin;
  EdgeInsets? _padding;
  DialogTransition _transition = DialogTransition.scale;
  Duration _transitionDuration = const Duration(milliseconds: 300);
  Curve _curve = Curves.easeInOut;
  List<Widget>? _actions;
  double? _borderWidth;
  Color? _borderColor;
  Widget? _title; // Yeni title property'si

  ODialog(this._children);

  // Arka plan rengi ayarı
  ODialog backgroundColor(Color value) => (_backgroundColor = value, this).$2;

  // Elevation (yükseklik) ayarları
  ODialog get elevationLow => (_elevation = 4.0, this).$2;

  ODialog get elevationMedium => (_elevation = 8.0, this).$2;

  ODialog get elevationHigh => (_elevation = 12.0, this).$2;

  ODialog elevation(double value) => (_elevation = value, this).$2;

  // Köşe yuvarlaklığı ayarı
  ODialog borderRadius(double radius) {
    _shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
      side: _borderWidth != null && _borderColor != null
          ? BorderSide(width: _borderWidth!, color: _borderColor!)
          : BorderSide.none,
    );
    return this;
  }

  // Kenarlık kalınlığı ayarı
  ODialog borderWidth(double width) {
    _borderWidth = width;
    if (_shape is RoundedRectangleBorder) {
      _shape = RoundedRectangleBorder(
        borderRadius: (_shape as RoundedRectangleBorder).borderRadius,
        side: _borderColor != null
            ? BorderSide(width: width, color: _borderColor!)
            : BorderSide.none,
      );
    }
    return this;
  }

  // Kenarlık rengi ayarı
  ODialog borderColor(Color color) {
    _borderColor = color;
    if (_shape is RoundedRectangleBorder) {
      _shape = RoundedRectangleBorder(
        borderRadius: (_shape as RoundedRectangleBorder).borderRadius,
        side: _borderWidth != null
            ? BorderSide(width: _borderWidth!, color: color)
            : BorderSide.none,
      );
    }
    return this;
  }

  // Kırpma davranışı ayarları
  ODialog get clipNone => (_clipBehavior = Clip.none, this).$2;

  ODialog get clipAntiAlias => (_clipBehavior = Clip.antiAlias, this).$2;

  ODialog get clipHardEdge => (_clipBehavior = Clip.hardEdge, this).$2;

  ODialog get clipAntiAliasWithSaveLayer =>
      (_clipBehavior = Clip.antiAliasWithSaveLayer, this).$2;

  // Margin ayarları
  ODialog marginAll(double value) => (_margin = EdgeInsets.all(value), this).$2;

  ODialog marginSymmetric({double? horizontal, double? vertical}) => (
    _margin = EdgeInsets.symmetric(
      horizontal: horizontal ?? 0,
      vertical: vertical ?? 0,
    ),
    this,
  ).$2;

  ODialog marginOnly({
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
  ODialog paddingAll(double value) =>
      (_padding = EdgeInsets.all(value), this).$2;

  ODialog paddingSymmetric({double? horizontal, double? vertical}) => (
    _padding = EdgeInsets.symmetric(
      horizontal: horizontal ?? 0,
      vertical: vertical ?? 0,
    ),
    this,
  ).$2;

  ODialog paddingOnly({
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

  // Geçiş animasyonu yönü ayarı
  ODialog get leftToRight =>
      (_transition = DialogTransition.leftToRight, this).$2;

  ODialog get rightToLeft =>
      (_transition = DialogTransition.rightToLeft, this).$2;

  ODialog get topToBottom =>
      (_transition = DialogTransition.topToBottom, this).$2;

  ODialog get bottomToTop =>
      (_transition = DialogTransition.bottomToTop, this).$2;

  ODialog get scale => (_transition = DialogTransition.scale, this).$2;

  // Geçiş süresi ayarı
  ODialog transitionDuration(Duration duration) =>
      (_transitionDuration = duration, this).$2;

  // Geçiş eğrisi ayarı
  ODialog curve(Curve curve) => (_curve = curve, this).$2;

  // Aksiyon butonları ayarı
  ODialog actions(List<Widget> actionWidgets) =>
      (_actions = actionWidgets, this).$2;

  // Title ayarı (yeni)
  ODialog title(Widget titleWidget) => (_title = titleWidget, this).$2;

  // Dialogu göster
  Future<T?> show<T>(BuildContext context, {Key? key}) {
    // İçeriği ekran boyutlarına uygun hale getirme
    Widget dialogContent = ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth:
            MediaQuery.of(context).size.width *
            0.8, // Ekranın %80'i kadar maksimum genişlik
        maxHeight:
            MediaQuery.of(context).size.height *
            0.7, // Ekranın %70'i kadar maksimum yükseklik
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Sabit başlık (varsa)
          if (_title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: _title!,
            ),
          // Kaydırılabilir içerik
          Expanded(
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(), // Düzgün kaydırma
              clipBehavior: Clip.hardEdge,
              children: _children,
            ),
          ),
          // Aksiyon butonları (varsa)
          if (_actions != null)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: _actions!,
                ),
              ),
            ),
        ],
      ),
    );

    Widget dialog = Dialog(
      key: key,
      backgroundColor: _backgroundColor,
      elevation: _elevation,
      shape: _shape,
      clipBehavior: _clipBehavior,
      child: _padding != null
          ? Padding(padding: _padding!, child: dialogContent)
          : dialogContent,
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
