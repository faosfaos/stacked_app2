// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:stacked_app2/core/constants/database_constants.dart';
import 'package:stacked_app2/data/repositories/todo_repository.dart';
import 'package:stacked_app2/models/todo.dart';
import 'package:stacked_app2/services/sql_database_service.dart';

/// TodoRepository interface'ini implement eden concrete sınıf
/// SQL veritabanı işlemlerini gerçekleştirir
class TodoRepositoryImpl implements TodoRepository {
  /// Constructor - SqlDatabaseService dependency injection ile alınır
  TodoRepositoryImpl({required SqlDatabaseService sqlDatabaseService})
      : _sqlDatabaseService = sqlDatabaseService;

  /// Veritabanı servis instance'ı
  final SqlDatabaseService _sqlDatabaseService;

  /// Yeni bir todo ekler ve eklenen kaydın ID'sini döndürür
  @override
  Future<int> addTodo({required Todo todo}) async {
    // Veritabanı bağlantısını al
    final db = await _sqlDatabaseService.database;

    // Todo'yu veritabanına ekle ve ID'yi al
    int eklenenID = await db.insert(DatabaseConstants.todoTable, todo.toMap());
    return eklenenID;
  }

  /// Belirli ID'ye sahip todo'yu siler ve silinen kayıt sayısını döndürür
  @override
  Future<int> deleteTodo({required int todoID}) async {
    // Veritabanı bağlantısını al
    final db = await _sqlDatabaseService.database;

    // Belirli ID'ye sahip todo'yu sil
    int silinenKayitSayisi = await db.delete(
      DatabaseConstants.todoTable,
      where: "id=?", // WHERE koşulu
      whereArgs: [todoID], // WHERE parametresi
    );
    return silinenKayitSayisi;
  }

  /// Tüm todo'ları getirir ve liste halinde döndürür
  @override
  Future<List<Todo>> fetchTodos() async {
    // Veritabanı bağlantısını al
    final db = await _sqlDatabaseService.database;

    // Tüm todo kayıtlarını sorgula
    List<Map<String, dynamic>> todoMap = await db.query(
      DatabaseConstants.todoTable,
    );
    // Map'leri Todo objelerine çevir
    List<Todo> todoList = todoMap.map((e) => Todo.fromMap(e)).toList();
    return todoList;
  }

  /// Todo'nun tamamlanma durumunu toggle eder (yapıldı/yapılmadı)
  @override
  Future<int> toggleTodo({required Todo todo}) async {
    // Veritabanı bağlantısını al
    final db = await _sqlDatabaseService.database;

    // Todo'nun isDone durumunu tersine çevir
    todo = todo.copyWith(isDone: !(todo.isDone ?? false));
    // Güncellenen todo'yu veritabanına kaydet
    int guncellenenKayitSaiyisi = await db.update(
        DatabaseConstants.todoTable, todo.toMap(),
        where: "id=?", whereArgs: [todo.id]);
    return guncellenenKayitSaiyisi;
  }

  /// Mevcut bir todo'yu günceller
  @override
  Future<int> updateTodo({required Todo todo}) async {
    // Veritabanı bağlantısını al
    final db = await _sqlDatabaseService.database;

    // Todo'yu güncelle
    int guncellenenKayitSaiyisi = await db.update(
      DatabaseConstants.todoTable,
      todo.toMap(),
      where: "id=?", // WHERE koşulu
      whereArgs: [todo.id], // WHERE parametresi
    );
    return guncellenenKayitSaiyisi;
  }
}
