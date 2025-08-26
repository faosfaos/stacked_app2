// ignore_for_file: constant_identifier_names, avoid_print, prefer_final_fields

class Collate {
  static String localized = "COLLATE LOCALIZED";
  static String nocase = "COLLATE NOCASE";
}

/// SQLRaw sınıfı, SQL sorgularını zincirleme olarak oluşturmak için kullanılır.
///
/// Bu sınıf, SELECT, FROM, JOIN, WHERE, ORDER BY, LIMIT ve OFFSET gibi SQL komutlarını destekler.
/// Her metot, sınıfın kendisini (`this`) döndürerek zincirleme kullanım sağlar.
///

class SQLRaw {
  String _query = "";

  SQLRaw select(String? select) {
    _query += "SELECT ${select ?? "*"} ";
    return this;
  }

  SQLRaw selectJ(String? select) {
    _query += "$select";
    return this;
  }

  SQLRaw update(String table) {
    _query += " UPDATE $table ";
    return this;
  }

  ///
  /// SET ifadesini ekler
  /// Araya virgül koyarak kullanabilirsiniz
  /// Örnek:
  /// ```dart
  /// SQLRaw sql1 = SQLRaw()
  ///   .update()
  ///   .set("ad = 'Ahmet', soyad = 'Yılmaz'");
  /// // Çıktı: UPDATE SET ad = 'Ahmet', soyad = 'Yılmaz'
  ///
  SQLRaw set(String set) {
    _query += " SET  $set ";
    return this;
  }

  //'UPDATE ${Tbl.kasa} SET miktar = miktar + $tutar WHERE id = 1';

  /// DISTINCT ifadesini ekler.
  ///
  ///
  /// DISTINCT, tekrar eden satırları filtrelemek için kullanılır.
  ///
  ////// **Kullanım Sırası:**
  /// - DISTINCT, SELECT ifadesinin hemen ardından gelmelidir.
  /// - FROM, WHERE, GROUP BY gibi diğer ifadelerden önce gelmelidir.
  ///
  /// **Kısıtlamalar:**
  /// - DISTINCT, SELECT olmadan kullanılamaz.
  /// - DISTINCT, yalnızca SELECT ifadesindeki sütunlar üzerinde çalışır.
  /// - DISTINCT ile birden fazla sütun belirtilebilir. Bu durumda, belirtilen tüm sütunların kombinasyonu baz alınarak benzersizlik kontrolü yapılır.
  ///
  /// Örnek:
  /// ```dart
  /// // Tekrar eden şehirleri filtreleme
  /// SQLRaw sql1 = SQLRaw().select("sehir").distinct().from("kullanicilar");
  /// // Çıktı: SELECT DISTINCT sehir FROM kullanicilar
  /// ```
  ///
  /// **Ek Açıklamalar:**
  /// - Eğer tek bir sütun için DISTINCT kullanılırsa, o sütundaki tekrar eden değerler filtrelenir.
  /// - Eğer birden fazla sütun için DISTINCT kullanılırsa, bu sütunların değerlerinin kombinasyonu baz alınır.
  ///   Örneğin, `DISTINCT sehir, yas` ifadesi, hem şehir hem de yaş kombinasyonu bazında benzersiz kayıtlar döndürür.
  ///
  /// **Örnek Kullanım Senaryoları:**
  /// 1. Tek bir sütunda tekrar eden değerleri filtreleme:
  ///    ```sql
  ///    SELECT DISTINCT sehir FROM kullanicilar;
  ///    ```
  ///    - Sonuç: Her şehir yalnızca bir kez listelenir.
  ///
  /// 2. Birden fazla sütunda tekrar eden kombinasyonları filtreleme:
  ///    ```sql
  ///    SELECT DISTINCT sehir, yas FROM kullanicilar;
  ///    ```
  ///    - Sonuç: Şehir ve yaş kombinasyonu bazında benzersiz kayıtlar döner.
  ///
  /// 3. Tüm sütunlarda tekrar eden kayıtları filtreleme:
  ///    ```sql
  ///    SELECT DISTINCT * FROM kullanicilar;
  ///    ```
  ///    - Sonuç: Tüm sütunların kombinasyonu bazında benzersiz kayıtlar döner.
  ///
  /// **Dart Örnekleri:**
  /// ```dart
  /// // 1. Tek bir sütunda DISTINCT kullanımı
  /// SQLRaw sql1 = SQLRaw().select("sehir").distinct().from("kullanicilar");
  /// // Çıktı: SELECT DISTINCT sehir FROM kullanicilar
  ///
  /// // 2. Birden fazla sütunda DISTINCT kullanımı
  /// SQLRaw sql2 = SQLRaw().select("sehir, yas").distinct().from("kullanicilar");
  /// // Çıktı: SELECT DISTINCT sehir, yas FROM kullanicilar
  ///
  /// // 3. Tüm sütunlarda DISTINCT kullanımı
  /// SQLRaw sql3 = SQLRaw().select("*").distinct().from("kullanicilar");
  /// // Çıktı: SELECT DISTINCT * FROM kullanicilar
  /// ```
  /// Örnekler:
  /// ```dart
  /// // 1. Tekrar eden şehirleri filtreleme
  /// SQLRaw sql1 = SQLRaw().select("city").distinct(); // SELECT DISTINCT city
  ///
  /// // 2. Birden fazla sütunda tekrar edenleri filtreleme
  /// SQLRaw sql2 = SQLRaw().select("name, age").distinct(); // SELECT DISTINCT name, age
  ///
  /// // 3. Alt sorgu ile DISTINCT kullanımı
  /// SQLRaw sql3 = SQLRaw().select("(SELECT department FROM employees) AS department").distinct(); // SELECT DISTINCT (SELECT department FROM employees) AS department
  ///
  /// // 4. Tüm sütunlarda tekrar edenleri filtreleme
  /// SQLRaw sql4 = SQLRaw().select("*").distinct(); // SELECT DISTINCT *
  /// ```
  SQLRaw distinct() {
    _query = _query.replaceFirst("SELECT", "SELECT DISTINCT");
    return this;
  }

  /// FROM ifadesini ekler.
  ///
  /// [from]: Verilerin çekileceği tablo adı.
  ///
  ////// **Kullanım Sırası:**
  /// - FROM, SELECT'ten sonra gelmelidir.
  /// - JOIN, WHERE, ORDER BY gibi diğer ifadelerden önce gelmelidir.
  ///
  /// **Kısıtlamalar:**
  /// - FROM olmadan JOIN veya WHERE kullanılamaz.
  /// - FROM, bir SQL sorgusunda en az bir kez kullanılmalıdır.
  ///
  /// Örnekler:
  /// ```dart
  /// // 1. Tek bir tablodan veri çekme
  /// SQLRaw sql1 = SQLRaw().from("users"); // FROM users
  ///
  /// // 2. Alt sorgu ile tablo belirtme
  /// SQLRaw sql2 = SQLRaw().from("(SELECT * FROM active_users) AS active_users"); // FROM (SELECT * FROM active_users) AS active_users
  ///
  /// // 3. JOIN ile birlikte FROM kullanımı
  /// SQLRaw sql3 = SQLRaw().from("users INNER JOIN orders ON users.id = orders.user_id"); // FROM users INNER JOIN orders ON users.id = orders.user_id
  ///
  /// // 4. Şema ile tablo adı belirtme
  /// SQLRaw sql4 = SQLRaw().from("public.users"); // FROM public.users
  /// ```
  SQLRaw from(String table) {
    _query += "FROM $table ";
    return this;
  }

