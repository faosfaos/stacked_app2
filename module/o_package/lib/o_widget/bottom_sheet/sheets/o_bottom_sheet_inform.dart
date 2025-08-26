import 'package:flutter/material.dart';
import '../abstracts/base_button_sheet.dart';
import '../clases/title_text_shadow.dart';

class OBottomSheetInform extends BaseBottomSheet {
  ///- Default title ="Bilgilendirme"
  final String? title;

  ///- Default titleBackgrundColor =Colors.red
  final Color? titleBackgrundColor;

  ///- Default contentBackgrundColor =Colors.white
  final Color? contentBackgrundColor;

  ///- Default titleSize = 24
  final double? titleSize;
  final List<Widget>? content;

  ///- Default centerContent = true
  final bool? centerContent;
  final bool? showIcon;
  final bool? showTitle;
  final Icon? icon;

  ///- Default contentHeight = 200
  final double? contentHeight;
  final TitleTextShadow? titleTextShadow;

  final bool? isDismissible;

  OBottomSheetInform({
    this.title,
    this.showTitle,
    this.titleBackgrundColor,
    this.titleSize,
    this.content,
    this.contentHeight,
    this.centerContent,
    this.contentBackgrundColor,
    this.titleTextShadow,
    this.icon,
    this.showIcon,
    this.isDismissible,
  });

  @override
  bool get getShowTitle => showTitle ?? true;

  @override
  bool get getIsDismissible => isDismissible ?? super.getIsDismissible;

  @override
  Color getTitleBackgorundColor(context) =>
      titleBackgrundColor ?? Theme.of(context).colorScheme.primary;

  @override
  String get getTitle => title ?? "DİKKAT";

  @override
  double get getTitleSize => titleSize ?? 24;

  @override
  List<Widget> get getContentList => content ?? [];

  @override
  double? get getContentHeight => contentHeight;

  @override
  bool get getCenterContent => centerContent ?? true;

  @override
  Color getContentBackgorundColor(context) =>
      contentBackgrundColor ?? Theme.of(context).colorScheme.onSecondary;
  @override
  TitleTextShadow get getTitleTextShadow =>
      titleTextShadow ?? super.getTitleTextShadow;

  @override
  Icon? get getIcon => icon ?? Icon(Icons.info, color: Colors.white, size: 36);

  @override
  bool? get getShowIcon => showIcon;

  @override
  Widget? getBottomWidget(context) => null;
}
