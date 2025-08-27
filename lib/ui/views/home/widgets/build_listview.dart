part of '../home_view.dart';

/// Todo listesini görüntüleyen ListView widget'ı
/// StatelessWidget'dan türetilmiş olup ViewModelBuilder kullanarak reactive yapı sağlar
class BuildListView extends StatelessWidget {
  /// Constructor - HomeViewModel instance'ını alır
  const BuildListView({super.key, required this.viewModel});
  
  /// Ana sayfa ViewModel'i
  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    // Debug amaçlı log - ListView'in build edildiğini gösterir
    "2-Build ListView\n--------------------".log();
    
    // ViewModelBuilder.reactive kullanarak reactive yapı oluşturur
    return ViewModelBuilder.reactive(
      // ViewModel instance'ını sağlar
      viewModelBuilder: () => viewModel,
      // ViewModel hazır olduğunda çalışır - todo'ları getirir
      onViewModelReady: (viewModel) {
        viewModel.fetchTodos();
      },
      // UI builder - ViewModel değişikliklerini dinler ve UI'ı günceller
      builder: (context, viewModel, child) {
        return ListView.builder(
          // Todo listesinin uzunluğu kadar item oluştur
          itemCount: viewModel.todoList.length,
          // Her todo için ListTile widget'ı oluştur
          itemBuilder: (context, index) {
            var todo = viewModel.todoList[index];
            return BuildListTile(
                key: todo.toKey, // Unique key for efficient rebuilding
                todo: todo, 
                viewModel: viewModel);
          },
        ).oExpand(); // Extension method - widget'ı expand eder
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