  /// INNER JOIN ifadesini ekler.
  ///
  /// [table]: Birleştirilecek tablo adı.
  /// [onCondition]: İki tabloyu birleştirmek için kullanılacak koşul.
  ///
  ////// **Kullanım Sırası:**
  /// - JOIN, FROM'dan sonra gelmelidir.
  /// - WHERE, GROUP BY, ORDER BY gibi ifadelerden önce gelmelidir.
  ///
  /// **Kısıtlamalar:**
  /// - JOIN olmadan WHERE veya ORDER BY kullanılamaz.
  /// - JOIN, birleştirme koşulu olmadan kullanılamaz.
  ///
  /// Açıklama:
  /// INNER JOIN, iki tablo arasında eşleşen kayıtları döndürür. Eşleşme olmayan kayıtlar sonuç kümesinde yer almaz.
  ///
  /// Örnek Senaryo:
  /// Kullanıcılar (`kullanicilar`) ve siparişler (`siparisler`) tablolarını birleştirerek, yalnızca siparişi olan kullanıcıları listelemek istiyoruz.
  ///
  /// Örnek Kod:
  /// ```dart
  /// SQLRaw sql1 = SQLRaw()
  ///   .select("kullanicilar.ad, siparisler.urun")
  ///   .from("kullanicilar")
  ///   .innerJoin("siparisler", "kullanicilar.id = siparisler.kullanici_id");
  /// // Çıktı: SELECT kullanicilar.ad, siparisler.urun FROM kullanicilar INNER JOIN siparisler ON kullanicilar.id = siparisler.kullanici_id
  /// ```
  ///
  /// Çıktı Açıklaması:
  /// Sadece `kullanicilar` tablosundaki kullanıcıların `siparisler` tablosunda eşleşen kayıtları döner. Eğer bir kullanıcının siparişi yoksa, o kullanıcı sonuçta yer almaz.
  SQLRaw joinInner(String table, String onCondition) {
    _query += "INNER JOIN $table ON $onCondition ";
    return this;
  }

  /// LEFT JOIN (LEFT OUTER JOIN) ifadesini ekler.
  ///
  /// [table]: Birleştirilecek tablo adı.
  /// [onCondition]: İki tabloyu birleştirmek için kullanılacak koşul.
  ///
  /// Açıklama:
  /// LEFT JOIN, sol tablodaki tüm kayıtları ve sağ tablodaki eşleşen kayıtları döndürür. Sağ tabloda eşleşme bulunmuyorsa, sağ tablo sütunları için `NULL` değerler döner.
  ///
  /// Örnek Senaryo:
  /// Tüm kullanıcıları listelemek istiyoruz, ancak siparişleri varsa onları da göstermek istiyoruz. Siparişi olmayan kullanıcılar için sipariş bilgileri `NULL` olarak dönecek.
  ///
  /// Örnek Kod:
  /// ```dart
  /// SQLRaw sql1 = SQLRaw()
  ///   .select("kullanicilar.ad, siparisler.urun")
  ///   .from("kullanicilar")
  ///   .leftJoin("siparisler", "kullanicilar.id = siparisler.kullanici_id");
  /// // Çıktı: SELECT kullanicilar.ad, siparisler.urun FROM kullanicilar LEFT JOIN siparisler ON kullanicilar.id = siparisler.kullanici_id
  /// ```
  ///
  /// Çıktı Açıklaması:
  /// `kullanicilar` tablosundaki tüm kullanıcılar listelenir. Eğer bir kullanıcının siparişi yoksa, `siparisler.urun` değeri `NULL` olur.
  SQLRaw joinLeft({required String table, required String on}) {
    if (on.isEmpty) {
      throw Exception("ON parametresi boş olmamalıdır.");
    }
    _query += "LEFT JOIN $table ON $on ";
    return this;
  }

  /// CROSS JOIN ifadesini ekler.
  ///
  /// [table]: Birleştirilecek tablo adı.
  ///
  /// Açıklama:
  /// CROSS JOIN, iki tablonun kartezyen çarpımını (tüm kombinasyonlarını) döndürür. Koşul belirtilmez, her kayıt diğer tablodaki tüm kayıtlarla eşleştirilir.
  ///
  /// Örnek Senaryo:
  /// Kullanıcılar ve şehirler tablolarını birleştirerek, her kullanıcı için tüm şehirleri listelemek istiyoruz.
  ///
  /// Örnek Kod:
  /// ```dart
  /// SQLRaw sql1 = SQLRaw()
  ///   .select("kullanicilar.ad, sehirler.sehir_adi")
  ///   .from("kullanicilar")
  ///   .crossJoin("sehirler");
  /// // Çıktı: SELECT kullanicilar.ad, sehirler.sehir_adi FROM kullanicilar CROSS JOIN sehirler
  /// ```
  ///
  /// Çıktı Açıklaması:
  /// `kullanicilar` tablosundaki her kullanıcı, `sehirler` tablosundaki tüm şehirlerle eşleştirilir. Örneğin, 3 kullanıcı ve 2 şehir varsa, sonuçta 6 kayıt döner.
  SQLRaw crossJoin(String table) {
    _query += "CROSS JOIN $table ";
    return this;
  }

