// ignore_for_file: constant_identifier_names
enum COLLATEE { localized, nocase, binary }

/// SQLRaw sınıfı, SQL sorgularını zincirleme olarak oluşturmak için kullanılır.
///
/// Bu sınıf, SELECT, FROM, JOIN, WHERE, ORDER BY, LIMIT ve OFFSET gibi SQL komutlarını destekler.
/// Her metot, sınıfın kendisini (`this`) döndürerek zincirleme kullanım sağlar.
class SQLRawMap {
  String _query = "";
  List<dynamic> _whereArgs = [];
  bool _hasWhere = false;

  /// SELECT ifadesini ekler.
  ///
  /// [select]: Seçilecek sütunların virgülle ayrılmış listesi. Eğer null ise, "*" (tüm sütunlar) seçilir.
  ///
  /// **Kullanım Sırası:**
  /// - SELECT, bir SQL sorgusunun genellikle ilk adımıdır.
  /// - FROM ifadesinden önce gelmelidir.
  ///
  /// **Kısıtlamalar:**
  /// - SELECT olmadan FROM kullanılamaz.
  /// - DISTINCT, SELECT ile birlikte kullanılabilir.
  ///
  /// **Örnekler:**
  /// ```dart
  /// // Tüm sütunları seçme
  /// SQLRaw sql1 = SQLRaw().select(null); // SELECT *
  ///
  /// // Belirli sütunları seçme
  /// SQLRaw sql2 = SQLRaw().select("name, age"); // SELECT name, age
  ///
  /// // Tek bir sütun seçme
  /// SQLRaw sql3 = SQLRaw().select("id"); // SELECT id
  ///
  /// // Alt sorgu ile sütun seçme
  /// SQLRaw sql4 = SQLRaw().select("(SELECT COUNT(*) FROM orders) AS order_count"); // SELECT (SELECT COUNT(*) FROM orders) AS order_count
  /// ```
  SQLRawMap select(String? select, {COLLATEE? collate}) {
    _query +=
        "SELECT ${select ?? "*"} ${collate != null ? "COLLATE ${collate.name} " : ""}";
    return this;
  }

  /// DISTINCT ifadesini ekler.
  ///
  /// DISTINCT, tekrar eden satırları filtrelemek için kullanılır.
  ///
  /// **Kullanım Sırası:**
  /// - DISTINCT, SELECT ifadesinin hemen ardından gelmelidir.
  /// - FROM, WHERE, GROUP BY gibi diğer ifadelerden önce gelmelidir.
  ///
  /// **Kısıtlamalar:**
  /// - DISTINCT, SELECT olmadan kullanılamaz.
  /// - DISTINCT, yalnızca SELECT ifadesindeki sütunlar üzerinde çalışır.
  ///
  /// **Örnekler:**
  /// ```dart
  /// // Tekrar eden şehirleri filtreleme
  /// SQLRaw sql1 = SQLRaw().select("sehir").distinct(); // SELECT DISTINCT sehir
  /// ```
  SQLRawMap distinct() {
    _query = _query.replaceFirst("SELECT", "SELECT DISTINCT");
    return this;
  }

  /// FROM ifadesini ekler.
  ///
  /// [from]: Verilerin çekileceği tablo adı.
  ///
  /// **Kullanım Sırası:**
  /// - FROM, SELECT'ten sonra gelmelidir.
  /// - JOIN, WHERE, ORDER BY gibi diğer ifadelerden önce gelmelidir.
  ///
  /// **Kısıtlamalar:**
  /// - FROM olmadan JOIN veya WHERE kullanılamaz.
  /// - FROM, bir SQL sorgusunda en az bir kez kullanılmalıdır.
  ///
  /// **Örnekler:**
  /// ```dart
  /// // Tek bir tablodan veri çekme
  /// SQLRaw sql1 = SQLRaw().from("users"); // FROM users
  ///
  /// // Alt sorgu ile tablo belirtme
  /// SQLRaw sql2 = SQLRaw().from("(SELECT * FROM active_users) AS active_users"); // FROM (SELECT * FROM active_users) AS active_users
  /// ```
  SQLRawMap from(String table) {
    _query += "FROM $table ";
    return this;
  }

