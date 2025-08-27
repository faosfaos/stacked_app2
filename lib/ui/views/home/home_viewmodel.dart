import 'package:stacked/stacked.dart';
import 'package:stacked_app2/core/constants/used_database.dart';
import 'package:stacked_app2/data/repositories/database_repository.dart';
import 'package:stacked_app2/models/todo.dart';

class HomeViewModel extends BaseViewModel {
  final DataBaseRepository _dataBaseRepository;

  HomeViewModel({DataBaseRepository? dataBaseRepository})
      : _dataBaseRepository = dataBaseRepository ?? usedDatabase;
  List<Todo> todoList = [];

  void fetchTodos() async {
    todoList = await runBusyFuture(_dataBaseRepository.fetchTodos(),
        busyObject: todoList);
  }

  void addTodo(Todo todo) async {
    await _dataBaseRepository.addTodo(todo: todo);
    fetchTodos();
  }

  void deleteTodo(Todo todo) async {
    await _dataBaseRepository.deleteTodo(todoID: todo.id ?? -1);
    fetchTodos();
  }

  Future<void> updateTodo(Todo todo) async {
    await _dataBaseRepository.updateTodo(todo: todo);
  }

  void toggleTodo(Todo todo) async {
    await _dataBaseRepository.toggleTodo(todo: todo);
  }
}
