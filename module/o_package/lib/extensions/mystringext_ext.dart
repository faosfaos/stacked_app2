import 'package:flutter/material.dart';
import '/o_extensions_class/o_elevated_button.dart';

import '../o_extensions_class/o_box.dart';
import '../o_extensions_class/o_floating_actions_button.dart';
import '../o_extensions_class/o_text.dart';
import 'mylistwidgetextesions_ext.dart';

extension MyStringExt on String {
  int get toInt => int.parse(this);

  double get toDouble => double.parse(this);

  /// Bir``` DateTime nesnesini ```   Türkçe formatlı bir tarih string'ine dönüştürür.
  ///
  /// [pattern]: Tarih string'ini bölmek için kullanılacak ayraç. Varsayılan değer `"-"`.
  /// [saatGoster]: Saati de göstermek isteniyorsa `true` olmalıdır. Varsayılan değer `false`.
  /// [tarihiFullGoster]: Tarih 4 basamak göstermek için `true` olmalıdır. Varsayılan değer `false`.
  ///
  /// Örnek Kullanım:
  /// ```dart
  /// DateTime.now().toString().toTurkishDate(); // Çıktı: "Gün Ay Yıl - Saat:Dakika"
  /// "15-08-2023 14:30".toTurkishDate(saatGoster: true); // Çıktı: "15 Ağustos 2023 14:30"
  /// "15-08-2023".toTurkishDate(); // Çıktı: "15 Ağustos 2023"
  /// ```
  String toTurkishDate({
    bool saatGoster = false,
    bool tarihiFullGoster = false,
    String pattern = "-",
  }) => toDateTime(
    split(" ")[0],
    pattern,
    split(" ")[1],
    saatGoster,
    tarihiFullGoster,
  );

  OElevatedButton get oElevatedButton => OElevatedButton(this);

  OTextButton get oTextButton => OTextButton(this);

  OText get oText => OText(this);

  OFloatinActionButton get oFloatingActBtn => OFloatinActionButton(Text(this));

  OBox get oBox => OBox(Text(this));

  bool get isEmail {
    // Eğer email null ise veya boş bir string ise geçersiz kabul et
    if (isEmpty) return false;

    // E-posta formatını kontrol etmek için regex deseni
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    // Regex ile eşleşme kontrolü yap
    return emailRegex.hasMatch(this);
  }
}
