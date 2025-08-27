import '../../app/app.locator.dart';
import '../../data/datasource/sql_datasource_impl.dart';
import '../../services/sql_database_service.dart';

final usedDatabase = SqlDatasourceImpl(
  sqlDatabaseService: locator<SqlDatabaseService>(),
);
