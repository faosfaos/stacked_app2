import 'package:stacked/stacked.dart';
import 'package:stacked_app2/app/app.locator.dart';
import 'package:stacked_app2/core/constants/database_constants.dart';
import 'package:stacked_app2/data/datasource/sql_datasource_impl.dart';
import 'package:stacked_app2/data/repositories/database_repository.dart';
import 'package:stacked_app2/models/todo.dart';
import 'package:stacked_app2/services/sql_database_service.dart';

class HomeViewModel extends BaseViewModel {
  final DataBaseRepository _dataBaseRepository;

  HomeViewModel()
      : _dataBaseRepository = SqlDatasourceImpl(
          sqlDatabaseService: locator<SqlDatabaseService>(),
        );
  List<Todo> todoList = [];

  void fetchTodos() async {
    todoList = await runBusyFuture(
      _dataBaseRepository.fetchTodos(tableName: DatabaseConstants.todoTable),
      busyObject: todoList,
    );
  }

  void addTodo(Todo todo) async {
    await _dataBaseRepository.addTodo(
        tableName: DatabaseConstants.todoTable, todo: todo);
    fetchTodos();
  }

  void deleteTodo(Todo todo) async {
    await _dataBaseRepository.deleteTodo(
      tableName: DatabaseConstants.todoTable,
      todoID: todo.id ?? -1,
    );
    fetchTodos();
  }

  void updateTodo(Todo todo) async {
    await _dataBaseRepository.updateTodo(
      tableName: DatabaseConstants.todoTable,
      todo: todo,
    );
    fetchTodos();
  }

  void toggleTodo(Todo todo) {
    _dataBaseRepository.toggleTodo(
      tableName: DatabaseConstants.todoTable,
      todo: todo,
    );
    fetchTodos();
  }
}
