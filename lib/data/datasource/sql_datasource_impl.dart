// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:stacked_app2/data/repositories/database_repository.dart';
import 'package:stacked_app2/models/todo.dart';
import 'package:stacked_app2/services/sql_database_service.dart';

class SqlDatasourceImpl implements DataBaseRepository {
  SqlDatasourceImpl({required SqlDatabaseService sqlDatabaseService})
      : _sqlDatabaseService = sqlDatabaseService;

  final SqlDatabaseService _sqlDatabaseService;

  @override
  Future<int> addTodo({required String tableName, required Todo todo}) async {
    final db = await _sqlDatabaseService.database;
    int eklenenID = await db.insert(
      tableName,
      todo.toMap(),
    );
    return eklenenID;
  }

  @override
  Future<int> deleteTodo({
    required String tableName,
    required int todoID,
  }) async {
    final db = await _sqlDatabaseService.database;

    int silinenKayitSayisi = await db.delete(
      tableName,
      where: "id=?",
      whereArgs: [todoID],
    );
    return silinenKayitSayisi;
  }

  @override
  Future<List<Todo>> fetchTodos({required String tableName}) async {
    final db = await _sqlDatabaseService.database;

    List<Map<String, dynamic>> todoMap = await db.query(tableName);
    List<Todo> todoList = todoMap.map((e) => Todo.fromMap(e)).toList();
    return todoList;
  }

  @override
  Future<int> toggleTodo({
    required String tableName,
    required Todo todo,
  }) async {
    final db = await _sqlDatabaseService.database;

    todo = todo.copyWith(isDone: !(todo.isDone ?? false));
    int guncellenenKayitSaiyisi = await db
        .update(tableName, todo.toMap(), where: "id=?", whereArgs: [todo.id]);
    return guncellenenKayitSaiyisi;
  }

  @override
  Future<int> updateTodo({
    required String tableName,
    required Todo todo,
  }) async {
    final db = await _sqlDatabaseService.database;

    int guncellenenKayitSaiyisi = await db.update(
      tableName,
      todo.toMap(),
      where: "id=?",
      whereArgs: [todo.id],
    );
    return guncellenenKayitSaiyisi;
  }
}
