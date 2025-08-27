// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:stacked_app2/core/constants/database_constants.dart';
import 'package:stacked_app2/data/repositories/todo_repository.dart';
import 'package:stacked_app2/models/todo.dart';
import 'package:stacked_app2/services/sql_database_service.dart';

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl({required SqlDatabaseService sqlDatabaseService})
      : _sqlDatabaseService = sqlDatabaseService;

  final SqlDatabaseService _sqlDatabaseService;

  @override
  Future<int> addTodo({required Todo todo}) async {
    final db = await _sqlDatabaseService.database;

    int eklenenID = await db.insert(DatabaseConstants.todoTable, todo.toMap());
    return eklenenID;
  }

  @override
  Future<int> deleteTodo({required int todoID}) async {
    final db = await _sqlDatabaseService.database;

    int silinenKayitSayisi = await db.delete(
      DatabaseConstants.todoTable,
      where: "id=?",
      whereArgs: [todoID],
    );
    return silinenKayitSayisi;
  }

  @override
  Future<List<Todo>> fetchTodos() async {
    final db = await _sqlDatabaseService.database;

    List<Map<String, dynamic>> todoMap = await db.query(
      DatabaseConstants.todoTable,
    );
    List<Todo> todoList = todoMap.map((e) => Todo.fromMap(e)).toList();
    return todoList;
  }

  @override
  Future<int> toggleTodo({required Todo todo}) async {
    final db = await _sqlDatabaseService.database;

    todo = todo.copyWith(isDone: !(todo.isDone ?? false));
    int guncellenenKayitSaiyisi = await db.update(
        DatabaseConstants.todoTable, todo.toMap(),
        where: "id=?", whereArgs: [todo.id]);
    return guncellenenKayitSaiyisi;
  }

  @override
  Future<int> updateTodo({required Todo todo}) async {
    final db = await _sqlDatabaseService.database;

    int guncellenenKayitSaiyisi = await db.update(
      DatabaseConstants.todoTable,
      todo.toMap(),
      where: "id=?",
      whereArgs: [todo.id],
    );
    return guncellenenKayitSaiyisi;
  }
}
