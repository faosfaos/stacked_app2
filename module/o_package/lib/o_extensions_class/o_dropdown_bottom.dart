import 'package:flutter/material.dart';

class ODropDownBottom {
  final List _list;
  ODropDownBottom(this._list);

  Widget make({
    String? hintText,
    Color? hintTextColor,
    Color? dropdownColor,
    Color? textColor,
    Color? focusColor,
    Color? iconDisabledColor,
    Color? iconEnabledColor,
    double? hinTextSize,
    AlignmentGeometry? alignmentGeometry,
    AlignmentGeometry? textAlignmentGeometry,
    double? textSize,
    bool? textBold,
    bool? hintTextBold,
    double? borderRadius,
    double? iconSize,
    double? menuMaxHeight,
    double? itemHeight,
    bool? autofouc,
    bool? isExpanded,
    bool? enableFeedback,
    bool? isDense,
    Widget? icon,
    Widget? disabledHint,
    Widget? underline,
    Widget? textIcon,
    int? elevation,
    EdgeInsets? padding,
    TextStyle? style,
    FocusNode? focusNode,
    MainAxisAlignment? textIconMainAxisAlignment,
    Key? itemKey,
    Key? key,
    required dynamic value,
    required void Function(dynamic selectedValue) onChange,
    void Function()? onTap,
    List<Widget> Function(BuildContext context)? selectedItemBuilder,
  }) {
    return DropdownButton(
      key: key,
      autofocus: autofouc ?? false,
      icon: icon,
      iconSize: iconSize ?? 24.0,
      isExpanded: isExpanded ?? false,
      menuMaxHeight: menuMaxHeight,
      elevation: elevation ?? 0,
      onTap: onTap,
      itemHeight: itemHeight == null
          ? kMinInteractiveDimension
          : itemHeight <= kMinInteractiveDimension
          ? kMinInteractiveDimension
          : itemHeight,
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      padding: padding,
      disabledHint: disabledHint,
      style: style,
      focusColor: focusColor,
      focusNode: focusNode,
      enableFeedback: enableFeedback,
      iconDisabledColor: iconDisabledColor,
      iconEnabledColor: iconEnabledColor,
      isDense: isDense ?? false,
      selectedItemBuilder: selectedItemBuilder,
      underline: underline,
      dropdownColor: dropdownColor,
      value: value,
      alignment: alignmentGeometry ?? const Alignment(0, 0),
      hint: Text(
        hintText ?? "",
        style: TextStyle(
          color: hintTextColor,
          fontSize: hinTextSize,
          fontWeight: hintTextBold ?? false
              ? FontWeight.bold
              : FontWeight.normal,
        ),
      ),
      items: _list.map((item) {
        return DropdownMenuItem(
          alignment: textAlignmentGeometry ?? const Alignment(0, 0),
          value: item,
          key: itemKey,
          child: textIcon == null
              ? Text(
                  item.toString(),
                  style: TextStyle(
                    color: textColor,
                    fontSize: textSize,
                    fontWeight: textBold ?? false
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                )
              : Row(
                  mainAxisAlignment:
                      textIconMainAxisAlignment ?? MainAxisAlignment.center,
                  children: [
                    textIcon,
                    Text(
                      item.toString(),
                      style: TextStyle(
                        color: textColor,
                        fontSize: textSize,
                        fontWeight: textBold ?? false
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
        );
      }).toList(),
      onChanged: (value) {
        value = value;
        onChange(value);
      },
    );
  }
}
