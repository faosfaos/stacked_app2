import 'package:flutter/material.dart';

class OSizedBox {
  final Widget _child;
  double? _width;
  double? _height;

  OSizedBox(this._child);

  OSizedBox width(double value) => (_width = value, this).$2;

  OSizedBox height(double value) => (_height = value, this).$2;

  Widget make({Key? key}) {
    return SizedBox(key: key, width: _width, height: _height, child: _child);
  }
}

/*class OSizedBox extends StatelessWidget {
  double? width;
  double? height;
  final Widget _child;

  OSizedBox(Widget child, {this.height, this.width}) : _child = child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(key: key, width: width, height: height, child: _child);
  }
}*/
