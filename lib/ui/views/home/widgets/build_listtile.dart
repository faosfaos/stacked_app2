part of '../home_view.dart';

/// Todo öğelerini liste halinde gösteren widget
/// HookWidget'dan türetilmiş olup reactive state management sağlar
class BuildListTile extends HookWidget {
  /// Constructor - Todo ve ViewModel instance'larını alır
  const BuildListTile({
    super.key,
    required this.todo,
    required this.viewModel,
  });

  /// Gösterilecek todo objesi
  final Todo todo;

  /// Ana sayfa ViewModel'i
  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    // Debug amaçlı log - hangi todo'nun build edildiğini gösterir
    "-> Build ListTile - ${todo.title}".log();

    // Hook state'leri - değişiklikleri reactive olarak takip eder
    var isDone = useState(todo.isDone); // Tamamlanma durumu
    var title = useState(todo.title); // Başlık
    var content = useState(todo.content); // İçerik

    return ListTile(
      // Başlık - tamamlanmışsa üstü çizili gösterilir
      title: title.value.oText
          .combineTextDecoration(lineThrough: isDone.value ?? false)
          .make(),
      // Alt başlık - boş değilse gösterilir ve tamamlanmışsa üstü çizili
      subtitle: content.value == null || content.value!.isEmpty
          ? null
          : content.value?.oText
              .combineTextDecoration(lineThrough: isDone.value ?? false)
              .make(),
      leading: IconButton(
          onPressed: () {
            // Silme dialog'unu göster
            DialogUtils.showDeleteDialog(context, todo, viewModel);
          },
          icon: Icon(
            Icons.delete,
            color: context.themePrimaryColor,
          )),
      trailing: Checkbox(
        value: isDone.value,
        onChanged: (value) {
          // Checkbox değiştiğinde state'i güncelle ve toggle işlemini çağır
          isDone.value = value;
          viewModel.toggleTodo(todo);
        },
      ),
      // Uzun basıldığında güncelleme dialog'unu aç
      onLongPress: () async {
        Todo? updatedTodo = await DialogUtils.showUpdateDialog(
          context,
          viewModel,
          todo.copyWith(
            title: title.value,
            content: content.value,
            isDone: isDone.value,
          ),
        );
        // Dialog'dan dönen güncelleme varsa state'leri güncelle
        // Null doberse var olan degerleri ata
        title.value = updatedTodo?.title ?? title.value;
        content.value = updatedTodo?.content ?? content.value;
      },
    );
  }
}
