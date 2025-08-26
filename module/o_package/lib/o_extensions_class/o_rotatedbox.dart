import 'package:flutter/material.dart';

extension RotatedBoxExtensions on Widget {
  ORotatedBox get oRotatedBox => ORotatedBox(this);
}

class ORotatedBox {
  final Widget _child;
  int _quarterTurns = 0;

  ORotatedBox(this._child);

  ORotatedBox get rotate0 => (_quarterTurns = 0, this).$2;
  ORotatedBox get rotate90 => (_quarterTurns = 1, this).$2;
  ORotatedBox get rotate180 => (_quarterTurns = 2, this).$2;
  ORotatedBox get rotate270 => (_quarterTurns = 3, this).$2;
  ORotatedBox get rotate360 => (_quarterTurns = 4, this).$2;

  ORotatedBox quarterTurns(int turns) => (_quarterTurns = turns, this).$2;

  ORotatedBox degrees(double degrees) {
    _quarterTurns = (degrees / 90).round();
    return this;
  }

  Widget make({Key? key}) {
    return RotatedBox(key: key, quarterTurns: _quarterTurns, child: _child);
  }
}
