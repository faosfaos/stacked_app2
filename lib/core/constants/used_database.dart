import '../../app/app.locator.dart';
import '../../data/datasource/todo_repository_impl.dart';
import '../../services/sql_database_service.dart';

final usedDatabase = TodoRepositoryImpl(
  sqlDatabaseService: locator<SqlDatabaseService>(),
);