  /// WHERE koşulunu ekler.
  ///
  /// [conditions]: Koşulların bir listesi.
  /// [operator]: Koşullar arasında kullanılacak mantıksal operatör ("AND" veya "OR").
  ///
  /// Örnekler:
  /// ```dart
  /// // 1. Basit WHERE koşulu
  /// SQLRaw sql1 = SQLRaw().where(["age > 18"]); // WHERE age > 18
  ///
  /// // 2. Birden fazla koşul ile WHERE
  /// SQLRaw sql2 = SQLRaw().where(["age > 18", "city = 'Ankara'"], operator: "AND"); // WHERE age > 18 AND city = 'Ankara'
  ///
  /// // 3. OR operatörü ile WHERE
  /// SQLRaw sql3 = SQLRaw().where(["city = 'Ankara'", "city = 'İstanbul'"], operator: "OR"); // WHERE city = 'Ankara' OR city = 'İstanbul'
  ///
  /// // 4. Alt sorgu ile WHERE
  /// SQLRaw sql4 = SQLRaw().where(["(SELECT COUNT(*) FROM orders WHERE user_id = users.id) > 0"]); // WHERE (SELECT COUNT(*) FROM orders WHERE user_id = users.id) > 0
  /// ```
  /// /// COLLATE KULLANIMI.
  ///
  /// [column]: COLLATE uygulanacak sütun adı.
  /// [collation]: Kullanılacak sıralama kuralı (örneğin, "LOCALIZED", "NOCASE", "BINARY").
  /// **AÇIKLAMA**
  /// ```
  /// COLLATE LOCALIZED: Kültüre özgü sıralama kurallarını uygular. Örneğin, Türkçe karakterlerin doğru sıralanmasını sağlar.
  /// COLLATE NOCASE: Büyük/küçük harf duyarsız karşılaştırma yapar.
  /// COLLATE BINARY: Verinin ikili (binary) değerine göre sıralama veya karşılaştırma yapar.
  /// ```
  /// **Kullanım Sırası:**
  /// - COLLATE, genellikle ORDER BY veya WHERE ifadelerinde kullanılır.
  /// - SELECT, WHERE, ORDER BY, GROUP BY gibi ifadelerden sonra gelmelidir.
  ///
  ///SELECT İfadesinde:
  ///Bir sütun veya ifade üzerinde sıralama veya karşılaştırma yaparken kullanılabilir.
  ///Örnek:
  ///```dart
  ///SELECT ad COLLATE LOCALIZED FROM kullanicilar;
  ///```
  ///Sonuç: ad sütunundaki değerler, kültüre özgü sıralama kurallarına göre işlenir.
  ///
  ///ORDER BY İfadesinde:
  ///Sıralama sırasında COLLATE kullanılabilir.
  ///Örnek:
  /// ```dart
  /// SELECT * FROM kullanicilar ORDER BY ad COLLATE LOCALIZED;
  /// ```
  /// Sonuç: ad sütunundaki değerler, kültüre özgü sıralama kurallarına göre işlenir.
  ///
  /// WHERE Koşulunda:
  ///Karşılaştırma işlemlerinde COLLATE kullanılabilir.
  ///Örnek:
  /// ```dart
  /// SELECT * FROM kullanicilar WHERE ad = 'Ahmet' COLLATE NOCASE;
  /// ```
  /// Sonuç: ad sütunundaki değerler, Büyük/küçük harf duyarsız olarak karşılaştırılır. Örneğin, "Ahmet", "AHMET" veya "ahmet" eşleşir.
  ///
  ///GROUP BY veya HAVING İfadelerinde:
  //Gruplama veya filtreleme sırasında COLLATE kullanılabilir.
  ///Örnek:
  ///```dart
  ///SELECT sehir COLLATE LOCALIZED, COUNT(*) FROM kullanicilar GROUP BY sehir COLLATE LOCALIZED;
  ///```
  ///Sonuç: sehir sütunundaki değerler, kültüre özgü sıralama kurallarına göre işlenir.
  ///
  /// **Kısıtlamalar:**
  /// - COLLATE, yalnızca metin verileri (TEXT) üzerinde kullanılabilir.
  /// - COLLATE, sayısal veya tarih verileri üzerinde kullanılamaz.
  ///
  /// **Kullanım Örnekleri:**
  ///
  /// 1. **Türkçe Karakterlerle Sıralama (ORDER BY ile):**
  /// ```dart
  /// SQLRaw sql1 = SQLRaw()
  ///   .select("*")
  ///   .from("kullanicilar")
  ///   .orderBy("ad COLLATE LOCALIZED");
  /// // Çıktı: SELECT * FROM kullanicilar ORDER BY ad COLLATE LOCALIZED
  /// ```
  /// - **Açıklama:** `ad` sütunundaki değerler, Türkçe karakterlerin doğru sıralanmasını sağlayacak şekilde sıralanır.
  ///
  /// 2. **Büyük/Küçük Harf Duyarsız Karşılaştırma (WHERE ile):**
  /// ```dart
  /// SQLRaw sql2 = SQLRaw()
  ///   .select("*")
  ///   .from("kullanicilar")
  ///   .where(["ad = 'ahmet' COLLATE NOCASE"]);
  /// // Çıktı: SELECT * FROM kullanicilar WHERE ad = 'ahmet' COLLATE NOCASE
  /// ```
  /// - **Açıklama:** `ad` sütunundaki değerler, büyük/küçük harf duyarsız olarak karşılaştırılır. Örneğin, "Ahmet", "AHMET" veya "ahmet" eşleşir.
  ///
  /// 3. **Gruplama ve Sıralama (GROUP BY ve ORDER BY ile):**
  /// ```dart
  /// SQLRaw sql3 = SQLRaw()
  ///   .select("sehir COLLATE LOCALIZED, COUNT(*) AS kullanici_sayisi")
  ///   .from("kullanicilar")
  ///   .groupBy("sehir COLLATE LOCALIZED")
  ///   .orderBy("sehir COLLATE LOCALIZED");
  /// // Çıktı: SELECT sehir COLLATE LOCALIZED, COUNT(*) AS kullanici_sayisi FROM kullanicilar GROUP BY sehir COLLATE LOCALIZED ORDER BY sehir COLLATE LOCALIZED
  /// ```
  /// - **Açıklama:** `sehir` sütunundaki değerler, kültüre özgü sıralama kurallarına göre gruplanır ve sıralanır.
  ///
  /// 4. **LIKE Koşulu ile Büyük/Küçük Harf Duyarsız Arama:**
  /// ```dart
  /// SQLRaw sql4 = SQLRaw()
  ///   .select("*")
  ///   .from("kullanicilar")
  ///   .where(["ad LIKE '%ahmet%' COLLATE NOCASE"]);
  /// // Çıktı: SELECT * FROM kullanicilar WHERE ad LIKE '%ahmet%' COLLATE NOCASE
  /// ```
  /// - **Açıklama:** `ad` sütunundaki değerler, büyük/küçük harf duyarsız olarak aranır. Örneğin, "Ahmet", "AHMET" veya "ahmet" içeren kayıtlar döner.
  ///
  /// 5. **DISTINCT ile Kültüre Özgü Tekil Değerler:**
  /// ```dart
  /// SQLRaw sql5 = SQLRaw()
  ///   .select("DISTINCT sehir COLLATE LOCALIZED")
  ///   .from("kullanicilar")
  ///   .orderBy("sehir COLLATE LOCALIZED");
  /// // Çıktı: SELECT DISTINCT sehir COLLATE LOCALIZED FROM kullanicilar ORDER BY sehir COLLATE LOCALIZED
  /// ```
  /// - **Açıklama:** `sehir` sütunundaki değerler, kültüre özgü sıralama kurallarına göre benzersizleştirilir ve sıralanır.
  ///
  /// 6. **Birden Fazla Sütunda COLLATE Kullanımı:**
  /// ```dart
  /// SQLRaw sql6 = SQLRaw()
  ///   .select("ad COLLATE LOCALIZED, soyad COLLATE LOCALIZED")
  ///   .from("kullanicilar")
  ///   .orderBy("ad COLLATE LOCALIZED, soyad COLLATE LOCALIZED");
  /// // Çıktı: SELECT ad COLLATE LOCALIZED, soyad COLLATE LOCALIZED FROM kullanicilar ORDER BY ad COLLATE LOCALIZED, soyad COLLATE LOCALIZED
  /// ```
  /// - **Açıklama:** Hem `ad` hem de `soyad` sütunları, kültüre özgü sıralama kurallarına göre sıralanır.
  ///
  /// 7. **JOIN ile COLLATE Kullanımı:**
  /// ```dart
  /// SQLRaw sql7 = SQLRaw()
  ///   .select("kullanicilar.ad COLLATE LOCALIZED, siparisler.urun")
  ///   .from("kullanicilar")
  ///   .innerJoin("siparisler", "kullanicilar.id = siparisler.kullanici_id")
  ///   .orderBy("kullanicilar.ad COLLATE LOCALIZED");
  /// // Çıktı: SELECT kullanicilar.ad COLLATE LOCALIZED, siparisler.urun FROM kullanicilar INNER JOIN siparisler ON kullanicilar.id = siparisler.kullanici_id ORDER BY kullanicilar.ad COLLATE LOCALIZED
  /// ```
  /// - **Açıklama:** `kullanicilar.ad` sütunundaki değerler, kültüre özgü sıralama kurallarına göre sıralanır ve `siparisler` tablosuyla birleştirilir.
  ///
  SQLRaw where(String condition, {bool addWhere = true}) {
    if (addWhere) {
      _query += "WHERE $condition ";
    } else {
      _query += " $condition ";
    }

    return this;
  }

  SQLRaw whereNot(String condition) {
    _query += " $condition ";
    return this;
  }

  /// WHERE koşulunu ekler.
  ///
  /// [condition]: Koşul ifadesi (örneğin, "ad = ? AND yas > ?").
  /// [args]: Koşul ifadesindeki "?" yerine gelecek değerler.

  /// LIKE koşulunu ekler.
  /// Where den sonra kullanılır
  /// [column]: Arama yapılacak sütun.
  /// [pattern]: Aranacak desen (örneğin, '%Ahmet%').
  ///
  /// Örnek:
  /// ```dart
  /// // Adı 'Ahmet' içeren kullanıcıları seçme
  /// SQLRaw sql1 = SQLRaw().select("*").from("kullanicilar").like("ad", "%Ahmet%");
  /// // Çıktı: SELECT * FROM kullanicilar WHERE ad LIKE '%Ahmet%'
  /// ```
  SQLRaw like(String column, String pattern) {
    _query += " AND $column LIKE '$pattern' ";
    return this;
  }

