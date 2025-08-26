/// DatabaseService
/// - Sqflite veritabanini acar, versiyon/migration yonetimini yapar.
/// - En onemli guvenlik: onOpen icinde "CREATE TABLE IF NOT EXISTS" calistirarak,
///   daha once olusmus ama tabloyu icermeyen DB dosyalarinda da tabloyu garanti eder.
/// - Boylece "no such table: todos" benzeri hatalar engellenir.

import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import '../core/constants/database_constants.dart';

class SqlDatabaseService {
  Database? _db;

  // Ilk surum icin 1 yeterli. Tabloyu onOpen'da da garanti altina aldigimiz icin
  // surumu arttirmaya gerek yok. (Ileride migration lazim olursa artiririz.)
  final int _dbVersion = 1;

  /// Veritabani dosyasini acar (idempotent).
  Future<void> init() async {
    if (_db != null) return;

    final String dbDir = await getDatabasesPath();
    final String dbPath = path.join(dbDir, DatabaseConstants.databaseName);

    _db = await openDatabase(
      dbPath,
      version: _dbVersion,
      onCreate: (db, version) async {
        // Ilk kurulumda tabloyu olustur
        await _createTables(db);
      },
      onOpen: (db) async {
        // DB daha once olusmus olabilir; tabloyu yine de garanti et
        await _ensureSchema(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Ileride surum artarsa buraya migration adimlari gelecek.
      },
    );
  }

  /// Disariya her zaman hazir bir Database verir.
  Future<Database> get database async {
    if (_db == null) {
      await init();
    }
    return _db!;
  }

  /// Uygulama kapanirken cagrilabilir.
  Future<void> close() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }

  // --------------------- Dahili Yardimcilar ---------------------

  /// Ilk kurulumda tablo olusturma
  Future<void> _createTables(Database db) async {
    await db.execute('''
      CREATE TABLE ${DatabaseConstants.todoTable} (
        ${DatabaseConstants.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DatabaseConstants.columnTitle} TEXT NOT NULL,
        ${DatabaseConstants.columnContent} TEXT,
        ${DatabaseConstants.columnIsDone} INTEGER NOT NULL DEFAULT 0
      );
    ''');

    // Index lazim olursa buradan ekleyebilirsin:
    // await db.execute('CREATE INDEX IF NOT EXISTS idx_todos_done ON ${DatabaseConstants.todoTable}(${DatabaseConstants.columnIsDone});');
  }

  /// Her acilista semayi garanti eder (tablo yoksa olusturur).
  Future<void> _ensureSchema(Database db) async {
    // IF NOT EXISTS ile tabloyu garanti altina al
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${DatabaseConstants.todoTable} (
        ${DatabaseConstants.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DatabaseConstants.columnTitle} TEXT NOT NULL,
        ${DatabaseConstants.columnContent} TEXT,
        ${DatabaseConstants.columnIsDone} INTEGER NOT NULL DEFAULT 0
      );
    ''');

    // Gerekirse indexleri de garanti edebilirsin:
    // await db.execute('CREATE INDEX IF NOT EXISTS idx_todos_done ON ${DatabaseConstants.todoTable}(${DatabaseConstants.columnIsDone});');
  }
}
