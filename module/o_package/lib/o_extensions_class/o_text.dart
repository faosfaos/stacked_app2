import 'package:flutter/material.dart';

class OText {
  String _data;
  OText(this._data);
  Color? _color;
  FontWeight? _fontWeight;
  double? _fontSize;
  FontStyle? _fontStyle;
  double? _letterSpacing;
  double? _wordSpacing;
  TextBaseline? _textBaseline;
  double? _height;
  TextDecoration? _decoration;
  Color? _decorationColor;
  int _lowerOrUpper = 0;
  // 0=normal
  // 1=toLowerCase
  // 2=toUpperCase
  OText get toLower => (_lowerOrUpper = 1, this).$2;
  OText get toUpper => (_lowerOrUpper = 2, this).$2;
  OText get capitalizeAll => (_lowerOrUpper = 3, this).$2;
  OText get capitalize => (_lowerOrUpper = 4, this).$2;

  //Set Colors
  OText color(Color? color) => (_color = color, this).$2;
  OText get red => (_color = Colors.red, this).$2;
  OText get blue => (_color = Colors.blue, this).$2;
  OText get amber => (_color = Colors.amber, this).$2;
  OText get green => (_color = Colors.green, this).$2;
  OText get grey => (_color = Colors.grey, this).$2;
  OText get white => (_color = Colors.white, this).$2;
  OText get black => (_color = Colors.black, this).$2;
  OText get cyan => (_color = Colors.cyan, this).$2;
  OText get orange => (_color = Colors.orange, this).$2;
  OText get deepOrange => (_color = Colors.deepOrange, this).$2;
  OText get purple => (_color = Colors.purple, this).$2;
  OText get deepPurple => (_color = Colors.deepPurple, this).$2;
  OText get indigo => (_color = Colors.indigo, this).$2;
  //Set Bold
  //_MyText get bold => (_fontWeight = FontWeight.bold, this).$2;
  OText get bold => (_fontWeight = FontWeight.bold, this).$2;
  OText get bold100 => (_fontWeight = FontWeight.w100, this).$2;
  OText get bold200 => (_fontWeight = FontWeight.w200, this).$2;
  OText get bold300 => (_fontWeight = FontWeight.w300, this).$2;
  OText get bold400 => (_fontWeight = FontWeight.w400, this).$2;
  OText get bold500 => (_fontWeight = FontWeight.w500, this).$2;
  OText get bold600 => (_fontWeight = FontWeight.w600, this).$2;
  OText get bold700 => (_fontWeight = FontWeight.w700, this).$2;
  OText get bold800 => (_fontWeight = FontWeight.w800, this).$2;
  OText get bold900 => (_fontWeight = FontWeight.w900, this).$2;
  //Set TextSize
  OText get xl => _setTextSize(20);
  OText get xl2 => _setTextSize(24);
  OText get xl3 => _setTextSize(28);
  OText get xl4 => _setTextSize(32);
  OText get xl5 => _setTextSize(36);
  OText get xl6 => _setTextSize(40);
  OText _setTextSize(double? fontSize) => (_fontSize = fontSize, this).$2;
  OText size(double? size) => _setTextSize(size);

  //Set FontStyle
  OText get italic => (_fontStyle = FontStyle.italic, this).$2;
  OText letterSpacing(double value) => (_letterSpacing = value, this).$2;
  OText wordSpacing(double value) => (_wordSpacing = value, this).$2;

  OText get alphabetic => (_textBaseline = TextBaseline.alphabetic, this).$2;
  OText get ideographic => (_textBaseline = TextBaseline.ideographic, this).$2;

  OText height(double value) => (_height = value, this).$2;

  OText udenrline({Color? color}) => (
    _decoration = TextDecoration.underline,
    _decorationColor = color,
    this,
  ).$3;
  OText overline({Color? color}) => (
    _decoration = TextDecoration.overline,
    _decorationColor = color,
    this,
  ).$3;
  //İsim vererek yapılabilir
  OText lineThrough({Color? color}) => (
    _decoration = TextDecoration.lineThrough,
    _decorationColor = color,
    returnn: this,
  ).returnn;

  /* _MyText combine(List<TextDecoration> decorations, {Color? color}) => (
        _decoration = TextDecoration.combine(decorations),
        _decorationColor = color,
        this
      )
          .$3;*/
  OText combineTextDecoration({
    bool underline = false,
    bool lineThrough = false,
    bool overLine = false,
    Color? color,
  }) => (
    _decoration = _setCombine(underline, lineThrough, overLine),
    color: _decorationColor = color,
    myText: this,
  ).myText;

  TextOverflow? _overflow;
  OText get overflowClip => (_overflow = TextOverflow.clip, this).$2;
  OText get overflowEllipsis => (_overflow = TextOverflow.ellipsis, this).$2;
  OText get overflowFade => (_overflow = TextOverflow.fade, this).$2;
  OText get overflowVisible => (_overflow = TextOverflow.visible, this).$2;