  /// GROUP BY ifadesini ekler.
  ///
  /// [column]: Gruplanacak sütun adı.
  ///
  /// /// **Kullanım Sırası:**
  /// - GROUP BY, WHERE'den sonra gelmelidir.
  /// - HAVING, ORDER BY gibi ifadelerden önce gelmelidir.
  ///
  /// **Kısıtlamalar:**
  /// - GROUP BY, SELECT veya WHERE olmadan kullanılamaz.
  /// - GROUP BY, toplama fonksiyonları (COUNT, SUM, AVG, vb.) ile birlikte kullanılır.
  ///
  /// Örnek:
  /// ```dart
  /// // Şehirlere göre gruplama
  /// SQLRaw sql1 = SQLRaw()
  ///   .select("sehir, COUNT(*) AS kullanici_sayisi")
  ///   .from("kullanicilar")
  ///   .groupBy("sehir");
  /// // Çıktı: SELECT sehir, COUNT(*) AS kullanici_sayisi FROM kullanicilar GROUP BY sehir
  /// ```
  /// /// COLLATE KULLANIMI.
  ///
  /// [column]: COLLATE uygulanacak sütun adı.
  /// [collation]: Kullanılacak sıralama kuralı (örneğin, "LOCALIZED", "NOCASE", "BINARY").
  /// **AÇIKLAMA**
  /// ```
  /// COLLATE LOCALIZED: Kültüre özgü sıralama kurallarını uygular. Örneğin, Türkçe karakterlerin doğru sıralanmasını sağlar.
  /// COLLATE NOCASE: Büyük/küçük harf duyarsız karşılaştırma yapar.
  /// COLLATE BINARY: Verinin ikili (binary) değerine göre sıralama veya karşılaştırma yapar.
  /// ```
  /// **Kullanım Sırası:**
  /// - COLLATE, genellikle ORDER BY veya WHERE ifadelerinde kullanılır.
  /// - SELECT, WHERE, ORDER BY, GROUP BY gibi ifadelerden sonra gelmelidir.
  ///
  ///SELECT İfadesinde:
  ///Bir sütun veya ifade üzerinde sıralama veya karşılaştırma yaparken kullanılabilir.
  ///Örnek:
  ///```dart
  ///SELECT ad COLLATE LOCALIZED FROM kullanicilar;
  ///```
  ///Sonuç: ad sütunundaki değerler, kültüre özgü sıralama kurallarına göre işlenir.
  ///
  ///ORDER BY İfadesinde:
  ///Sıralama sırasında COLLATE kullanılabilir.
  ///Örnek:
  /// ```dart
  /// SELECT * FROM kullanicilar ORDER BY ad COLLATE LOCALIZED;
  /// ```
  /// Sonuç: ad sütunundaki değerler, kültüre özgü sıralama kurallarına göre işlenir.
  ///
  /// WHERE Koşulunda:
  ///Karşılaştırma işlemlerinde COLLATE kullanılabilir.
  ///Örnek:
  /// ```dart
  /// SELECT * FROM kullanicilar WHERE ad = 'Ahmet' COLLATE NOCASE;
  /// ```
  /// Sonuç: ad sütunundaki değerler, Büyük/küçük harf duyarsız olarak karşılaştırılır. Örneğin, "Ahmet", "AHMET" veya "ahmet" eşleşir.
  ///
  ///GROUP BY veya HAVING İfadelerinde:
  //Gruplama veya filtreleme sırasında COLLATE kullanılabilir.
  ///Örnek:
  ///```dart
  ///SELECT sehir COLLATE LOCALIZED, COUNT(*) FROM kullanicilar GROUP BY sehir COLLATE LOCALIZED;
  ///```
  ///Sonuç: sehir sütunundaki değerler, kültüre özgü sıralama kurallarına göre işlenir.
  ///
  /// **Kısıtlamalar:**
  /// - COLLATE, yalnızca metin verileri (TEXT) üzerinde kullanılabilir.
  /// - COLLATE, sayısal veya tarih verileri üzerinde kullanılamaz.
  ///
  /// **Kullanım Örnekleri:**
  ///
  /// 1. **Türkçe Karakterlerle Sıralama (ORDER BY ile):**
  /// ```dart
  /// SQLRaw sql1 = SQLRaw()
  ///   .select("*")
  ///   .from("kullanicilar")
  ///   .orderBy("ad COLLATE LOCALIZED");
  /// // Çıktı: SELECT * FROM kullanicilar ORDER BY ad COLLATE LOCALIZED
  /// ```
  /// - **Açıklama:** `ad` sütunundaki değerler, Türkçe karakterlerin doğru sıralanmasını sağlayacak şekilde sıralanır.
  ///
  /// 2. **Büyük/Küçük Harf Duyarsız Karşılaştırma (WHERE ile):**
  /// ```dart
  /// SQLRaw sql2 = SQLRaw()
  ///   .select("*")
  ///   .from("kullanicilar")
  ///   .where(["ad = 'ahmet' COLLATE NOCASE"]);
  /// // Çıktı: SELECT * FROM kullanicilar WHERE ad = 'ahmet' COLLATE NOCASE
  /// ```
  /// - **Açıklama:** `ad` sütunundaki değerler, büyük/küçük harf duyarsız olarak karşılaştırılır. Örneğin, "Ahmet", "AHMET" veya "ahmet" eşleşir.
  ///
  /// 3. **Gruplama ve Sıralama (GROUP BY ve ORDER BY ile):**
  /// ```dart
  /// SQLRaw sql3 = SQLRaw()
  ///   .select("sehir COLLATE LOCALIZED, COUNT(*) AS kullanici_sayisi")
  ///   .from("kullanicilar")
  ///   .groupBy("sehir COLLATE LOCALIZED")
  ///   .orderBy("sehir COLLATE LOCALIZED");
  /// // Çıktı: SELECT sehir COLLATE LOCALIZED, COUNT(*) AS kullanici_sayisi FROM kullanicilar GROUP BY sehir COLLATE LOCALIZED ORDER BY sehir COLLATE LOCALIZED
  /// ```
  /// - **Açıklama:** `sehir` sütunundaki değerler, kültüre özgü sıralama kurallarına göre gruplanır ve sıralanır.
  ///
  /// 4. **LIKE Koşulu ile Büyük/Küçük Harf Duyarsız Arama:**
  /// ```dart
  /// SQLRaw sql4 = SQLRaw()
  ///   .select("*")
  ///   .from("kullanicilar")
  ///   .where(["ad LIKE '%ahmet%' COLLATE NOCASE"]);
  /// // Çıktı: SELECT * FROM kullanicilar WHERE ad LIKE '%ahmet%' COLLATE NOCASE
  /// ```
  /// - **Açıklama:** `ad` sütunundaki değerler, büyük/küçük harf duyarsız olarak aranır. Örneğin, "Ahmet", "AHMET" veya "ahmet" içeren kayıtlar döner.
  ///
  /// 5. **DISTINCT ile Kültüre Özgü Tekil Değerler:**
  /// ```dart
  /// SQLRaw sql5 = SQLRaw()
  ///   .select("DISTINCT sehir COLLATE LOCALIZED")
  ///   .from("kullanicilar")
  ///   .orderBy("sehir COLLATE LOCALIZED");
  /// // Çıktı: SELECT DISTINCT sehir COLLATE LOCALIZED FROM kullanicilar ORDER BY sehir COLLATE LOCALIZED
  /// ```
  /// - **Açıklama:** `sehir` sütunundaki değerler, kültüre özgü sıralama kurallarına göre benzersizleştirilir ve sıralanır.
  ///
  /// 6. **Birden Fazla Sütunda COLLATE Kullanımı:**
  /// ```dart
  /// SQLRaw sql6 = SQLRaw()
  ///   .select("ad COLLATE LOCALIZED, soyad COLLATE LOCALIZED")
  ///   .from("kullanicilar")
  ///   .orderBy("ad COLLATE LOCALIZED, soyad COLLATE LOCALIZED");
  /// // Çıktı: SELECT ad COLLATE LOCALIZED, soyad COLLATE LOCALIZED FROM kullanicilar ORDER BY ad COLLATE LOCALIZED, soyad COLLATE LOCALIZED
  /// ```
  /// - **Açıklama:** Hem `ad` hem de `soyad` sütunları, kültüre özgü sıralama kurallarına göre sıralanır.
  ///
  /// 7. **JOIN ile COLLATE Kullanımı:**
  /// ```dart
  /// SQLRaw sql7 = SQLRaw()
  ///   .select("kullanicilar.ad COLLATE LOCALIZED, siparisler.urun")
  ///   .from("kullanicilar")
  ///   .innerJoin("siparisler", "kullanicilar.id = siparisler.kullanici_id")
  ///   .orderBy("kullanicilar.ad COLLATE LOCALIZED");
  /// // Çıktı: SELECT kullanicilar.ad COLLATE LOCALIZED, siparisler.urun FROM kullanicilar INNER JOIN siparisler ON kullanicilar.id = siparisler.kullanici_id ORDER BY kullanicilar.ad COLLATE LOCALIZED
  /// ```
  /// - **Açıklama:** `kullanicilar.ad` sütunundaki değerler, kültüre özgü sıralama kurallarına göre sıralanır ve `siparisler` tablosuyla birleştirilir.
  ///
  SQLRaw groupBy(String column) {
    _query += "GROUP BY $column ";
    return this;
  }

