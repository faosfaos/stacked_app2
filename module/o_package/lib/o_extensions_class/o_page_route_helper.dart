import 'package:flutter/material.dart';

extension PageRouteExtension on BuildContext {
  OPageRouteHelper get goTo => OPageRouteHelper(this);
}

/// Sayfalar arası yönlendirme işlemlerini merkezi olarak yönetmek için oluşturulan yardımcı sınıftır.
/// Bu sınıf üzerinden Navigator ile sayfa geçişleri daha temiz ve okunabilir bir şekilde yapılır.
class OPageRouteHelper {
  final BuildContext _context;

  /// Oluşturucu dışarıdan örneklenmesin diye gizlendi.
  OPageRouteHelper(BuildContext context) : _context = context;

  /// Yeni bir sayfaya gitmek için kullanılır.
  /// Önceki sayfa geri dönülebilir olarak kalır.
  ///
  /// [page]: Gözükecek yeni sayfa widget'ı
  Future<T?> page<T>({required Widget page}) async {
    return Navigator.push(_context, MaterialPageRoute(builder: (_) => page));
  }

  /// Yeni bir sayfaya gider ve geçmişteki tüm sayfaları siler.
  /// Eğer [removeMainPage] true ise sadece ilk sayfaya kadar siler.
  ///
  /// Genellikle login sonrası anasayfaya yönlendirme gibi durumlarda kullanılır.
  ///
  /// [page]: Gözükecek yeni sayfa widget'ı
  ///
  /// [removeMainPage]: Ana sayfaya kadar silinsin mi? (true) / Tüm geçmiş silinsin mi? (false)
  void pageAndRemoveUntil({required Widget page, bool removeMainPage = false}) {
    Navigator.pushAndRemoveUntil(
      _context,
      MaterialPageRoute(builder: (_) => page),
      (route) => removeMainPage ? route.isFirst : false,
    );
  }

  /// En baştaki ilk sayfaya kadar tüm sayfalardan çıkar.
  /// Kullanıcıyı uygulamanın en başındaki sayfaya götürür.
  void popUntilFirst() {
    Navigator.popUntil(_context, (route) => route.isFirst);
  }

  /// Şu anki sayfayı kapatmadan yerine yeni bir sayfa açar.
  /// Eski sayfa artık geçmişte yer almaz.
  ///
  /// [page]: Gözükecek yeni sayfa widget'ı
  void replaceWithPage({required Widget page}) {
    Navigator.pushReplacement(
      _context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Mevcut sayfadan bir önceki sayfaya dönmek için kullanılır.
  /// Geri dönebilecek bir sayfa varsa işlem yapılır.
  void back<T>([T? result]) {
    if (Navigator.canPop(_context)) {
      Navigator.pop(_context, result);
    }
  }

  /// Mevcut sayfadan bir önceki sayfaya dönmek için kullanılır.
  /// Geri dönebilecek bir sayfa varsa işlem yapılır.
  void pop<T>([T? result]) {
    if (Navigator.canPop(_context)) {
      Navigator.pop(_context, result);
    }
  }
}
