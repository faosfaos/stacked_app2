import 'package:flutter/material.dart';

import '../o_extensions_class/o_dropdown_bottom.dart';
import '../o_extensions_class/o_map_reactiv_list.dart';

extension MyListExtensions on List {
  ODropDownBottom get oDropDownBottom => ODropDownBottom(this);

  //!Açıklama
  /// **Reactive bir veri türünün durumuna göre bir widget döndüren metot.**
  ///
  /// **[value]**
  /// - Veriler yüklenirken kontrol edilir.
  /// - Zorunludur
  /// - Veri türü reactive ve bool olmalıdır.
  ///
  /// **[loaded]**
  /// - Veriler yüklendiğinde gösterilecek widget.
  /// - Zorunludur
  ///
  /// **[empty]**
  /// - Veriler boş olduğunda gösterilecek widget.
  /// - Zorunlu değildir.
  ///
  /// **[loading]**
  /// - Veriler yüklenirken gösterilecek widget.
  /// - Zorunlu değildir.
  ///
  /// **[loadingText]**
  /// - Veriler yüklenirken gösterilecek yazı.
  /// - Zorunlu değildir.
  /// - Varsayılan: "Veriler yükleniyor..."
  ///
  /// **[emtyText]**
  /// - Veriler boş olduğunda gösterilecek yazı.
  /// - Zorunlu değildir.
  /// - Varsayılan: "Veriler yok"
  ///
  /// **[textColor]**
  /// - Yazı rengi.
  /// - Zorunlu değildir.
  /// - Varsayılan: Colors.white
  ///
  /// **[circularProgressIndicatorColor]**
  /// - CircularProgressIndicator rengi.
  /// - Zorunlu değildir.
  /// - Varsayılan: Temanın ana rengi
  /// **[textSize]**
  /// - Yazı boyutu.
  /// - Zorunlu değildir.
  /// - Varsayılan 18
  ///
  /// **[isBold]**
  /// - Yazı kalınlıgı.
  /// - Zorunlu değildir.
  /// - Varsayılan: false
  ///
  /// **[isEmptyExpand]**
  /// - Veriler boş olduğunda, widget'  genişletilip genişletilmeyeceğini kontrol eder.
  /// - Zorunlu değildir.
  /// - Varsayılan: true.
  ///
  /// **[isLoadingExpand]**
  /// - Veriler yüklenirken, widget'  genişletilip genişletilmeyeceğini kontrol eder.
  /// - Zorunlu değildir.
  /// - Varsayılan: true.
  ///
  ///
  /// ***ÖRNEK KULLANIM:***
  /// ```dart
  /// final controller = Get.find<ControllerHomePage>();
  /// Obx(() {
  ///   return controller.myList.mapReactiveList(
  ///       value: controller.isLoad.value,//zorunlu
  ///       loading:  _yukleniyorken(),//zorunlu
  ///   );
  /// });
  ///
  /// class ControllerHomePage extends GetxController {
  ///   RxList<Model> myList = <Model>[].obs;
  ///   RxBool isLoad = true.obs;
  ///
  ///   @override
  ///   void onInit() {
  ///     super.onInit();
  ///     getData(); //getData() cagriliyor
  ///   }
  ///
  ///   Future<void> getData() async {
  ///     isLoad.value = true;//Yukleniyor
  ///     myList.value = await db.getDataList(); // Veriler bekleniyor
  ///     isLoad.value = false; // Yukleme tamamlandi
  ///   }
  ///}
  ///
  ///```
  ///
  Widget mapReactiveList({
    required bool value,
    required Widget loaded,
    Widget? empty,
    Widget? loading,
    String? loadingText,
    String? emtyText,
    Color? textColor,
    Color? circularProgressIndicatorColor,
    double? textSize,
    bool? isBold,
    bool isEmptyExpand = true,
    bool isLoadingExpand = true,
  }) => OMapReactiveList.map(
    listLength: length,
    //this.length
    value: value,
    //bool
    loading: loading,
    loaded: loaded,
    empty: empty,
    loadingText: loadingText,
    emtyText: emtyText,
    textColor: textColor,
    textSize: textSize,
    isBold: isBold,
    isEmptyExpand: isEmptyExpand,
    isLoadingExpand: isLoadingExpand,
    circularProgressIndicatorColor: circularProgressIndicatorColor,
  );
}