  /// HAVING koşulunu ekler.
  ///
  /// [condition]: Gruplanmış veriler üzerinde uygulanacak koşul.
  ///
  /// /// **Kullanım Sırası:**
  /// - HAVING, GROUP BY'den sonra gelmelidir.
  /// - ORDER BY'den önce gelmelidir.
  ///
  /// **Kısıtlamalar:**
  /// - HAVING, GROUP BY olmadan kullanılamaz.
  /// - HAVING, toplama fonksiyonları (COUNT, SUM, AVG, vb.) ile birlikte kullanılır.
  ///
  /// Örnek:
  /// ```dart
  /// // Şehir başına 2'den fazla kullanıcı olan kayıtları seçme
  /// SQLRaw sql1 = SQLRaw()
  ///   .select("sehir, COUNT(*) AS kullanici_sayisi")
  ///   .from("kullanicilar")
  ///   .groupBy("sehir")
  ///   .having("COUNT(*) > 2");
  /// // Çıktı: SELECT sehir, COUNT(*) AS kullanici_sayisi FROM kullanicilar GROUP BY sehir HAVING COUNT(*) > 2
  /// ```
  SQLRaw having(String condition) {
    _query += "HAVING $condition ";
    return this;
  }

  /// ORDER BY ifadesini ekler.
  ///
  /// [column]: Sıralanacak sütun adı.
  /// [ascending]: Sıralama yönü (true: ASC, false: DESC).
  ///
  ////// **Kullanım Sırası:**
  /// - ORDER BY, WHERE, GROUP BY, HAVING'den sonra gelmelidir.
  /// - LIMIT veya OFFSET'den önce gelmelidir.
  ///
  /// **Kısıtlamalar:**
  /// - ORDER BY, FROM veya SELECT olmadan kullanılamaz.
  /// - ORDER BY, birden fazla sütun için kullanılabilir.
  ///
  /// Örnekler:
  /// ```dart
  /// // 1. Artan sıralama
  /// SQLRaw sql1 = SQLRaw().orderBy("age", ascending: true); // ORDER BY age ASC
  ///
  /// // 2. Azalan sıralama
  /// SQLRaw sql2 = SQLRaw().orderBy("age", ascending: false); // ORDER BY age DESC
  ///
  /// // 3. Birden fazla sütunda sıralama
  /// SQLRaw sql3 = SQLRaw().orderBy("age ASC, name DESC"); // ORDER BY age ASC, name DESC
  ///
  /// // 4. Alt sorgu ile sıralama
  /// SQLRaw sql4 = SQLRaw().orderBy("(SELECT COUNT(*) FROM orders WHERE user_id = users.id) DESC"); // ORDER BY (SELECT COUNT(*) FROM orders WHERE user_id = users.id) DESC
  /// ```
  /// /// COLLATE KULLANIMI.
  ///
  /// [column]: COLLATE uygulanacak sütun adı.
  /// [collation]: Kullanılacak sıralama kuralı (örneğin, "LOCALIZED", "NOCASE", "BINARY").
  /// **AÇIKLAMA**
  /// ```
  /// COLLATE LOCALIZED: Kültüre özgü sıralama kurallarını uygular. Örneğin, Türkçe karakterlerin doğru sıralanmasını sağlar.
  /// COLLATE NOCASE: Büyük/küçük harf duyarsız karşılaştırma yapar.
  /// COLLATE BINARY: Verinin ikili (binary) değerine göre sıralama veya karşılaştırma yapar.
  /// ```
  /// **Kullanım Sırası:**
  /// - COLLATE, genellikle ORDER BY veya WHERE ifadelerinde kullanılır.
  /// - SELECT, WHERE, ORDER BY, GROUP BY gibi ifadelerden sonra gelmelidir.
  ///
  ///SELECT İfadesinde:
  ///Bir sütun veya ifade üzerinde sıralama veya karşılaştırma yaparken kullanılabilir.
  ///Örnek:
  ///```dart
  ///SELECT ad COLLATE LOCALIZED FROM kullanicilar;
  ///```
  ///Sonuç: ad sütunundaki değerler, kültüre özgü sıralama kurallarına göre işlenir.
  ///
  ///ORDER BY İfadesinde:
  ///Sıralama sırasında COLLATE kullanılabilir.
  ///Örnek:
  /// ```dart
  /// SELECT * FROM kullanicilar ORDER BY ad COLLATE LOCALIZED;
  /// ```
  /// Sonuç: ad sütunundaki değerler, kültüre özgü sıralama kurallarına göre işlenir.
  ///
  /// WHERE Koşulunda:
  ///Karşılaştırma işlemlerinde COLLATE kullanılabilir.
  ///Örnek:
  /// ```dart
  /// SELECT * FROM kullanicilar WHERE ad = 'Ahmet' COLLATE NOCASE;
  /// ```
  /// Sonuç: ad sütunundaki değerler, Büyük/küçük harf duyarsız olarak karşılaştırılır. Örneğin, "Ahmet", "AHMET" veya "ahmet" eşleşir.
  ///
  ///GROUP BY veya HAVING İfadelerinde:
  //Gruplama veya filtreleme sırasında COLLATE kullanılabilir.
  ///Örnek:
  ///```dart
  ///SELECT sehir COLLATE LOCALIZED, COUNT(*) FROM kullanicilar GROUP BY sehir COLLATE LOCALIZED;
  ///```
  ///Sonuç: sehir sütunundaki değerler, kültüre özgü sıralama kurallarına göre işlenir.
  ///
  /// **Kısıtlamalar:**
  /// - COLLATE, yalnızca metin verileri (TEXT) üzerinde kullanılabilir.
  /// - COLLATE, sayısal veya tarih verileri üzerinde kullanılamaz.
  ///
  /// **Kullanım Örnekleri:**
  ///
  /// 1. **Türkçe Karakterlerle Sıralama (ORDER BY ile):**
  /// ```dart
  /// SQLRaw sql1 = SQLRaw()
  ///   .select("*")
  ///   .from("kullanicilar")
  ///   .orderBy("ad COLLATE LOCALIZED");
  ///
  /// SQLRaw sql1 = SQLRaw()
  ///   .select("*")
  ///   .from("kullanicilar")
  ///   .orderBy("ad ASC COLLATE LOCALIZED, soyad DESC");
  /// // Çıktı: SELECT * FROM kullanicilar ORDER BY ad COLLATE LOCALIZED
  /// ```
  /// - **Açıklama:** `ad` sütunundaki değerler, Türkçe karakterlerin doğru sıralanmasını sağlayacak şekilde sıralanır.
  ///
  /// 2. **Büyük/Küçük Harf Duyarsız Karşılaştırma (WHERE ile):**
  /// ```dart
  /// SQLRaw sql2 = SQLRaw()
  ///   .select("*")
  ///   .from("kullanicilar")
  ///   .where(["ad = 'ahmet' COLLATE NOCASE"]);
  /// // Çıktı: SELECT * FROM kullanicilar WHERE ad = 'ahmet' COLLATE NOCASE
  /// ```
  /// - **Açıklama:** `ad` sütunundaki değerler, büyük/küçük harf duyarsız olarak karşılaştırılır. Örneğin, "Ahmet", "AHMET" veya "ahmet" eşleşir.
  ///
  /// 3. **Gruplama ve Sıralama (GROUP BY ve ORDER BY ile):**
  /// ```dart
  /// SQLRaw sql3 = SQLRaw()
  ///   .select("sehir COLLATE LOCALIZED, COUNT(*) AS kullanici_sayisi")
  ///   .from("kullanicilar")
  ///   .groupBy("sehir COLLATE LOCALIZED")
  ///   .orderBy("sehir COLLATE LOCALIZED");
  /// // Çıktı: SELECT sehir COLLATE LOCALIZED, COUNT(*) AS kullanici_sayisi FROM kullanicilar GROUP BY sehir COLLATE LOCALIZED ORDER BY sehir COLLATE LOCALIZED
  /// ```
  /// - **Açıklama:** `sehir` sütunundaki değerler, kültüre özgü sıralama kurallarına göre gruplanır ve sıralanır.
  ///
  /// 4. **LIKE Koşulu ile Büyük/Küçük Harf Duyarsız Arama:**
  /// ```dart
  /// SQLRaw sql4 = SQLRaw()
  ///   .select("*")
  ///   .from("kullanicilar")
  ///   .where(["ad LIKE '%ahmet%' COLLATE NOCASE"]);
  /// // Çıktı: SELECT * FROM kullanicilar WHERE ad LIKE '%ahmet%' COLLATE NOCASE
  /// ```
  /// - **Açıklama:** `ad` sütunundaki değerler, büyük/küçük harf duyarsız olarak aranır. Örneğin, "Ahmet", "AHMET" veya "ahmet" içeren kayıtlar döner.
  ///
  /// 5. **DISTINCT ile Kültüre Özgü Tekil Değerler:**
  /// ```dart
  /// SQLRaw sql5 = SQLRaw()
  ///   .select("DISTINCT sehir COLLATE LOCALIZED")
  ///   .from("kullanicilar")
  ///   .orderBy("sehir COLLATE LOCALIZED");
  /// // Çıktı: SELECT DISTINCT sehir COLLATE LOCALIZED FROM kullanicilar ORDER BY sehir COLLATE LOCALIZED
  /// ```
  /// - **Açıklama:** `sehir` sütunundaki değerler, kültüre özgü sıralama kurallarına göre benzersizleştirilir ve sıralanır.
  ///
  /// 6. **Birden Fazla Sütunda COLLATE Kullanımı:**
  /// ```dart
  /// SQLRaw sql6 = SQLRaw()
  ///   .select("ad COLLATE LOCALIZED, soyad COLLATE LOCALIZED")
  ///   .from("kullanicilar")
  ///   .orderBy("ad COLLATE LOCALIZED, soyad COLLATE LOCALIZED");
  /// // Çıktı: SELECT ad COLLATE LOCALIZED, soyad COLLATE LOCALIZED FROM kullanicilar ORDER BY ad COLLATE LOCALIZED, soyad COLLATE LOCALIZED
  /// ```
  /// - **Açıklama:** Hem `ad` hem de `soyad` sütunları, kültüre özgü sıralama kurallarına göre sıralanır.
  ///
  /// 7. **JOIN ile COLLATE Kullanımı:**
  /// ```dart
  /// SQLRaw sql7 = SQLRaw()
  ///   .select("kullanicilar.ad COLLATE LOCALIZED, siparisler.urun")
  ///   .from("kullanicilar")
  ///   .innerJoin("siparisler", "kullanicilar.id = siparisler.kullanici_id")
  ///   .orderBy("kullanicilar.ad COLLATE LOCALIZED");
  /// // Çıktı: SELECT kullanicilar.ad COLLATE LOCALIZED, siparisler.urun FROM kullanicilar INNER JOIN siparisler ON kullanicilar.id = siparisler.kullanici_id ORDER BY kullanicilar.ad COLLATE LOCALIZED
  /// ```
  /// - **Açıklama:** `kullanicilar.ad` sütunundaki değerler, kültüre özgü sıralama kurallarına göre sıralanır ve `siparisler` tablosuyla birleştirilir.
  ///
  /* SQLRaw orderBy(String column, {bool ascending = true, COLLATE? collate}) {
    _query +=
        "ORDER BY $column ${collate != null ? "COLLATE ${collate.name} " : ""}${ascending ? "ASC" : "DESC"} ";
    return this;
  } */

