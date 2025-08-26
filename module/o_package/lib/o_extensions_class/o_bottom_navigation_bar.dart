import 'package:flutter/material.dart';

// List<BottomNavigationBarItem> üzerine BottomNavigationBar için extension tanımlama
extension BottomNavigationBarExtensions on List<BottomNavigationBarItem> {
  /// BottomNavigationBar kullanımı için örnek:
  /// ```Dart
  /// Widget myBottomNavBar = [
  /// BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
  /// BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ayarlar'),
  ///].oBottomNavigationBar
  ///  .onTap((index) => print('Seçilen: $index'))
  ///  .currentIndex(0)
  ///  .elevationMedium
  ///  .fixed
  ///  .backgroundColor(Colors.blue.shade100)
  ///  .selectedItemColor(Colors.blue)
  ///  .unselectedItemColor(Colors.grey)
  ///  .iconSize(28.0)
  ///  .selectedFontSize(16.0)
  ///  .showSelectedLabels
  ///  .hideUnselectedLabels
  ///  .marginOnly(left: 16.0, right: 16.0)
  ///  .paddingAll(8.0)
  ///  .make();
  /// ```
  OBottomNavigationBar get oBottomNavigationBar => OBottomNavigationBar(this);
}

// BottomNavigationBar widget'ını yapılandırmak için fluent API sınıfı
class OBottomNavigationBar {
  final List<BottomNavigationBarItem> _items;
  ValueChanged<int>? _onTap;
  int _currentIndex = 0;
  double _elevation = 8.0;
  BottomNavigationBarType? _type;
  Color? _fixedColor;
  Color? _backgroundColor;
  double _iconSize = 24.0;
  Color? _selectedItemColor;
  Color? _unselectedItemColor;
  IconThemeData? _selectedIconTheme;
  IconThemeData? _unselectedIconTheme;
  double _selectedFontSize = 14.0;
  double _unselectedFontSize = 12.0;
  TextStyle? _selectedLabelStyle;
  TextStyle? _unselectedLabelStyle;
  bool _showSelectedLabels = true;
  bool? _showUnselectedLabels;
  MouseCursor? _mouseCursor;
  bool? _enableFeedback;
  BottomNavigationBarLandscapeLayout _landscapeLayout =
      BottomNavigationBarLandscapeLayout.spread;
  EdgeInsets? _margin;
  EdgeInsets? _padding;

  OBottomNavigationBar(this._items);

  // onTap callback ayarı
  OBottomNavigationBar onTap(ValueChanged<int> callback) =>
      (_onTap = callback, this).$2;

  // Mevcut sekme indeksi ayarı
  OBottomNavigationBar currentIndex(int index) =>
      (_currentIndex = index, this).$2;

  // Elevation (yükseklik) ayarları
  OBottomNavigationBar get elevationLow => (_elevation = 4.0, this).$2;
  OBottomNavigationBar get elevationMedium => (_elevation = 8.0, this).$2;
  OBottomNavigationBar get elevationHigh => (_elevation = 12.0, this).$2;
  OBottomNavigationBar elevation(double value) => (_elevation = value, this).$2;

  // Tür ayarları
  OBottomNavigationBar get fixed =>
      (_type = BottomNavigationBarType.fixed, this).$2;
  OBottomNavigationBar get shifting =>
      (_type = BottomNavigationBarType.shifting, this).$2;

  // Renk ayarları
  OBottomNavigationBar fixedColor(Color value) =>
      (_fixedColor = value, this).$2;
  OBottomNavigationBar backgroundColor(Color value) =>
      (_backgroundColor = value, this).$2;
  OBottomNavigationBar selectedItemColor(Color value) =>
      (_selectedItemColor = value, this).$2;
  OBottomNavigationBar unselectedItemColor(Color value) =>
      (_unselectedItemColor = value, this).$2;

  // İkon boyut ayarı
  OBottomNavigationBar iconSize(double value) => (_iconSize = value, this).$2;

  // İkon tema ayarları
  OBottomNavigationBar selectedIconTheme(IconThemeData value) =>
      (_selectedIconTheme = value, this).$2;
  OBottomNavigationBar unselectedIconTheme(IconThemeData value) =>
      (_unselectedIconTheme = value, this).$2;

