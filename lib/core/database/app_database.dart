import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class KeyValueStore extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  TextColumn get destroyKey => text().nullable()();
  DateTimeColumn get expireAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(tables: [KeyValueStore])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'agent_pro',
      native: const DriftNativeOptions(databaseDirectory: getApplicationDocumentsDirectory),
    );
  }

  // Add DAOs and other database methods here
}

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
}