  SQLRaw orderBy(String column) {
    _query += "ORDER BY  $column ";
    return this;
  }

  /* SQLRaw orderBy2(String column, {bool ascending = true, COLLATE? collate}) {
    _query +=
        "ORDER BY $column ${collate != null ? "collate ${collate.name} " : ""} ${ascending ? "ASC" : "DESC"}";
    return this;
  } */

  /// LIMIT ifadesini ekler.
  ///
  /// [count]: Döndürülecek maksimum kayıt sayısı.
  ///
  ////// **Kullanım Sırası:**
  /// - LIMIT, ORDER BY'den sonra gelmelidir.
  /// - OFFSET ile birlikte kullanılabilir.
  ///
  /// **Kısıtlamalar:**
  /// - LIMIT, FROM veya SELECT olmadan kullanılamaz.
  /// - LIMIT, tek başına OFFSET olmadan da kullanılabilir.
  ///
  /// Örnekler:
  /// ```dart
  /// // 1. Tek bir kayıt döndürme
  /// SQLRaw sql1 = SQLRaw().limit(1); // LIMIT 1
  ///
  /// // 2. İlk 10 kaydı döndürme
  /// SQLRaw sql2 = SQLRaw().limit(10); // LIMIT 10
  ///
  /// // 3. OFFSET ile birlikte LIMIT
  /// SQLRaw sql3 = SQLRaw().limit(10).offset(20); // LIMIT 10 OFFSET 20
  ///
  /// // 4. Alt sorgu ile LIMIT
  /// SQLRaw sql4 = SQLRaw().select("*").from("users").limit(5); // SELECT * FROM users LIMIT 5
  /// ```
  SQLRaw limit(int count) {
    _query += "LIMIT $count ";
    return this;
  }

