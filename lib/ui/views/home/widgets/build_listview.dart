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
            return BuildListTile(
                key: todo.toKey, todo: todo, viewModel: viewModel);
          },
        ).oExpand();
      },
    );
  }
}

/* class BuildListView extends StackedView<HomeViewModel> {
  const BuildListView2({super.key, required this.viewModel});
  final HomeViewModel viewModel;

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    "2-Build ListView".log();
    return ListView.builder(
      itemCount: viewModel.todoList.length,
      itemBuilder: (context, index) {
        var todo = viewModel.todoList[index];
        return BuildListTile(todo: todo, viewModel: viewModel);
      },
    ).oExpand();
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) {
    return viewModel;
  }

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.fetchTodos();
  }
}
 */
