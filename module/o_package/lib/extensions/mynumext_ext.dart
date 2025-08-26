import 'package:flutter/material.dart';

import '../o_extensions_class/o_floating_actions_button.dart';
import '../o_extensions_class/o_text.dart';

extension MyNumExt on num {
  OText get oText => OText(toString());

  Widget get width => SizedBox(width: toDouble());

  Widget get height => SizedBox(height: toDouble());

  OFloatinActionButton get oFloatingActBtn =>
      OFloatinActionButton(Text(toString()));
}
