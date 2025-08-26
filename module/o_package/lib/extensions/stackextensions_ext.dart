import 'package:flutter/material.dart';

import '../o_extensions_class/o_stack.dart';

extension StackExtensions on List<Widget> {
  OStack get oStack => OStack(this);
}
