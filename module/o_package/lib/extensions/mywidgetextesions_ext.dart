import 'package:flutter/material.dart';

import '../o_extensions_class/o_align.dart';
import '../o_extensions_class/o_box.dart';
import '../o_extensions_class/o_card.dart';
import '../o_extensions_class/o_floating_actions_button.dart';
import '../o_extensions_class/o_rotatedbox.dart';
import '../o_extensions_class/o_scroll.dart';

extension MyWidgetExtesions on Widget {
  OBox get oBox => OBox(this);
  Widget oPaddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);
  Widget oPaddingSymmetric({double vertical = 0.0, double horizontal = 0.0}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: vertical,
          horizontal: horizontal,
        ),
        child: this,
      );
  Widget oPaddingOnly({
    double left = 0.0,
    double right = 0.0,
    double top = 0.0,
    double bottom = 0.0,
  }) => Padding(
    padding: EdgeInsets.only(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
    ),
    child: this,
  );
  OAlignBuilder get oAlign => OAlignBuilder(child: this);
  //OSizedBox get oSizedBox => OSizedBox(this);
  Widget oSizedBox({Key? key, double? width, double? height}) =>
      SizedBox(key: key, width: width, height: height, child: this);

  Widget oWidth({required double width}) => SizedBox(width: width, child: this);

  Widget oHeight({required double height}) =>
      SizedBox(height: height, child: this);

  OScrollV get oScrollV => OScrollV(this);

  OScrollH get oScrollH => OScrollH(this);

  ORotatedBox get oRotatedBox => ORotatedBox(this);

  OCard get oCard => OCard(this);

  Padding pAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  Padding pOnly({double? top, double? bottom, double? right, double? left}) =>
      Padding(
        padding: EdgeInsets.only(
          top: top ?? 0,
          bottom: bottom ?? 0,
          right: right ?? 0,
          left: left ?? 0,
        ),
        child: this,
      );

  OFloatinActionButton get oFloatinActionButton => OFloatinActionButton(this);

  Expanded oExpand({int flex = 1, Key? key}) =>
      Expanded(key: key, flex: flex, child: this);

  Widget oCenter({Key? key, double? widthFactor, double? heightFactor}) =>
      Center(
        key: key,
        widthFactor: heightFactor,
        heightFactor: heightFactor,
        child: this,
      );
}
