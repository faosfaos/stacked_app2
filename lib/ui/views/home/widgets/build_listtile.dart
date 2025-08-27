part of '../home_view.dart';

class BuildListTile extends HookWidget {
  const BuildListTile({
    super.key,
    required this.todo,
    required this.viewModel,
  });
  final Todo todo;
  final HomeViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    "3-Build ListTile - ${todo.title}".log();
    var isDone = useState(todo.isDone);
    var title = useState(todo.title);
    var content = useState(todo.content);
    return ListTile(
      title: title.value.oText
          .combineTextDecoration(lineThrough: isDone.value ?? false)
          .make(),
      subtitle: content.value == null || content.value!.isEmpty
          ? null
          : content.value?.oText
              .combineTextDecoration(lineThrough: isDone.value ?? false)
              .make(),
      leading: IconButton(
          onPressed: () {
            DialogUtils.showDeleteDialog(context, todo, viewModel);
          },
          icon: Icon(
            Icons.delete,
            color: context.themePrimaryColor,
          )),
      trailing: Checkbox(
        value: isDone.value,
        onChanged: (value) {
          isDone.value = value;
          viewModel.toggleTodo(todo);
        },
      ),
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
        title.value = updatedTodo?.title ?? title.value;
        content.value = updatedTodo?.content ?? content.value;
      },
    );
  }
}
