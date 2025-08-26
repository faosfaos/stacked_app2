import 'package:flutter/material.dart';

class OPopupMenuItem<T> extends PopupMenuEntry<T> {
  final String label;
  final VoidCallback onTap;
  final Widget? icon;
  final TextStyle? textStyle;
  final bool iconPositionIsRight;
  final bool? isClose;

  const OPopupMenuItem({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.textStyle,
    this.iconPositionIsRight = false,
    this.isClose = false,
  });

  @override
  double get height => kMinInteractiveDimension;

  @override
  bool represents(T? value) => false;

  @override
  State<OPopupMenuItem<T>> createState() => _OPopupMenuItemState<T>();
}

class _OPopupMenuItemState<T> extends State<OPopupMenuItem<T>> {
  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    if (widget.icon != null && !widget.iconPositionIsRight) {
      children.add(widget.icon!);
      children.add(const SizedBox(width: 8));
    }

    children.add(
      Flexible(
        child: Text(
          widget.label,
          style: widget.textStyle ?? Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );

    if (widget.icon != null && widget.iconPositionIsRight) {
      children.add(const SizedBox(width: 8));
      children.add(widget.icon!);
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(mainAxisSize: MainAxisSize.min, children: children),
        ),
      ),
    );
  }
}
