// ignore_for_file: unnecessary_null_comparison

/// **Model Extensions Kütüphanesi**
///
/// Bu kütüphane, Model sınıflarının fromMap/toMap işlemlerinde kullanılan
/// veri tipi dönüştürme extension'larını içerir.
///
/// **Ana Özellikler:**
/// - Bool ↔ Int dönüştürmeleri (SQLite uyumlu)
/// - Map tabanlı güvenli veri okuma
/// - Null safety desteği
/// - Esnek dönüştürme seçenekleri
///
/// **Kullanım Alanları:**
/// - Model sınıflarında fromMap/toMap işlemleri
/// - sqflite ile veritabanı işlemleri
/// - JSON API dönüştürmeleri
/// - Güvenli tip dönüştürmeleri
///
/// **Dosya adı:** `model_extensions.dart`
/// **Yazar:** Dart Developer
/// **Versiyon:** 1.0.0
/// **Son Güncelleme:** 2025
library;

import 'package:flutter/foundation.dart'; // debugPrint için

// =============================================================================
// BOOLEAN - INTEGER DÖNÜŞTÜRME EXTENSIONS
// =============================================================================

/// **Boolean → Integer Dönüştürücü**
///
/// SQLite boolean tipi desteklemediği için boolean değerler genellikle
/// integer olarak saklanır. Bu extension, boolean değerleri veritabanı
/// uyumlu integer formatına dönüştürür.
///
/// **Dönüştürme Kuralı:**
/// - `true` → `1`
/// - `false` → `0`
///
/// **Performans:** O(1) - Sabit zaman karmaşıklığı
///
/// **Örnek Kullanım:**
/// ```dart
/// // Temel kullanım
/// bool isCompleted = true;
/// int dbValue = isCompleted.toInt();  // 1
///
/// // Model sınıfında
/// Map<String, dynamic> toMap() => {
///   'id': id,
///   'title': title,
///   'isDone': isDone.toInt(),  // bool → int
/// };
/// ```
extension BoolToInt on bool {
  /// Bool değeri int'e çevirir
  ///
  /// **Kullanım:** `isDone.toInt()`
  /// **Return:** `1` (true) veya `0` (false)
  int toInt() => this ? 1 : 0;

  /// Bool değeri string olarak int'e çevirir
  ///
  /// **Kullanım:** `isActive.toIntString()`
  /// **Return:** `"1"` (true) veya `"0"` (false)
  String toIntString() => this ? "1" : "0";
}

/// **Integer → Boolean Dönüştürücü**
///
/// Veritabanından gelen integer değerleri boolean'a dönüştürür.
/// Strict dönüştürme kuralı kullanır - sadece 1 değeri true kabul edilir.
///
/// **Dönüştürme Kuralı:**
/// - `1` → `true`
/// - Diğer tüm değerler → `false`
///
/// **Güvenlik:** Type-safe dönüştürme
///
/// **Örnek Kullanım:**
/// ```dart
/// // Veritabanından gelen değer
/// int dbStatus = 1;
/// bool isActive = dbStatus.toBool();  // true
///
/// // Model sınıfında fromMap
/// factory User.fromMap(Map<String, dynamic> map) => User(
///   id: map['id'] as int,
///   name: map['name'] as String,
///   isActive: (map['isActive'] as int).toBool(),
/// );
/// ```
extension IntToBool on int {
  /// Int değeri bool'a çevirir (strict mode)
  ///
  /// **Kullanım:** `(map["isDone"] as int).toBool()`
  /// **Return:** Sadece `1` için `true`, diğerleri `false`
  bool toBool() => this == 1;

  /// Int değeri bool'a çevirir (flexible mode)
  ///
  /// **Kullanım:** `value.toBoolFlexible()`
  /// **Return:** `0` için `false`, diğer tüm değerler için `true`
  bool toBoolFlexible() => this != 0;
}

// =============================================================================
// NULLABLE BOOLEAN - INTEGER DÖNÜŞTÜRME EXTENSIONS
// =============================================================================