  /// OFFSET ifadesini ekler.
  ///
  /// [count]: Atlanacak kayıt sayısı.
  ///
  /// /// - OFFSET, LIMIT'den sonra gelmelidir.
  /// - OFFSET, tek başına LIMIT olmadan kullanılamaz.
  ///
  /// **Kısıtlamalar:**
  /// - OFFSET, FROM veya SELECT olmadan kullanılamaz.
  /// - OFFSET, sayfalama işlemleri için kullanılır.
  ///
  /// Örnekler:
  /// ```dart
  /// // 1. İlk 5 kaydı atlayarak sorgu yapma
  /// SQLRaw sql1 = SQLRaw().offset(5); // OFFSET 5
  ///
  /// // 2. LIMIT ile birlikte OFFSET
  /// SQLRaw sql2 = SQLRaw().limit(10).offset(20); // LIMIT 10 OFFSET 20
  ///
  /// // 3. Sayfalama için OFFSET
  /// SQLRaw sql3 = SQLRaw().limit(10).offset(30); // LIMIT 10 OFFSET 30
  ///
  /// // 4. Alt sorgu ile OFFSET
  /// SQLRaw sql4 = SQLRaw().select("*").from("users").offset(10); // SELECT * FROM users OFFSET 10
  /// ```
  SQLRaw offset(int count) {
    if (!_query.contains("LIMIT")) {
      throw Exception("OFFSET sadece LIMIT ile kullanılebillir.");
    }
    _query += "OFFSET $count ";
    return this;
  }

  /// Oluşturulan SQL sorgusunu döndürür.
  ///
  /// **Kullanım Sırası:**
  /// - query(), tüm diğer metodlardan sonra çağrılmalıdır.
  ///
  /// **Kısıtlamalar:**
  /// - query(), SQLRaw sınıfının son adımıdır.
  ///
  /// Örnekler:
  /// ```dart
  /// // 1. Basit sorgu
  /// String query1 = SQLRaw().select("*").from("users").query(); // SELECT * FROM users
  ///
  /// // 2. WHERE koşulu ile sorgu
  /// String query2 = SQLRaw().select("name").from("users").where(["age > 18"]).query(); // SELECT name FROM users WHERE age > 18
  ///
  /// // 3. JOIN ve ORDER BY ile sorgu
  /// String query3 = SQLRaw()
  ///   .select("users.name, orders.product")
  ///   .from("users")
  ///   .innerJoin("orders", "users.id = orders.user_id")
  ///   .orderBy("users.name")
  ///   .query();
  /// // SELECT users.name, orders.product FROM users INNER JOIN orders ON users.id = orders.user_id ORDER BY users.name ASC
  ///
  /// // 4. Tam bir sorgu
  /// String query4 = SQLRaw()
  ///   .select("name, age")
  ///   .from("users")
  ///   .whereList(["age > 18", "city = 'Ankara'"], operator: "AND")
  ///   .innerJoin("orders", "users.id = orders.user_id")
  ///   .leftJoin("payments", "users.id = payments.user_id")
  ///   .crossJoin("addresses", "users.id = addresses.user_id")
  ///   .where("email IS NOT NULL AND email != '' AND age < 50" AND Between("age", 18, 40))
  ///   .orderBy("age", ascending: false)
  ///   .limit(10)
  ///   .offset(20)
  ///   .query();
  /// // SELECT name, age FROM users WHERE age > 18 AND city = 'Ankara' ORDER BY age DESC LIMIT 10 OFFSET 20
  /// ```
  String query({bool isPrint = false}) {
    if (_query.trim().isEmpty) {
      throw Exception(
        "Sorgu:$_query\nSorgu boş olamaz. Lütfen gerekli metodları uygulayın..",
      );
    }
    if (isPrint) print("SQL: $_query");
    return _query.trim();
  }
}

