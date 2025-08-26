import 'package:flutter/material.dart';

class DialogProperties {
  final ShapeBorder? shape;
  final int? transitionDuration;
  final double? height;
  final bool barrierDismissible;

  DialogProperties({
    this.shape,
    this.transitionDuration,
    this.barrierDismissible = true,
    this.height,
  });
}
