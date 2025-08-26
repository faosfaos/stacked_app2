part of '../home_view.dart';

class BuildListView extends StatelessWidget {
  const BuildListView({super.key, required this.viewModel});
  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => viewModel,
      onViewModelReady: (viewModel) {
        viewModel.fetchTodos();
      },
      builder: (context, viewModel, child) {
        "2-Build ListView".log();
        return ListView.builder(
          itemCount: viewModel.todoList.length,
          itemBuilder: (context, index) {
            var todo = viewModel.todoList[index];
            return ListTile(
              title: todo.title.oText
                  .combineTextDecoration(
                    lineThrough: todo.isDone ?? false,
                  )
                  .make(),
              subtitle: todo.content?.oText
                  .combineTextDecoration(
                    lineThrough: todo.isDone ?? false,
                  )
                  .make(),
              leading: IconButton(
                  onPressed: () {
                    DialogUtils.showDeleteDialog(context, todo, viewModel);
                    //deleteDialog(context, todo, viewModel);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: context.themePrimaryColor,
                  )),
              trailing: Checkbox(
                value: todo.isDone,
                onChanged: (value) {
                  viewModel.toggleTodo(todo);
                },
              ),
              onLongPress: () {
                DialogUtils.showUpdateDialog(context, viewModel, todo);
              },
            );
          },
        ).oExpand();
      },
    );
  }
}
