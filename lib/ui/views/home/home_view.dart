import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:o_package/o_extensions.dart';
import 'package:o_package/o_widget/animation_dialog/animation_dialog.dart';
import 'package:o_package/o_widget/o_form_builder/flutter_form_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_app2/models/todo.dart';
import 'home_viewmodel.dart';

// ListView widget'ını içeren part dosyası
part '../home/widgets/build_listview.dart';
// Dialog utilities'ini içeren part dosyası
part '../home/widgets/dialog_utils.dart';
// ListTile widget'ını içeren part dosyası
part '../home/widgets/build_listtile.dart';

// Ana ekran görünümü sınıfı - Stacked mimarisine dayalı
class HomeView extends StackedView<HomeViewModel> {
  // Sınıf constructor'ı - opsiyonel key parametresi ile
  const HomeView({Key? key}) : super(key: key);

  // Widget oluşturucu metod - UI'ın nasıl görüneceğini tanımlar
  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      // Üst app bar'ı - başlık ile birlikte
      appBar: AppBar(
        title: "- GÖREVLER -" // Başlık metni
            .oText // O package text extension'ı
            .bold // Kalın yazı stili
            .color(context.themePrimaryColor) // Tema rengi uygulama
            .make() // Widget'a dönüştürme
            .oCenter(), // Ortalama
      ),
      // Ana gövde - (SafeArea) güvenli alan içinde
      body: SafeArea(child: _buildBody(context, viewModel)),
      // Sağ alt köşedeki FAB butonu
      floatingActionButton: buildFAB(context, viewModel),
    );
  }

  // ViewModel örneği oluşturucu metod
  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
  // Reaktif dinleme özelliği - kapalı
  @override
  bool get reactive => false;
}

// Ana gövde widget'ını oluşturan fonksiyon
Widget _buildBody(BuildContext context, HomeViewModel viewModel) {
  // Debug log mesajı - gövde oluşturulduğunu belirten
  "1-Build BODY\n--------------------".log();
  // Widget listesini dikey sütun halinde döndüren yapı
  return [
    // ListView widget' sınıfı
    BuildListView(viewModel: viewModel),
  ].oColumn.make();
}

//(FAB) oluşturan fonksiyon
Widget buildFAB(BuildContext context, HomeViewModel viewModel) {
  return FloatingActionButton(
    // Butona tıklandığında çalışacak fonksiyon
    // Yeni görev ekleme dialog'u açar
    onPressed: () => DialogUtils.showAddDialog(context, viewModel),
    child: const Icon(Icons.add),
  );
}
