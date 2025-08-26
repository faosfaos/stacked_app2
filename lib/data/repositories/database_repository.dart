import 'package:stacked_app2/models/todo.dart';

abstract class DataBaseRepository {
  Future<List<Todo>> fetchTodos({required String tableName});
  Future<int> addTodo({required String tableName, required Todo todo});
  Future<int> updateTodo({required String tableName, required Todo todo});
  Future<int> toggleTodo({required String tableName, required Todo todo});
  Future<int> deleteTodo({required String tableName, required int todoID});
}
