import 'package:flutter/material.dart';

abstract class OMapReactiveList {
  static Widget map({
    required bool value,
    required int listLength,
    required Widget loaded,
    Widget? empty,
    Widget? loading,
    String? loadingText,
    String? emtyText,
    Color? textColor,
    Color? circularProgressIndicatorColor,
    double? textSize,
    bool? isBold,
    bool? isEmptyExpand,
    bool? isLoadingExpand,
  }) {
    if (value) {
      //Eğer yükleme sürüyorsa - is loading
      return isLoadingExpand!
          ? Expanded(
              child: _buildCircularWidget(
                loading,
                loadingText,
                emtyText,
                textColor,
                textSize,
                isBold,
                empty,
                circularProgressIndicatorColor,
              ),
            )
          : _buildCircularWidget(
              loading,
              loadingText,
              emtyText,
              textColor,
              textSize,
              isBold,
              empty,
              circularProgressIndicatorColor,
            );
    } else if (listLength == 0) {
      // Eğer yükleme bitti ama liste boşsa -is Empty
      return isEmptyExpand!
          ? Expanded(
              child: _buildNoDataWidget(
                empty,
                emtyText,
                textColor,
                isBold,
                textSize,
              ),
            )
          : _buildNoDataWidget(empty, emtyText, textColor, isBold, textSize);
    } else {
      // Eğer yükleme bitti ve veriler varsa - is NotEmpty and isLoaded
      return loaded;
    }
  }

  static Center _buildNoDataWidget(
    Widget? empty,
    String? emtyText,
    Color? textColor,
    bool? isBold,
    double? textSize,
  ) {
    return Center(
      child:
          empty ??
          Text(
            emtyText ?? "Henüz veri yok",
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontWeight: isBold == true ? FontWeight.bold : FontWeight.normal,
              fontSize: textSize ?? 18,
            ),
          ),
    );
  }

  static Center _buildCircularWidget(
    Widget? loading,
    String? loadingText,
    String? emtyText,
    Color? emtyTextColor,

    double? emtyTextSize,
    bool? isBold,
    Widget? empty,
    Color? circularProgressIndicatorColor,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          loading ??
              CircularProgressIndicator(color: circularProgressIndicatorColor),
          SizedBox(height: 10),
          Text(
            loadingText ?? "Veriler yükleniyor...",
            style: TextStyle(
              color: emtyTextColor ?? Colors.white,
              fontWeight: isBold == true ? FontWeight.bold : FontWeight.normal,
              fontSize: emtyTextSize ?? 18,
            ),
          ),
        ],
      ),
    );
  }
}