/// **Nullable Boolean → Integer Dönüştürücü**
///
/// Null olabilen boolean değerler için güvenli dönüştürme sağlar.
/// Null değerler varsayılan olarak false kabul edilir.
///
/// **Güvenlik Özellikleri:**
/// - Null kontrolü yapılır
/// - Varsayılan değer desteği
/// - Exception-safe işlem
///
/// **Örnek Kullanım:**
/// ```dart
/// bool? optionalFlag = null;
/// int result = optionalFlag.toIntForNullable();  // 0
///
/// // Custom default ile
/// int customResult = optionalFlag.toIntWithDefault(true);  // 1
/// ```
extension BoolToIntForNullable on bool? {
  /// Nullable bool'u int'e çevirir
  ///
  /// **Kullanım:** `isOptional.toIntForNullable()`
  /// **Return:** `1` (true), `0` (false veya null)
  int toIntForNullable() => (this ?? false) ? 1 : 0;

  /// Nullable bool'u custom default ile int'e çevirir
  ///
  /// **Kullanım:** `isOptional.toIntWithDefault(true)`
  /// **Return:** Null ise defaultValue, değilse normal dönüştürme
  int toIntWithDefault(bool defaultValue) => (this ?? defaultValue) ? 1 : 0;
}

/// **DateTime → Integer/String Dönüştürücü**
///
/// DateTime değerlerini veritabanında saklanabilir formatlara dönüştürür.
/// Farklı precision seviyeleri ve format seçenekleri sunar.
///
/// **Desteklenen Formatlar:**
/// - Milliseconds (en yaygın)
/// - Microseconds (yüksek precision)
/// - Seconds (Unix timestamp)
/// - ISO String format
///
/// **Örnek Kullanım:**
/// ```dart
/// DateTime now = DateTime.now();
///
/// // Farklı format seçenekleri
/// int milliseconds = now.toMilliseconds();    // 1693046400123
/// int microseconds = now.toMicroseconds();    // 1693046400123456
/// int seconds = now.toSeconds();              // 1693046400
/// String isoString = now.toISOString();       // "2025-08-26T10:30:00.123Z"
///
/// // Model sınıfında toMap
/// Map<String, dynamic> toMap() => {
///   'created_at': createdAt?.toMilliseconds(),
///   'updated_at': updatedAt?.toISOString(),
/// };
/// ```
extension DateTimeToStorage on DateTime? {
  /// DateTime'ı milliseconds timestamp'e çevirir
  ///
  /// **Kullanım:** `createdAt.toMilliseconds()`
  /// **Return:** null ise null, değilse milliseconds timestamp
  int? toMilliseconds() => this?.millisecondsSinceEpoch;

  /// DateTime'ı microseconds timestamp'e çevirir
  ///
  /// **Kullanım:** `preciseTime.toMicroseconds()`
  /// **Return:** null ise null, değilse microseconds timestamp
  int? toMicroseconds() => this?.microsecondsSinceEpoch;

  /// DateTime'ı seconds timestamp'e çevirir (Unix timestamp)
  ///
  /// **Kullanım:** `unixTime.toSeconds()`
  /// **Return:** null ise null, değilse seconds timestamp
  int? toSeconds() =>
      this != null ? (this!.millisecondsSinceEpoch ~/ 1000) : null;

  /// DateTime'ı ISO string formatına çevirir
  ///
  /// **Kullanım:** `isoDate.toISOString()`
  /// **Return:** null ise null, değilse ISO format string
  String? toISOString() => this?.toIso8601String();

  /// DateTime'ı UTC ISO string formatına çevirir
  ///
  /// **Kullanım:** `utcDate.toUTCString()`
  /// **Return:** null ise null, değilse UTC ISO format string
  String? toUTCString() => this?.toUtc().toIso8601String();
}

///
/// Null olabilen integer değerler için güvenli boolean dönüştürme.
/// Flexible ve strict mod seçenekleri sunar.
///
/// **Kullanım Senaryoları:**
/// - Optional database fields
/// - API response handling
/// - Default value management
///
/// **Örnek Kullanım:**
/// ```dart
/// int? dbValue = null;
/// bool result = dbValue.toBoolForNullable();  // false
///
/// // Custom default ile
/// bool customResult = dbValue.toBoolWithDefault(true);  // true
/// ```
extension IntToBoolForNullable on int? {
  /// Nullable int'i bool'a çevirir (strict mode)
  ///
  /// **Kullanım:** `(map["isDone"] as int?).toBoolForNullable()`
  /// **Return:** Sadece `1` için `true`, diğerleri ve null için `false`
  bool toBoolForNullable() => (this ?? 0) == 1;

  /// Nullable int'i bool'a çevirir (flexible mode)
  ///
  /// **Kullanım:** `value.toBoolFlexibleForNullable()`
  /// **Return:** `0` ve null için `false`, diğerleri için `true`
  bool toBoolFlexibleForNullable() => (this ?? 0) != 0;