  TextAlign? _textAlign;
  OText get center => (_textAlign = TextAlign.center, this).$2;
  OText setCenter(bool isCenter) => (
    isCenter ? _textAlign = TextAlign.center : _textAlign = TextAlign.left,
    this,
  ).$2;
  OText get end => (_textAlign = TextAlign.end, this).$2;
  OText get justify => (_textAlign = TextAlign.justify, this).$2;
  OText get left => (_textAlign = TextAlign.left, this).$2;
  OText get right => (_textAlign = TextAlign.right, this).$2;
  OText get start => (_textAlign = TextAlign.start, this).$2;

  Color? _backgroundColor;
  OText backgroundColor({Color? color}) => (_backgroundColor = color, this).$2;
  OText removeFirst({int length = 1}) =>
      (_data = _removeFirst(_data, charLength: length), this).$2;
  OText removeLast({int? length = 1}) =>
      (_data = _removeLast(_data, charLength: length), this).$2;
  List<Shadow>? _shadows = [
    Shadow(color: Colors.black, offset: Offset(0, 0), blurRadius: 0),
  ];
  OText shadow({
    Color color = Colors.transparent,
    double blurRadius = 0,
    double dx = 0,
    double dy = 0,
  }) => (
    _shadows = [
      Shadow(color: color, offset: Offset(dx, dy), blurRadius: blurRadius),
    ],
    this,
  ).$2;

  int? _maxLines;
  OText maxLine([int maxLine = 1]) => (_maxLines = maxLine, this).$2;
  bool? _softWrap;
  OText softWarp({bool? softWrap}) => (_softWrap = softWrap, this).$2;
  Locale? _locale;
  OText locale({Locale? locale}) => (_locale = locale, this).$2;
  Color? _selectionColor;
  OText selectionColor({Color? selectionColor}) =>
      (_selectionColor = selectionColor, this).$2;

  Text make({Key? key, StrutStyle? strutStyle, String? semanticsLabel}) {
    return Text(
      _toLowerOrUpperCase(_data, _lowerOrUpper),
      key: key,
      maxLines: _maxLines,
      overflow: _overflow,
      selectionColor: _selectionColor,
      softWrap: _softWrap,
      semanticsLabel: semanticsLabel,
      strutStyle: strutStyle,
      textAlign: _textAlign,

      style: TextStyle(
        color: _color,
        fontWeight: _fontWeight,
        fontSize: _fontSize,
        fontStyle: _fontStyle,
        letterSpacing: _letterSpacing, // Harfler arası boşluk
        wordSpacing: _wordSpacing, // Kelimeler arası boşluk
        textBaseline: _textBaseline,
        height: _height, // Satır yüksekliği (FontSize ile carpilir)
        decoration: _decoration,
        decorationColor: _decorationColor, // Dekorasyon rengi
        backgroundColor: _backgroundColor,
        shadows: _shadows,
        locale: _locale,
      ),
    );
  }
}

/* FontWeight _setFontWeight({int? weight = 0}) {
  switch (weight) {
    case 100:
      return FontWeight.w100;
    case 200:
      return FontWeight.w200;
    case 300:
      return FontWeight.w300;
    case 400:
      return FontWeight.w400;
    case 500:
      return FontWeight.w500;
    case 600:
      return FontWeight.w600;
    case 700:
      return FontWeight.w700;
    default:
      return FontWeight.bold;
  }
}
 */
String _toLowerOrUpperCase(String data, int value) {
  switch (value) {
    case 1:
      return data.toLowerCase();
    case 2:
      return data.toUpperCase();
    case 3:
      return data[0].toUpperCase() + data.substring(1).toLowerCase();
    case 4:
      return data
          .trim() // Başındaki ve sonundaki boşlukları temizle
          .split(' ') // Boşluklara göre ayır
          .map((word) {
            if (word.isEmpty) return word; // Boş kelime kontrolü
            return word[0].toUpperCase() + word.substring(1).toLowerCase();
          })
          .join(' ');
    default:
      return data;
  }
}

String _removeLast(String data, {int? charLength}) {
  // Varsayılan değer: Eğer silinecekHarfSayisi null ise 1 olarak ayarla
  int dataLength = charLength ?? 1;
  // Eğer silinecek harf sayısı, metnin uzunluğundan büyükse boş string döndür
  if (dataLength >= data.length) return '';
  // Belirtilen sayıda harfi sondan kes
  return data.substring(0, data.length - dataLength);
}

String _removeFirst(String data, {int? charLength}) {
  // Varsayılan değer: Eğer silinecekHarfSayisi null ise 1 olarak ayarla
  int dataLength = charLength ?? 1;
  // Eğer silinecek harf sayısı, metnin uzunluğundan büyükse boş string döndür
  if (dataLength >= data.length) return '';
  // Belirtilen sayıda harfi baştan kes
  return data.substring(dataLength);
}

TextDecoration _setCombine(bool underline, bool lineThrough, bool overLine) {
  return TextDecoration.combine([
    if (underline) TextDecoration.underline,
    if (lineThrough) TextDecoration.lineThrough,
    if (overLine) TextDecoration.overline,
  ]);
}
