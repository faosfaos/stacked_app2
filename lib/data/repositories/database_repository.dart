import 'package:stacked_app2/models/todo.dart';

abstract class DataBaseRepository {
  Future<List<Todo>> fetchTodos();
  Future<int> addTodo({required Todo todo});
  Future<int> updateTodo({required Todo todo});
  Future<int> toggleTodo({required Todo todo});
  Future<int> deleteTodo({required int todoID});
}
