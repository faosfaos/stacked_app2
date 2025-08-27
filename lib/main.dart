import 'package:flutter/material.dart';
import 'package:stacked_app2/app/app.bottomsheets.dart';
import 'package:stacked_app2/app/app.dialogs.dart';

/// Dependency injection için locator konfigürasyonu
import 'package:stacked_app2/app/app.locator.dart';

/// Uygulama rotaları ve navigasyon ayarları
import 'package:stacked_app2/app/app.router.dart';

/// Stacked mimarisi için gerekli servisler
import 'package:stacked_services/stacked_services.dart';

/// Bazi widgetler [Column, Text, vs..] ve Dialoglar, öğrencilerimin destegi ile yazdigim
/// o_package modulunden kullanıldı..
/// Detaylar icin ("module/o_package") o_package modulunu inceleyebilir, gelistirebilir
/// ve projelerinizde kullanabilirsiniz..
/// Bazi Form yapilarinda kullanilan [FormBuilder] sinifi
/// port edilerek o_package sinifina entegre edildi
/// [FormBuilder] yapimcilarina tesekkurler..
/// toIntForNullable(), intToBoolFlexible() gibi isinizi
/// kolaylastiracak extensionslara o_package modulunden ulasabilirsiniz..
/// Hepinize basarilar

/// Uygulamanın giriş noktası ve temel konfigürasyonların yapıldığı main fonksiyonu
/// Flutter widget'larını başlatır ve gerekli servisleri ayarlar
Future<void> main() async {
  /// Flutter widget binding'ini başlatır, async işlemler için gerekli
  WidgetsFlutterBinding.ensureInitialized();

  /// Dependency injection container'ını kurur
  await setupLocator();

  /// Dialog UI konfigürasyonunu yapar
  setupDialogUi();

  /// Bottom sheet UI konfigürasyonunu yapar
  setupBottomSheetUi();

  /// Ana uygulama widget'ını çalıştırır
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      /// Uygulamanın tema ayarları
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.dark,
        ),
      ),

      /// Uygulama açıldığında gösterilecek ilk sayfa
      initialRoute: Routes.homeView,

      /// Route üretimi için Stacked router'ını kullan
      onGenerateRoute: StackedRouter().onGenerateRoute,

      /// Global navigasyon anahtarı, servislerden erişim için
      navigatorKey: StackedService.navigatorKey,

      /// Route değişikliklerini izlemek için observer
      navigatorObservers: [StackedService.routeObserver],
    );
  }
}