  // Yazı tipi boyutu ayarları
  OBottomNavigationBar selectedFontSize(double value) =>
      (_selectedFontSize = value, this).$2;
  OBottomNavigationBar unselectedFontSize(double value) =>
      (_unselectedFontSize = value, this).$2;

  // Etiket stili ayarları
  OBottomNavigationBar selectedLabelStyle(TextStyle value) =>
      (_selectedLabelStyle = value, this).$2;
  OBottomNavigationBar unselectedLabelStyle(TextStyle value) =>
      (_unselectedLabelStyle = value, this).$2;

  // Etiket görünürlük ayarları
  OBottomNavigationBar get showSelectedLabels =>
      (_showSelectedLabels = true, this).$2;
  OBottomNavigationBar get hideSelectedLabels =>
      (_showSelectedLabels = false, this).$2;
  OBottomNavigationBar get showUnselectedLabels =>
      (_showUnselectedLabels = true, this).$2;
  OBottomNavigationBar get hideUnselectedLabels =>
      (_showUnselectedLabels = false, this).$2;

  // Fare imleci ayarı
  OBottomNavigationBar mouseCursor(MouseCursor value) =>
      (_mouseCursor = value, this).$2;

  // Geri bildirim ayarı
  OBottomNavigationBar get enableFeedback => (_enableFeedback = true, this).$2;
  OBottomNavigationBar get disableFeedback =>
      (_enableFeedback = false, this).$2;

  // Yatay düzen ayarı
  OBottomNavigationBar get landscapeSpread =>
      (_landscapeLayout = BottomNavigationBarLandscapeLayout.spread, this).$2;
  OBottomNavigationBar get landscapeCentered =>
      (_landscapeLayout = BottomNavigationBarLandscapeLayout.centered, this).$2;
  OBottomNavigationBar get landscapeLinear =>
      (_landscapeLayout = BottomNavigationBarLandscapeLayout.linear, this).$2;

  // Margin ayarları
  OBottomNavigationBar marginAll(double value) =>
      (_margin = EdgeInsets.all(value), this).$2;
  OBottomNavigationBar marginSymmetric({
    double? horizontal,
    double? vertical,
  }) => (
    _margin = EdgeInsets.symmetric(
      horizontal: horizontal ?? 0,
      vertical: vertical ?? 0,
    ),
    this,
  ).$2;
  OBottomNavigationBar marginOnly({
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
  OBottomNavigationBar paddingAll(double value) =>
      (_padding = EdgeInsets.all(value), this).$2;
  OBottomNavigationBar paddingSymmetric({
    double? horizontal,
    double? vertical,
  }) => (
    _padding = EdgeInsets.symmetric(
      horizontal: horizontal ?? 0,
      vertical: vertical ?? 0,
    ),
    this,
  ).$2;
  OBottomNavigationBar paddingOnly({
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

  // BottomNavigationBar widget'ını oluştur
  Widget make({Key? key}) {
    Widget bottomNavBar = BottomNavigationBar(
      key: key,
      items: _items,
      onTap: _onTap,
      currentIndex: _currentIndex,
      elevation: _elevation,
      type: _type,
      fixedColor: _fixedColor,
      backgroundColor: _backgroundColor,
      iconSize: _iconSize,
      selectedItemColor: _selectedItemColor,
      unselectedItemColor: _unselectedItemColor,
      selectedIconTheme: _selectedIconTheme,
      unselectedIconTheme: _unselectedIconTheme,
      selectedFontSize: _selectedFontSize,
      unselectedFontSize: _unselectedFontSize,
      selectedLabelStyle: _selectedLabelStyle,
      unselectedLabelStyle: _unselectedLabelStyle,
      showSelectedLabels: _showSelectedLabels,
      showUnselectedLabels: _showUnselectedLabels,
      mouseCursor: _mouseCursor,
      enableFeedback: _enableFeedback,
      landscapeLayout: _landscapeLayout,
    );
    // Margin ve padding uygulanması
    if (_padding != null) {
      bottomNavBar = Padding(padding: _padding!, child: bottomNavBar);
    }
    if (_margin != null) {
      bottomNavBar = Container(margin: _margin, child: bottomNavBar);
    }
    return bottomNavBar;
  }
}