  /// INNER JOIN ifadesini ekler.
  ///
  /// [table]: Birleştirilecek tablo adı.
  /// [onCondition]: İki tabloyu birleştirmek için kullanılacak koşul.
  ///
  /// **Kullanım Sırası:**
  /// - JOIN, FROM'dan sonra gelmelidir.
  /// - WHERE, GROUP BY, ORDER BY gibi ifadelerden önce gelmelidir.
  ///
  /// **Kısıtlamalar:**
  /// - JOIN olmadan WHERE veya ORDER BY kullanılamaz.
  /// - JOIN, birleştirme koşulu olmadan kullanılamaz.
  ///
  /// **Örnekler:**
  /// ```dart
  /// SQLRaw sql1 = SQLRaw()
  ///   .select("kullanicilar.ad, siparisler.urun")
  ///   .from("kullanicilar")
  ///   .innerJoin("siparisler", "kullanicilar.id = siparisler.kullanici_id");
  /// // Çıktı: SELECT kullanicilar.ad, siparisler.urun FROM kullanicilar INNER JOIN siparisler ON kullanicilar.id = siparisler.kullanici_id
  /// ```
  SQLRawMap innerJoin(String table, String onCondition) {
    _query += "INNER JOIN $table ON $onCondition ";
    return this;
  }

  /// LEFT JOIN (LEFT OUTER JOIN) ifadesini ekler.
  ///
  /// [table]: Birleştirilecek tablo adı.
  /// [onCondition]: İki tabloyu birleştirmek için kullanılacak koşul.
  ///
  /// **Kullanım Sırası:**
  /// - JOIN, FROM'dan sonra gelmelidir.
  /// - WHERE, GROUP BY, ORDER BY gibi ifadelerden önce gelmelidir.
  ///
  /// **Örnekler:**
  /// ```dart
  /// SQLRaw sql1 = SQLRaw()
  ///   .select("kullanicilar.ad, siparisler.urun")
  ///   .from("kullanicilar")
  ///   .leftJoin("siparisler", "kullanicilar.id = siparisler.kullanici_id");
  /// // Çıktı: SELECT kullanicilar.ad, siparisler.urun FROM kullanicilar LEFT JOIN siparisler ON kullanicilar.id = siparisler.kullanici_id
  /// ```
  SQLRawMap leftJoin(String table, String onCondition) {
    _query += "LEFT JOIN $table ON $onCondition ";
    return this;
  }

  /// CROSS JOIN ifadesini ekler.
  ///
  /// [table]: Birleştirilecek tablo adı.
  ///
  /// **Kullanım Sırası:**
  /// - JOIN, FROM'dan sonra gelmelidir.
  /// - WHERE, GROUP BY, ORDER BY gibi ifadelerden önce gelmelidir.
  ///
  /// **Örnekler:**
  /// ```dart
  /// SQLRaw sql1 = SQLRaw()
  ///   .select("kullanicilar.ad, sehirler.sehir_adi")
  ///   .from("kullanicilar")
  ///   .crossJoin("sehirler");
  /// // Çıktı: SELECT kullanicilar.ad, sehirler.sehir_adi FROM kullanicilar CROSS JOIN sehirler
  /// ```
  SQLRawMap crossJoin(String table) {
    _query += "CROSS JOIN $table ";
    return this;
  }

  /// WHERE koşulunu ekler.
  ///
  /// [conditions]: Koşulların bir listesi.
  /// [operator]: Koşullar arasında kullanılacak mantıksal operatör ("AND" veya "OR").
  ///
  /// **Kullanım Sırası:**
  /// - WHERE, FROM'dan sonra gelmelidir.
  /// - GROUP BY, ORDER BY gibi ifadelerden önce gelmelidir.
  ///
  /// **Kısıtlamalar:**
  /// - WHERE olmadan GROUP BY veya ORDER BY kullanılamaz.
  ///
  /// **Örnekler:**
  /// ```dart
  /// // Basit WHERE koşulu
  /// SQLRaw sql1 = SQLRaw().where(["age > 18"]); // WHERE age > 18
  ///
  /// // Birden fazla koşul ile WHERE
  /// SQLRaw sql2 = SQLRaw().where(["age > 18", "city = 'Ankara'"], operator: "AND"); // WHERE age > 18 AND city = 'Ankara'
  /// ```
  SQLRawMap whereList(
    List<String> conditions, {
    String operator = "AND",
    COLLATEE? collate,
  }) {
    if (conditions.isNotEmpty) {
      _query +=
          "WHERE ${conditions.join(" $operator ")} ${collate != null ? "COLLATE ${collate.name} " : ""} ";
    }
    return this;
  }

