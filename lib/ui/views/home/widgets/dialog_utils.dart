part of '../home_view.dart';

class DialogUtils {
  static const String _titleFieldName = "title";
  static const String _contentFieldName = "content";

  static Future<dynamic> showDeleteDialog(
    BuildContext context,
    Todo todo,
    HomeViewModel viewModel,
  ) {
    return oDialog.showDelete(
      context: context,
      deletedItemName: todo.title,
      onConfirm: () {
        Navigator.pop(context);
        viewModel.deleteTodo(todo);
      },
    );
  }

  static Future<dynamic> showAddDialog(
    BuildContext context,
    HomeViewModel viewModel,
  ) {
    return oDialog.showForm(
      context: context,
      title: "Görev Ekle".oText.make(),
      formFields: _buildFormFields(),
      onConfirm: (formKey) => _handleAddTodo(context, formKey, viewModel),
    );
  }

  static Future<dynamic> showUpdateDialog(
    BuildContext context,
    HomeViewModel viewModel,
    Todo todo,
  ) {
    return oDialog.showForm(
      context: context,
      title: "Görev Güncelle".oText.make(),
      formFields: _buildFormFields(
        initialTitle: todo.title,
        initialContent: todo.content,
      ),
      onConfirm: (formKey) =>
          _handleUpdateTodo(context, formKey, viewModel, todo),
    );
  }

  static List<Widget> _buildFormFields({
    String? initialTitle,
    String? initialContent,
  }) {
    return [
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
        validator: (value) => value.validateNullOrNotEmpty(),
      ),
      8.height,
      OFormBuilderTextField(
        name: _contentFieldName,
        initialValue: initialContent,
        maxLines: 3,
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

  static void _handleAddTodo(
    BuildContext context,
    GlobalKey<OFormBuilderState> formKey,
    HomeViewModel viewModel,
  ) {
    Navigator.pop(context);

    final value = formKey.currentState!.value; // Validator garantiliyor

    final newTodo = Todo(
      title: value[_titleFieldName],
      content: value[_contentFieldName],
    );
    viewModel.addTodo(newTodo);
  }

  static void _handleUpdateTodo(
    BuildContext context,
    GlobalKey<OFormBuilderState> formKey,
    HomeViewModel viewModel,
    Todo todo,
  ) async {
    final value = formKey.currentState?.value;

    final title = value?[_titleFieldName];
    final content = value?[_contentFieldName];
    Todo newTodo = Todo(
      title: title,
      content: content,
      id: todo.id,
      isDone: todo.isDone,
    );

    viewModel.updateTodo(newTodo);
    Navigator.pop(context, newTodo);
  }
}
