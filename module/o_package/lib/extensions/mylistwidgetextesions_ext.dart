import 'package:flutter/material.dart' show Widget;
import 'package:flutter/widgets.dart';
import 'package:o_package/o_extensions.dart';

import '../o_decorations/o_shape.dart';
import '../o_extensions_class/o_stack.dart';

extension MyListWidgetExtesions on List {
  OStackV get oColumn => OStackV(cast<Widget>());
  OStackH get oRow => OStackH(cast<Widget>());
}

enum ShapeType {
  roundedRectangle,
  circle,
  beveledRectangle,
  stadium,
  continuousRectangle,
}

String toDateTime(
  String time,
  String pattern,
  String saat,
  bool saatGoster,
  bool tarihiFullGoster,
) {
  saat = saat.substring(0, 5);
  List<String> t = time.split(pattern);
  String y = t[0];
  String a = t[1];
  String g = t[2];
  return "$g ${_intToMonth(a.toInt)} ${tarihiFullGoster ? y : y.substring(2, 4)} ${saatGoster ? "- $saat" : ""}";
}

String _intToMonth(int ay) {
  switch (ay) {
    case 1:
      return "Ocak";
    case 2:
      return "Şubat";
    case 3:
      return "Mart";
    case 4:
      return "Nisan";
    case 5:
      return "Mayıs";
    case 6:
      return "Haziran";
    case 7:
      return "Temmuz";
    case 8:
      return "Ağustos";
    case 9:
      return "Eylül";
    case 10:
      return "Ekim";
    case 11:
      return "Kasım";
    case 12:
      return "Aralık";

    default:
      return "";
  }
}

abstract class ODecorationProperties {
  static OShape get oShape => OShape();
}