  /// WHERE koşulunu ekler.
  ///
  /// [conditions]: Koşulların bir string'i.
  ///
  /// **Kullanım Sırası:**
  /// - WHERE, FROM'dan sonra gelmelidir.
  /// - GROUP BY, ORDER BY gibi ifadelerden önce gelmelidir.
  ///
  /// **Kısıtlamalar:**
  /// - WHERE olmadan GROUP BY veya ORDER BY kullanılamaz.
  ///
  /// **Örnekler:**
  /// ```dart
  /// // Basit WHERE koşulu
  /// SQLRaw sql1 = SQLRaw().where("age > 18"); // WHERE age > 18
  /// ```
  SQLRawMap where(String conditions, {COLLATEE? collate}) {
    if (_hasWhere) {
      throw Exception("where() already called. Use another chain or reset.");
    }
    _query +=
        "WHERE $conditions ${collate != null ? "COLLATE ${collate.name} " : ""} ";
    _hasWhere = true;
    return this;
  }

  /// WHERE koşulu için parametreleri ekler.
  ///
  /// [args]: Koşullardaki yer tutuculara (`?`) karşılık gelen değerlerin listesi.
  ///
  /// **Kullanım Sırası:**
  /// - whereArgs, where() metodundan sonra çağrılmalıdır.
  ///
  /// **Kısıtlamalar:**
  /// - whereArgs, where() olmadan kullanılamaz.
  ///
  /// **Örnekler:**
  /// ```dart
  /// SQLRaw sql1 = SQLRaw()
  ///   .select("*")
  ///   .from("kullanicilar")
  ///   .where("id = ? AND ad = ?")
  ///   .whereArgs([1, "Ahmet"]);
  /// // Çıktı: SELECT * FROM kullanicilar WHERE id = ? AND ad = ?
  /// // Parametreler: [1, "Ahmet"]
  /// ```
  SQLRawMap whereArgs(List<dynamic> args) {
    if (!_hasWhere) {
      throw Exception("Call where() before whereArgs().");
    }
    _whereArgs.addAll(args);
    return this;
  }

  /// LIKE koşulunu ekler.
  ///
  /// [column]: Arama yapılacak sütun.
  /// [pattern]: Aranacak desen (örneğin, '%Ahmet%').
  ///
  /// **Kullanım Sırası:**
  /// - LIKE, WHERE'den sonra gelmelidir.
  ///
  /// **Örnekler:**
  /// ```dart
  /// SQLRaw sql1 = SQLRaw()
  ///   .select("*")
  ///   .from("kullanicilar")
  ///   .where("ad LIKE ?")
  ///   .whereArgs(["%Ahmet%"]);
  /// // Çıktı: SELECT * FROM kullanicilar WHERE ad LIKE '%Ahmet%'
  /// ```
  SQLRawMap like(String column, String pattern) {
    _query += " AND $column LIKE '$pattern' ";
    return this;
  }

  /// GROUP BY ifadesini ekler.
  ///
  /// [column]: Gruplanacak sütun adı.
  ///
  /// **Kullanım Sırası:**
  /// - GROUP BY, WHERE'den sonra gelmelidir.
  /// - HAVING, ORDER BY gibi ifadelerden önce gelmelidir.
  ///
  /// **Örnekler:**
  /// ```dart
  /// SQLRaw sql1 = SQLRaw()
  ///   .select("sehir, COUNT(*) AS kullanici_sayisi")
  ///   .from("kullanicilar")
  ///   .groupBy("sehir");
  /// // Çıktı: SELECT sehir, COUNT(*) AS kullanici_sayisi FROM kullanicilar GROUP BY sehir
  /// ```
  SQLRawMap groupBy(String column, {COLLATEE? collate}) {
    _query +=
        "GROUP BY $column ${collate != null ? "COLLATE ${collate.name} " : ""} ";
    return this;
  }