/*  /// DİKKAT: RIGHT JOIN SQLİTE ile DESTEKLENMEZ.
  /// RIGHT JOIN (RIGHT OUTER JOIN) ifadesini ekler.
  ///
  /// [table]: Birleştirilecek tablo adı.
  /// [onCondition]: İki tabloyu birleştirmek için kullanılacak koşul.
  ///
  /// Açıklama:
  /// RIGHT JOIN, sağ tablodaki tüm kayıtları ve sol tablodaki eşleşen kayıtları döndürür. Sol tabloda eşleşme bulunmuyorsa, sol tablo sütunları için `NULL` değerler döner.
  ///
  /// Örnek Senaryo:
  /// Tüm siparişleri listelemek istiyoruz, ancak sipariş sahibi olan kullanıcıları da göstermek istiyoruz. Siparişin bir kullanıcıya ait olmaması durumunda kullanıcı bilgileri `NULL` olarak dönecek.
  ///
  /// Örnek Kod:
  /// ```dart
  /// SQLRaw sql1 = SQLRaw()
  ///   .select("kullanicilar.ad, siparisler.urun")
  ///   .from("kullanicilar")
  ///   .rightJoin("siparisler", "kullanicilar.id = siparisler.kullanici_id");
  /// // Çıktı: SELECT kullanicilar.ad, siparisler.urun FROM kullanicilar RIGHT JOIN siparisler ON kullanicilar.id = siparisler.kullanici_id
  /// ```
  ///
  /// Çıktı Açıklaması:
  /// `siparisler` tablosundaki tüm siparişler listelenir. Eğer bir siparişin sahibi yoksa, `kullanicilar.ad` değeri `NULL` olur.
  SQLRaw rightJoin(String table, String onCondition) {
    _query += "RIGHT JOIN $table ON $onCondition ";
    return this;
  } 
  

  /// DİKKAT: FULL JOIN SQLİTE ile DESTEKLENMEZ.
  /// FULL JOIN (FULL OUTER JOIN) ifadesini ekler.
  ///
  /// [table]: Birleştirilecek tablo adı.
  /// [onCondition]: İki tabloyu birleştirmek için kullanılacak koşul.
  ///
  /// Açıklama:
  /// FULL JOIN, iki tablodaki tüm kayıtları döndürür. Eşleşme olmayan kayıtlar için ilgili tablo sütunları `NULL` değer alır.
  ///
  /// Örnek Senaryo:
  /// Tüm kullanıcıları ve tüm siparişleri listelemek istiyoruz. Eğer bir kullanıcı veya sipariş eşleşmiyorsa, ilgili sütunlar `NULL` olarak dönecek.
  ///
  /// Örnek Kod:
  /// ```dart
  /// SQLRaw sql1 = SQLRaw()
  ///   .select("kullanicilar.ad, siparisler.urun")
  ///   .from("kullanicilar")
  ///   .fullJoin("siparisler", "kullanicilar.id = siparisler.kullanici_id");
  /// // Çıktı: SELECT kullanicilar.ad, siparisler.urun FROM kullanicilar FULL JOIN siparisler ON kullanicilar.id = siparisler.kullanici_id
  /// ```
  ///
  /// Çıktı Açıklaması:
  /// Hem `kullanicilar` hem de `siparisler` tablolarındaki tüm kayıtlar listelenir. Eşleşme olmayan kayıtlar için ilgili sütunlar `NULL` değer alır.

  SQLRaw fullJoin(String table, String onCondition) {
    _query += "FULL JOIN $table ON $onCondition ";
    return this;
  }
  
  


  /// COLLATE ifadesini ekler.
  ///
  /// [column]: COLLATE uygulanacak sütun adı.
  /// [collation]: Kullanılacak sıralama kuralı (örneğin, "LOCALIZED", "NOCASE", "BINARY").
  /// **AÇIKLAMA**
  /// ```
  /// COLLATE LOCALIZED: Kültüre özgü sıralama kurallarını uygular. Örneğin, Türkçe karakterlerin doğru sıralanmasını sağlar.
  /// COLLATE NOCASE: Büyük/küçük harf duyarsız karşılaştırma yapar.
  /// COLLATE BINARY: Verinin ikili (binary) değerine göre sıralama veya karşılaştırma yapar.
  /// ```
  /// **Kullanım Sırası:**
  /// - COLLATE, genellikle ORDER BY veya WHERE ifadelerinde kullanılır.
  /// - SELECT, WHERE, ORDER BY, GROUP BY gibi ifadelerden sonra gelmelidir.
  ///
  ///SELECT İfadesinde:
  ///Bir sütun veya ifade üzerinde sıralama veya karşılaştırma yaparken kullanılabilir.
  ///Örnek:
  ///```dart
  ///SELECT ad COLLATE LOCALIZED FROM kullanicilar;
  ///```
  ///Sonuç: ad sütunundaki değerler, kültüre özgü sıralama kurallarına göre işlenir.
  ///
  ///ORDER BY İfadesinde:
  ///Sıralama sırasında COLLATE kullanılabilir.
  ///Örnek:
  /// ```dart
  /// SELECT * FROM kullanicilar ORDER BY ad COLLATE LOCALIZED;
  /// ```
  /// Sonuç: ad sütunundaki değerler, kültüre özgü sıralama kurallarına göre işlenir.
  ///
  /// WHERE Koşulunda:
  ///Karşılaştırma işlemlerinde COLLATE kullanılabilir.
  ///Örnek:
  /// ```dart
  /// SELECT * FROM kullanicilar WHERE ad = 'Ahmet' COLLATE NOCASE;
  /// ```
  /// Sonuç: ad sütunundaki değerler, Büyük/küçük harf duyarsız olarak karşılaştırılır. Örneğin, "Ahmet", "AHMET" veya "ahmet" eşleşir.
  ///
  ///GROUP BY veya HAVING İfadelerinde:
  //Gruplama veya filtreleme sırasında COLLATE kullanılabilir.
  ///Örnek:
  ///```dart
  ///SELECT sehir COLLATE LOCALIZED, COUNT(*) FROM kullanicilar GROUP BY sehir COLLATE LOCALIZED;
  ///```
  ///Sonuç: sehir sütunundaki değerler, kültüre özgü sıralama kurallarına göre işlenir.
  ///
  /// **Kısıtlamalar:**
  /// - COLLATE, yalnızca metin verileri (TEXT) üzerinde kullanılabilir.
  /// - COLLATE, sayısal veya tarih verileri üzerinde kullanılamaz.
  ///
  /// **Kullanım Örnekleri:**
  ///
  /// 1. **Türkçe Karakterlerle Sıralama (ORDER BY ile):**
  /// ```dart
  /// SQLRaw sql1 = SQLRaw()
  ///   .select("*")
  ///   .from("kullanicilar")
  ///   .orderBy("ad COLLATE LOCALIZED");
  /// // Çıktı: SELECT * FROM kullanicilar ORDER BY ad COLLATE LOCALIZED
  /// ```
  /// - **Açıklama:** `ad` sütunundaki değerler, Türkçe karakterlerin doğru sıralanmasını sağlayacak şekilde sıralanır.
  ///
  /// 2. **Büyük/Küçük Harf Duyarsız Karşılaştırma (WHERE ile):**
  /// ```dart
  /// SQLRaw sql2 = SQLRaw()
  ///   .select("*")
  ///   .from("kullanicilar")
  ///   .where(["ad = 'ahmet' COLLATE NOCASE"]);
  /// // Çıktı: SELECT * FROM kullanicilar WHERE ad = 'ahmet' COLLATE NOCASE
  /// ```
  /// - **Açıklama:** `ad` sütunundaki değerler, büyük/küçük harf duyarsız olarak karşılaştırılır. Örneğin, "Ahmet", "AHMET" veya "ahmet" eşleşir.
  ///
  /// 3. **Gruplama ve Sıralama (GROUP BY ve ORDER BY ile):**
  /// ```dart
  /// SQLRaw sql3 = SQLRaw()
  ///   .select("sehir COLLATE LOCALIZED, COUNT(*) AS kullanici_sayisi")
  ///   .from("kullanicilar")
  ///   .groupBy("sehir COLLATE LOCALIZED")
  ///   .orderBy("sehir COLLATE LOCALIZED");
  /// // Çıktı: SELECT sehir COLLATE LOCALIZED, COUNT(*) AS kullanici_sayisi FROM kullanicilar GROUP BY sehir COLLATE LOCALIZED ORDER BY sehir COLLATE LOCALIZED
  /// ```
  /// - **Açıklama:** `sehir` sütunundaki değerler, kültüre özgü sıralama kurallarına göre gruplanır ve sıralanır.
  ///
  /// 4. **LIKE Koşulu ile Büyük/Küçük Harf Duyarsız Arama:**
  /// ```dart
  /// SQLRaw sql4 = SQLRaw()
  ///   .select("*")
  ///   .from("kullanicilar")
  ///   .where(["ad LIKE '%ahmet%' COLLATE NOCASE"]);
  /// // Çıktı: SELECT * FROM kullanicilar WHERE ad LIKE '%ahmet%' COLLATE NOCASE
  /// ```
  /// - **Açıklama:** `ad` sütunundaki değerler, büyük/küçük harf duyarsız olarak aranır. Örneğin, "Ahmet", "AHMET" veya "ahmet" içeren kayıtlar döner.
  ///
  /// 5. **DISTINCT ile Kültüre Özgü Tekil Değerler:**
  /// ```dart
  /// SQLRaw sql5 = SQLRaw()
  ///   .select("DISTINCT sehir COLLATE LOCALIZED")
  ///   .from("kullanicilar")
  ///   .orderBy("sehir COLLATE LOCALIZED");
  /// // Çıktı: SELECT DISTINCT sehir COLLATE LOCALIZED FROM kullanicilar ORDER BY sehir COLLATE LOCALIZED
  /// ```
  /// - **Açıklama:** `sehir` sütunundaki değerler, kültüre özgü sıralama kurallarına göre benzersizleştirilir ve sıralanır.
  ///
  /// 6. **Birden Fazla Sütunda COLLATE Kullanımı:**
  /// ```dart
  /// SQLRaw sql6 = SQLRaw()
  ///   .select("ad COLLATE LOCALIZED, soyad COLLATE LOCALIZED")
  ///   .from("kullanicilar")
  ///   .orderBy("ad COLLATE LOCALIZED, soyad COLLATE LOCALIZED");
  /// // Çıktı: SELECT ad COLLATE LOCALIZED, soyad COLLATE LOCALIZED FROM kullanicilar ORDER BY ad COLLATE LOCALIZED, soyad COLLATE LOCALIZED
  /// ```
  /// - **Açıklama:** Hem `ad` hem de `soyad` sütunları, kültüre özgü sıralama kurallarına göre sıralanır.
  ///
  /// 7. **JOIN ile COLLATE Kullanımı:**
  /// ```dart
  /// SQLRaw sql7 = SQLRaw()
  ///   .select("kullanicilar.ad COLLATE LOCALIZED, siparisler.urun")
  ///   .from("kullanicilar")
  ///   .innerJoin("siparisler", "kullanicilar.id = siparisler.kullanici_id")
  ///   .orderBy("kullanicilar.ad COLLATE LOCALIZED");
  /// // Çıktı: SELECT kullanicilar.ad COLLATE LOCALIZED, siparisler.urun FROM kullanicilar INNER JOIN siparisler ON kullanicilar.id = siparisler.kullanici_id ORDER BY kullanicilar.ad COLLATE LOCALIZED
  /// ```
  /// - **Açıklama:** `kullanicilar.ad` sütunundaki değerler, kültüre özgü sıralama kurallarına göre sıralanır ve `siparisler` tablosuyla birleştirilir.
  ///
  SQLRaw collate(COLLATE collation) {
    _query += " COLLATE $collation ";
    return this;
  }
  */
