/// Dependency injection ve data layer bileşenlerinin importları
import '../../app/app.locator.dart';
import '../../data/datasource/todo_repository_impl.dart';
import '../../services/sql_database_service.dart';

/// Database abstraction layer konfigürasyonu
/// Repository pattern implementasyonu ile SQL database service'inin
/// dependency injection container üzerinden inject edildiği singleton instance
final usedDatabase = TodoRepositoryImpl(
  sqlDatabaseService: locator<SqlDatabaseService>(),
);