  /// HAVING koşulunu ekler.
  ///
  /// [condition]: Gruplanmış veriler üzerinde uygulanacak koşul.
  ///
  /// **Kullanım Sırası:**
  /// - HAVING, GROUP BY'den sonra gelmelidir.
  /// - ORDER BY'den önce gelmelidir.
  ///
  /// **Örnekler:**
  /// ```dart
  /// SQLRaw sql1 = SQLRaw()
  ///   .select("sehir, COUNT(*) AS kullanici_sayisi")
  ///   .from("kullanicilar")
  ///   .groupBy("sehir")
  ///   .having("COUNT(*) > 2");
  /// // Çıktı: SELECT sehir, COUNT(*) AS kullanici_sayisi FROM kullanicilar GROUP BY sehir HAVING COUNT(*) > 2
  /// ```
  SQLRawMap having(String condition) {
    _query += "HAVING $condition ";
    return this;
  }

  /// ORDER BY ifadesini ekler.
  ///
  /// [column]: Sıralanacak sütun adı.
  /// [ascending]: Sıralama yönü (true: ASC, false: DESC).
  ///
  /// **Kullanım Sırası:**
  /// - ORDER BY, WHERE, GROUP BY, HAVING'den sonra gelmelidir.
  /// - LIMIT veya OFFSET'den önce gelmelidir.
  ///
  /// **Örnekler:**
  /// ```dart
  /// SQLRaw sql1 = SQLRaw().orderBy("age", ascending: true); // ORDER BY age ASC
  /// SQLRaw sql2 = SQLRaw().orderBy("age", ascending: false); // ORDER BY age DESC
  /// ```
  SQLRawMap orderBy(String column, {bool ascending = true, COLLATEE? collate}) {
    _query +=
        "ORDER BY $column ${collate != null ? "COLLATE ${collate.name} " : ""} ${ascending ? "ASC" : "DESC"} ";
    return this;
  }

  /// LIMIT ifadesini ekler.
  ///
  /// [count]: Döndürülecek maksimum kayıt sayısı.
  ///
  /// **Kullanım Sırası:**
  /// - LIMIT, ORDER BY'den sonra gelmelidir.
  /// - OFFSET ile birlikte kullanılabilir.
  ///
  /// **Örnekler:**
  /// ```dart
  /// SQLRaw sql1 = SQLRaw().limit(10); // LIMIT 10
  /// ```
  SQLRawMap limit(int count) {
    _query += "LIMIT $count ";
    return this;
  }

  /// OFFSET ifadesini ekler.
  ///
  /// [count]: Atlanacak kayıt sayısı.
  ///
  /// **Kullanım Sırası:**
  /// - OFFSET, LIMIT'den sonra gelmelidir.
  ///
  /// **Örnekler:**
  /// ```dart
  /// SQLRaw sql1 = SQLRaw().offset(20); // OFFSET 20
  /// ```
  SQLRawMap offset(int count) {
    _query += "OFFSET $count ";
    return this;
  }

  /// Oluşturulan SQL sorgusunu döndürür.
  ///
  /// **Kullanım Sırası:**
  /// - query(), tüm diğer metodlardan sonra çağrılmalıdır.
  ///
  /// **Örnekler:**
  /// ```dart
  /// String query1 = SQLRaw()
  ///   .select("*")
  ///   .from("kullanicilar")
  ///   .where("id = ?")
  ///   .whereArgs([1])
  ///   .query();
  /// // Çıktı: {"sql": "SELECT * FROM kullanicilar WHERE id = ?", "args": [1]}
  /// ```
  Map<String, dynamic> query() {
    return {
      "sql": _query.trim(),
      "args": _whereArgs.isNotEmpty ? _whereArgs : null,
    };
  }
}
