import 'package:flutter/material.dart';

class OScrollH {
  final Widget _child;
  OScrollH(this._child);
  ScrollPhysics? _physics = ScrollPhysics(parent: BouncingScrollPhysics());
  EdgeInsetsGeometry? _padding;
  OScrollH physics(ScrollPhysics? physics) => (_physics = physics, this).$2;
  OScrollH padding(EdgeInsetsGeometry? padding) =>
      (_padding = padding, this).$2;

  Widget make({ScrollController? controller, Key? key}) {
    return SingleChildScrollView(
      key: key,
      scrollDirection: Axis.horizontal,
      physics: _physics,
      padding: _padding,
      controller: controller,
      child: _child,
    );
  }
}

class OScrollV {
  final Widget _child;
  OScrollV(this._child);
  ScrollPhysics? _physics = ScrollPhysics(parent: BouncingScrollPhysics());
  EdgeInsetsGeometry? _padding;

  OScrollV physics(ScrollPhysics? physics) => (_physics = physics, this).$2;
  OScrollV padding(EdgeInsetsGeometry? padding) =>
      (_padding = padding, this).$2;

  Widget make({ScrollController? controller, Key? key}) {
    return SingleChildScrollView(
      key: key,
      padding: _padding,
      scrollDirection: Axis.vertical,
      physics: _physics,
      controller: controller,
      child: _child,
    );
  }
}
