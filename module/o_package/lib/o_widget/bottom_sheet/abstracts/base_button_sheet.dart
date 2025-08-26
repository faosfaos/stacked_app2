import 'package:flutter/material.dart';
import '/o_extensions.dart';

import '../clases/title_text_shadow.dart';

abstract class BaseBottomSheet {
  String get getTitle;
  Color getTitleBackgorundColor(context);
  Color getContentBackgorundColor(context);
  double get getTitleSize;
  double? get getContentHeight;
  bool get getCenterContent;
  bool? get getShowIcon;
  bool get getIsDismissible => true;
  bool get getShowTitle => true;

  Icon? get getIcon;
  List<Widget> get getContentList;
  TitleTextShadow get getTitleTextShadow => TitleTextShadow();
  Widget? getBottomWidget(BuildContext context);

  void show(BuildContext context) {
    showModalBottomSheet(
      isDismissible: getIsDismissible,
      shape: Border(),
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (getShowIcon != null && getShowTitle)
              getIcon!.oBox
                  .pOnly(top: 12)
                  .width(context.screenWidth)
                  .color(getTitleBackgorundColor(context))
                  .make(),

            if (getTitle.trim().isNotEmpty && getShowTitle)
              getTitle.oText.center.white.bold.overflowEllipsis
                  .shadow(
                    color: getTitleTextShadow.color,
                    dx: getTitleTextShadow.dx,
                    dy: getTitleTextShadow.dy,
                    blurRadius: getTitleTextShadow.blurRadius,
                  )
                  .size(getTitleSize)
                  .make()
                  .oBox
                  .pOnly(
                    bottom: 12,
                    left: 16,
                    right: 16,
                    top: getShowIcon == null ? 12 : 0,
                  )
                  .color(getTitleBackgorundColor(context))
                  .width(context.screenWidth)
                  .make(),
            Column(
                  crossAxisAlignment: getCenterContent
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [16.height, ...getContentList, 40.height],
                ).oScrollV
                .make()
                .oBox
                .px(16)
                .color(getContentBackgorundColor(context))
                .width(context.screenWidth)
                .height(getContentList.isEmpty ? null : getContentHeight)
                .make(),
            getBottomWidget(
                  context,
                )?.oBox.color(getContentBackgorundColor(context)).make() ??
                SizedBox.shrink(),
          ],
        );
      },
    );
  }
}
