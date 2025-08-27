import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:o_package/o_extensions.dart';
import 'package:o_package/o_widget/animation_dialog/animation_dialog.dart';
import 'package:o_package/o_widget/o_form_builder/flutter_form_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_app2/models/todo.dart';
import 'home_viewmodel.dart';

part '../home/widgets/build_listview.dart';
part '../home/widgets/dialog_utils.dart';
part '../home/widgets/build_listtile.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: "- GÖREVLER -"
            .oText
            .bold
            .color(context.themePrimaryColor)
            .make()
            .oCenter(),
      ),
      body: SafeArea(child: _buildBody(context, viewModel)),
      floatingActionButton: buildFAB(context, viewModel),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
  @override
  bool get reactive => false;
}

Widget _buildBody(BuildContext context, HomeViewModel viewModel) {
  "1-Build BODY\n--------------------".log();
  return [
    BuildListView(viewModel: viewModel),
  ].oColumn.make();
}

Widget buildFAB(BuildContext context, HomeViewModel viewModel) {
  return FloatingActionButton(
    onPressed: () => DialogUtils.showAddDialog(context, viewModel),
    child: const Icon(Icons.add),
  );
}