  /// Custom default ile bool dönüştürme
  ///
  /// **Kullanım:** `value.toBoolWithDefault(true)`
  /// **Return:** Null ise defaultValue, değilse normal dönüştürme
  bool toBoolWithDefault(bool defaultValue) =>
      this == null ? defaultValue : (this! != 0);
}

// =============================================================================
// MAP GÜVENLI OKUMA EXTENSIONS
// =============================================================================

/// **Nullable Integer → Boolean Dönüştürücü**
///
/// Map<String, dynamic> tipindeki verilerden güvenli bir şekilde değer okuma
/// işlemleri için extension'lar. Null safety ve tip güvenliği sağlar.
///
/// **Güvenlik Özellikleri:**
/// - Automatic null checking
/// - Type safety
/// - Default value support
/// - Exception handling
///
/// **Kullanım Alanları:**
/// - JSON parsing
/// - Database result processing
/// - API response handling
/// - Configuration loading
///
/// **Örnek Kullanım:**
/// ```dart
/// Map<String, dynamic> userData = {
///   'id': 42,
///   'name': 'John Doe',
///   'email': 'john@example.com',
///   'isActive': 1,
///   'age': null,
/// };
///
/// // Güvenli okuma işlemleri
/// int id = userData.getInt('id');                    // 42
/// String name = userData.getString('name');          // 'John Doe'
/// String phone = userData.getString('phone', 'N/A'); // 'N/A' (key yok)
/// bool isActive = userData.intToBool('isActive');    // true
/// int age = userData.getInt('age', 18);              // 18 (null ise default)
/// ```
extension MapSafeReader on Map<String, dynamic> {
  // ---------------------------------------------------------------------------
  // TEMel VERİ TİPİ OKUMA METODLARı
  // ---------------------------------------------------------------------------

  /// Map'ten güvenli integer okuma
  ///
  /// **Parametreler:**
  /// - [key]: Okunacak anahtar
  /// - [defaultValue]: Key yoksa veya null ise döndürülecek değer
  ///
  /// **Return:** Integer değer veya defaultValue
  ///
  /// **Örnek:** `map.getInt('age', 0)`
  int getInt(String key, [int defaultValue = 0]) {
    final value = this[key];
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? defaultValue;
    if (value is double) return value.toInt();
    return defaultValue;
  }

  /// Map'ten güvenli string okuma
  ///
  /// **Parametreler:**
  /// - [key]: Okunacak anahtar
  /// - [defaultValue]: Key yoksa veya null ise döndürülecek değer
  ///
  /// **Return:** String değer veya defaultValue
  ///
  /// **Örnek:** `map.getString('name', 'Unknown')`
  String getString(String key, [String defaultValue = '']) {
    final value = this[key];
    if (value == null) return defaultValue;
    if (value is String) return value;
    return value.toString();
  }

