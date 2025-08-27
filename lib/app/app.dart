import 'package:stacked_app2/data/datasource/todo_repository_impl.dart';
import 'package:stacked_app2/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:stacked_app2/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:stacked_app2/ui/views/home/home_view.dart';
import 'package:stacked_app2/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_app2/services/sql_database_service.dart';

import '../data/repositories/todo_repository.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: SqlDatabaseService),
    //LazySingleton(classType: SqlDatasourceImpl, asType: DataBaseRepository)
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
