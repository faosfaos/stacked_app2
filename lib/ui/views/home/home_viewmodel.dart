import 'package:stacked/stacked.dart';
import 'package:stacked_app2/core/constants/database_constants.dart';
import 'package:stacked_app2/core/constants/used_database.dart';
import 'package:stacked_app2/data/repositories/database_repository.dart';
import 'package:stacked_app2/models/todo.dart';

class HomeViewModel extends BaseViewModel {
  final DataBaseRepository _dataBaseRepository;

  HomeViewModel({DataBaseRepository? dataBaseRepository})
      : _dataBaseRepository = dataBaseRepository ?? usedDatabase;
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

  Future<void> updateTodo(Todo todo) async {
    await _dataBaseRepository.updateTodo(
      tableName: DatabaseConstants.todoTable,
      todo: todo,
    );
  }

  void toggleTodo(Todo todo) async {
    await _dataBaseRepository.toggleTodo(
      tableName: DatabaseConstants.todoTable,
      todo: todo,
    );
  }
}
