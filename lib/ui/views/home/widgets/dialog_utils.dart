part of '../home_view.dart';

/// Dialog işlemlerini yöneten utility sınıfı
/// Todo ekleme, güncelleme ve silme dialog'larını içerir
class DialogUtils {
  /// Form field isimleri - sabit değerler
  static const String _titleFieldName = "title";
  static const String _contentFieldName = "content";

  /// Todo silme onay dialog'unu gösterir
  /// Kullanıcıdan silme işlemini onaylamasını ister
  static Future<dynamic> showDeleteDialog(
    BuildContext context,
    Todo todo,
    HomeViewModel viewModel,
  ) {
    return oDialog.showDelete(
      context: context,
      deletedItemName: todo.title, // Silinecek todo'nun başlığı
      onConfirm: () {
        Navigator.pop(context); // Dialog'u kapat
        viewModel.deleteTodo(todo); // Todo'yu sil
      },
    );
  }

  /// Yeni todo ekleme dialog'unu gösterir
  /// Başlık ve açıklama alanları içeren form sunar
  static Future<dynamic> showAddDialog(
    BuildContext context,
    HomeViewModel viewModel,
  ) {
    return oDialog.showForm(
      context: context,
      title: "Görev Ekle".oText.make(),
      formFields: _buildFormFields(), // Form alanlarını oluştur
      onConfirm: (formKey) => _handleAddTodo(context, formKey, viewModel),
    );
  }

  /// Mevcut todo'yu güncelleme dialog'unu gösterir
  /// Var olan değerlerle dolu form sunar
  static Future<dynamic> showUpdateDialog(
    BuildContext context,
    HomeViewModel viewModel,
    Todo todo,
  ) {
    return oDialog.showForm(
      context: context,
      title: "Görev Güncelle".oText.make(),
      formFields: _buildFormFields(
        initialTitle: todo.title,     // Mevcut başlık
        initialContent: todo.content, // Mevcut açıklama
      ),
      onConfirm: (formKey) =>
          _handleUpdateTodo(context, formKey, viewModel, todo),
    );
  }

  /// Form alanlarını oluşturan private metot
  /// Başlık (zorunlu) ve açıklama (opsiyonel) alanları içerir
  static List<Widget> _buildFormFields({
    String? initialTitle,
    String? initialContent,
  }) {
    return [
      // Başlık alanı - zorunlu field
      OFormBuilderTextField(
        name: _titleFieldName,
        initialValue: initialTitle,
        decoration: InputDecoration(
          labelText: "* Başlık",
          hintText: "Başlık girin",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        validator: (value) => value.validateNullOrNotEmpty(), // Boş olamaz
      ),
      8.height, // Alanlar arası boşluk
      // Açıklama alanı - opsiyonel, çok satırlı
      OFormBuilderTextField(
        name: _contentFieldName,
        initialValue: initialContent,
        maxLines: 3, // 3 satır yükseklik
        decoration: InputDecoration(
          labelText: "Açıklama",
          hintText: "Açıklama girin",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    ];
  }

  /// Yeni todo ekleme işlemini gerçekleştiren private metot
  /// Form verilerini alır ve yeni todo oluşturur
  static void _handleAddTodo(
    BuildContext context,
    GlobalKey<OFormBuilderState> formKey,
    HomeViewModel viewModel,
  ) {
    Navigator.pop(context); // Dialog'u kapat

    final value = formKey.currentState!.value; // Form verilerini al (validator garantiliyor)

    // Yeni todo objesi oluştur
    final newTodo = Todo(
      title: value[_titleFieldName],
      content: value[_contentFieldName],
    );
    viewModel.addTodo(newTodo); // ViewModel'e todo'yu ekle
  }

  /// Mevcut todo güncelleme işlemini gerçekleştiren private metot
  /// Form verilerini alır ve todo'yu günceller
  static void _handleUpdateTodo(
    BuildContext context,
    GlobalKey<OFormBuilderState> formKey,
    HomeViewModel viewModel,
    Todo todo,
  ) async {
    final value = formKey.currentState?.value; // Form verilerini al

    final title = value?[_titleFieldName];
    final content = value?[_contentFieldName];
    
    // Güncellenmiş todo objesi oluştur (ID ve isDone değerlerini koru)
    Todo newTodo = Todo(
      title: title,
      content: content,
      id: todo.id,           // Mevcut ID'yi koru
      isDone: todo.isDone,   // Mevcut tamamlanma durumunu koru
    );

    viewModel.updateTodo(newTodo); // ViewModel'de güncelle
    Navigator.pop(context, newTodo); // Dialog'u kapat ve güncellenmiş todo'yu geri döndür
  }
}