  /// Map'ten güvenli double okuma
  ///
  /// **Parametreler:**
  /// - [key]: Okunacak anahtar
  /// - [defaultValue]: Key yoksa veya null ise döndürülecek değer
  ///
  /// **Return:** Double değer veya defaultValue
  ///
  /// **Örnek:** `map.getDouble('price', 0.0)`
  double getDouble(String key, [double defaultValue = 0.0]) {
    final value = this[key];
    if (value == null) return defaultValue;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  /// Map'ten güvenli boolean okuma
  ///
  /// **Parametreler:**
  /// - [key]: Okunacak anahtar
  /// - [defaultValue]: Key yoksa veya null ise döndürülecek değer
  ///
  /// **Return:** Boolean değer veya defaultValue
  ///
  /// **Örnek:** `map.getBool('isActive', false)`
  bool getBool(String key, [bool defaultValue = false]) {
    final value = this[key];
    if (value == null) return defaultValue;
    if (value is bool) return value;
    if (value is int) return value != 0;
    if (value is String) {
      final lower = value.toLowerCase();
      return lower == 'true' || lower == '1' || lower == 'yes';
    }
    return defaultValue;
  }

  // ---------------------------------------------------------------------------
  // NULLABLE VERİ TİPİ OKUMA METODLARı
  // ---------------------------------------------------------------------------

  /// Map'ten nullable integer okuma
  ///
  /// **Return:** Integer değer, null veya dönüştürülemezse null
  ///
  /// **Örnek:** `map.getIntNullable('age')`
  int? getIntNullable(String key) {
    final value = this[key];
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    if (value is double) return value.toInt();
    return null;
  }

  /// Map'ten nullable string okuma
  ///
  /// **Return:** String değer veya null
  ///
  /// **Örnek:** `map.getStringNullable('middleName')`
  String? getStringNullable(String key) {
    final value = this[key];
    if (value == null) return null;
    if (value is String) return value.isEmpty ? null : value;
    return value.toString();
  }

  /// Map'ten nullable double okuma
  ///
  /// **Return:** Double değer veya null
  ///
  /// **Örnek:** `map.getDoubleNullable('discount')`
  double? getDoubleNullable(String key) {
    final value = this[key];
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  // ---------------------------------------------------------------------------
  // BOOLEAN - INTEGER DÖNÜŞTÜRME METODLARı
  // ---------------------------------------------------------------------------

  /// Map'ten integer değeri boolean'a çevirir (strict mode)
  ///
  /// **Dönüştürme:** `1` → `true`, diğerleri → `false`
  ///
  /// **Örnek:** `map.getBoolFromInt('isActive')`
  bool getBoolFromInt(String key, {bool defaultValue = false}) {
    final value = this[key];
    if (value == null) return defaultValue;
    if (value is int) return value == 1;
    if (value is bool) return value;
    return defaultValue;
  }

  /// Map'ten integer değeri boolean'a çevirir (flexible mode)
  ///
  /// **Dönüştürme:** `0` → `false`, diğerleri → `true`
  ///
  /// **Örnek:** `map.getBoolFromIntFlexible('count')`
  bool getBoolFromIntFlexible(String key, {bool defaultValue = false}) {
    final value = this[key];
    if (value == null) return defaultValue;
    if (value is int) return value != 0;
    if (value is bool) return value;
    return defaultValue;
  }

  /// Map'ten boolean değeri integer'a çevirir
  ///
  /// **Dönüştürme:** `true` → `1`, `false` → `0`
  ///
  /// **Örnek:** `map.getIntFromBool('isEnabled')`
  int getIntFromBool(String key, {int defaultValue = 0}) {
    final value = this[key];
    if (value == null) return defaultValue;
    if (value is bool) return value ? 1 : 0;
    if (value is int) return value != 0 ? 1 : 0;
    return defaultValue;
  }

  // ---------------------------------------------------------------------------
  // GERİYE UYUMLULUK İÇİN ESKİ İSİMLER (DEPRECATED)
  // ---------------------------------------------------------------------------

  /// @deprecated Use getBoolFromInt instead
  bool intToBool(String key, {bool defaultValue = false}) =>
      getBoolFromInt(key, defaultValue: defaultValue);

  /// @deprecated Use getBoolFromIntFlexible instead
  bool intToBoolFlexible(String key, {bool defaultValue = false}) =>
      getBoolFromIntFlexible(key, defaultValue: defaultValue);

  /// @deprecated Use getIntFromBool instead
  int boolToInt(String key, {int defaultValue = 0}) =>
      getIntFromBool(key, defaultValue: defaultValue);

  // ---------------------------------------------------------------------------
  // DATETIME DÖNÜŞTÜRME METODLARı
  // ---------------------------------------------------------------------------

  /// Map'ten int timestamp'i DateTime'a çevirir (milliseconds)
  ///
  /// **Dönüştürme:** timestamp (ms) → DateTime
  ///
  /// **Örnek:** `map.getDateTimeFromMilliseconds('created_at')`
  DateTime? getDateTimeFromMilliseconds(String key) {
    final value = this[key];
    if (value == null) return null;
    if (value is int) {
      try {
        return DateTime.fromMillisecondsSinceEpoch(value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Map'ten int timestamp'i DateTime'a çevirir (microseconds)
  ///
  /// **Dönüştürme:** timestamp (μs) → DateTime
  ///
  /// **Örnek:** `map.getDateTimeFromMicroseconds('precise_time')`
  DateTime? getDateTimeFromMicroseconds(String key) {
    final value = this[key];
    if (value == null) return null;
    if (value is int) {
      try {
        return DateTime.fromMicrosecondsSinceEpoch(value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Map'ten ISO string'i DateTime'a çevirir
  ///
  /// **Dönüştürme:** "2025-08-26T10:30:00.000Z" → DateTime
  ///
  /// **Örnek:** `map.getDateTimeFromISOString('updated_at')`
  DateTime? getDateTimeFromISOString(String key) {
    final value = this[key];
    if (value == null) return null;
    if (value is String && value.isNotEmpty) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Map'ten int timestamp'i DateTime'a çevirir (seconds - Unix timestamp)
  ///
  /// **Dönüştürme:** timestamp (s) → DateTime
  ///
  /// **Örnek:** `map.getDateTimeFromSeconds('unix_time')`
  DateTime? getDateTimeFromSeconds(String key) {
    final value = this[key];
    if (value == null) return null;
    if (value is int) {
      try {
        return DateTime.fromMillisecondsSinceEpoch(value * 1000);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Map'ten otomatik DateTime dönüştürme (smart detection)
  ///
  /// **Dönüştürme:** Otomatik format algılama
  /// - Int ise: milliseconds olarak kabul eder
  /// - String ise: ISO format parse eder
  ///
  /// **Örnek:** `map.getDateTimeSmart('any_date_field')`
  DateTime? getDateTimeSmart(String key) {
    final value = this[key];
    if (value == null) return null;

    if (value is int) {
      // Timestamp büyüklüğüne göre format algıla
      if (value > 1000000000000000) {
        // Microseconds (16+ digits)
        return getDateTimeFromMicroseconds(key);
      } else if (value > 1000000000000) {
        // Milliseconds (13+ digits)
        return getDateTimeFromMilliseconds(key);
      } else {
        // Seconds (10 digits)
        return getDateTimeFromSeconds(key);
      }
    }

    if (value is String && value.isNotEmpty) {
      return getDateTimeFromISOString(key);
    }

    return null;
  }

  // ---------------------------------------------------------------------------
  // KONTROL VE YARDIMCI METODLARı
  // ---------------------------------------------------------------------------

  /// Key'in var olup olmadığını ve null olmadığını kontrol eder
  ///
  /// **Return:** Key mevcut ve null değilse true
  ///
  /// **Örnek:** `map.hasValue('email')`
  bool hasValue(String key) {
    return containsKey(key) && this[key] != null;
  }

  /// Key'in var olup olmadığını kontrol eder (null olsa bile)
  ///
  /// **Return:** Key mevcut ise true
  ///
  /// **Örnek:** `map.hasKey('optionalField')`
  bool hasKey(String key) {
    return containsKey(key);
  }

  /// Belirtilen tip kontrolü yapar
  ///
  /// **Örnek:** `map.isType<int>('age')`
  bool isType<T>(String key) {
    return hasValue(key) && this[key] is T;
  }
}

// =============================================================================
// KULLANIM ÖRNEKLERİ VE TEST KODLARI
// =============================================================================

/// **Örnek Model Sınıfı - Todo**
///
/// Bu örnek, tüm extension'ların gerçek bir projede nasıl kullanılacağını
/// gösterir. Best practices ve güvenli kodlama teknikleri içerir.
class TodoExample {
  final int? id;
  final String title;
  final String? content;
  final bool isDone;
  final bool? isImportant;
  final double? priority;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TodoExample({
    this.id,
    required this.title,
    this.content,
    required this.isDone,
    this.isImportant,
    this.priority,
    this.createdAt,
    this.updatedAt,
  });

  /// **Veritabanından veri okuma (fromMap)**
  ///
  /// Extension'ları kullanarak güvenli veri okuma örneği
  factory TodoExample.fromMap(Map<String, dynamic> map) {
    return TodoExample(
      // Temel tipler - güvenli okuma
      id: map.getIntNullable('id'),
      title: map.getString('title', 'Untitled'),
      content: map.getStringNullable('content'),

      // Boolean dönüştürmeleri
      isDone: map.getBoolFromInt('isDone'), // ✨ Yeni tutarlı isim
      isImportant: map.hasValue('isImportant')
          ? map.getBoolFromInt('isImportant')
          : null, // nullable bool
      // Numeric değerler
      priority: map.getDoubleNullable('priority'),

      // DateTime dönüştürme
      createdAt: map.getDateTimeSmart('created_at'), // ✨ Smart datetime okuma
      updatedAt: map.getDateTimeFromMilliseconds(
        'updated_at',
      ), // ✨ Milliseconds'tan DateTime
    );
  }

  /// **Veritabanına veri yazma (toMap)**
  ///
  /// Extension'ları kullanarak veri hazırlama örneği
  Map<String, dynamic> toMap() {
    return {
      // ID sadece güncelleme işlemlerinde
      if (id != null) 'id': id,

      // Temel string değerler
      'title': title,
      if (content != null) 'content': content,

      // Boolean dönüştürmeleri
      'isDone': isDone.toInt(), // bool → int
      if (isImportant != null)
        'isImportant': isImportant!.toInt(), // nullable bool → int
      // Numeric değerler
      if (priority != null) 'priority': priority,

      // DateTime dönüştürme - farklı format seçenekleri
      if (createdAt != null)
        'created_at': createdAt!.toMilliseconds(), // ✨ DateTime → milliseconds
      if (updatedAt != null)
        'updated_at': updatedAt!.toMicroseconds(), // ✨ DateTime → microseconds
    };
  }

  /// **Debug için string representation**
  @override
  String toString() {
    return 'Todo(id: $id, title: $title, isDone: $isDone, isImportant: $isImportant)';
  }
}

/// **Test Fonksiyonları**
///
/// Extension'ların doğru çalışıp çalışmadığını test eden örnek kodlar
///
/// **Not:** Flutter projelerde `debugPrint` kullanılır çünkü:
/// - Release mode'da otomatik olarak optimize edilir
/// - Büyük çıktıları parçalara böler (performance)
/// - Debug build'lerde güvenli şekilde çalışır
void runExtensionTests() {
  debugPrint('=== MODEL EXTENSIONS TEST SUITE ===\n');

  // Test verisi
  Map<String, dynamic> testData = {
    'id': 42,
    'title': 'Test Todo',
    'content': 'This is a test content',
    'isDone': 1,
    'isImportant': 0,
    'priority': 5.5,
    'created_at': DateTime.now().millisecondsSinceEpoch,
    'nullField': null,
    'stringNumber': '123',
    'boolValue': true,
  };

  debugPrint('📊 Test Data:');
  testData.forEach(
    (key, value) => debugPrint('  $key: $value (${value.runtimeType})'),
  );
  // DateTime testi
  debugPrint('📅 DateTime Extensions:');
  DateTime now = DateTime.now();
  debugPrint('  now.toMilliseconds() = ${now.toMilliseconds()}');
  debugPrint('  now.toMicroseconds() = ${now.toMicroseconds()}');
  debugPrint('  now.toSeconds() = ${now.toSeconds()}');
  debugPrint('  now.toISOString() = ${now.toISOString()}');
  debugPrint(
    '  testData.getDateTimeSmart("created_at") = ${testData.getDateTimeSmart("created_at")}',
  );
  debugPrint('');

  // Boolean - Integer extension testleri
  debugPrint('🔄 Boolean ↔ Integer Extensions:');
  debugPrint('  true.toInt() = ${true.toInt()}');
  debugPrint('  false.toInt() = ${false.toInt()}');
  debugPrint('  1.toBool() = ${1.toBool()}');
  debugPrint('  0.toBool() = ${0.toBool()}');
  debugPrint('  2.toBool() = ${2.toBool()}');
  debugPrint('  2.toBoolFlexible() = ${2.toBoolFlexible()}');
  debugPrint('');

  // Nullable extension testleri
  debugPrint('🔄 Nullable Extensions:');
  bool? nullBool;
  int? nullInt = null;
  debugPrint(
    '  null(bool).toIntForNullable() = ${nullBool.toIntForNullable()}',
  );
  debugPrint(
    '  null(int).toBoolForNullable() = ${nullInt.toBoolForNullable()}',
  );
  debugPrint('');

  // Map okuma testleri
  debugPrint('📖 Map Safe Reading Extensions:');
  debugPrint('  getInt("id") = ${testData.getInt("id")}');
  debugPrint('  getString("title") = ${testData.getString("title")}');
  debugPrint(
    '  getString("missing", "default") = ${testData.getString("missing", "default")}',
  );
  debugPrint(
    '  getBoolFromInt("isDone") = ${testData.getBoolFromInt("isDone")}',
  );
  debugPrint(
    '  getBoolFromInt("isImportant") = ${testData.getBoolFromInt("isImportant")}',
  );
  debugPrint('  getDouble("priority") = ${testData.getDouble("priority")}');
  debugPrint('  hasValue("nullField") = ${testData.hasValue("nullField")}');
  debugPrint('  hasKey("nullField") = ${testData.hasKey("nullField")}');
  debugPrint('');

  // Model testi
  debugPrint('🏗️ Model Creation Test:');
  TodoExample todo = TodoExample.fromMap(testData);
  debugPrint('  Created Todo: $todo');

  Map<String, dynamic> todoMap = todo.toMap();
  debugPrint('  Todo to Map: $todoMap');
  debugPrint('');

  debugPrint('✅ All tests completed successfully!');
}
