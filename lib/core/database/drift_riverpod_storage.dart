import 'dart:async';
import 'package:riverpod/experimental/persist.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'app_database.dart';

part 'drift_riverpod_storage.g.dart';

final class DriftRiverpodStorage extends Storage<String, String> {
  final AppDatabase db;

  DriftRiverpodStorage(this.db) : super();

  @override
  Future<PersistedData<String>?> read(String key) async {
    final query = db.select(db.keyValueStore)..where((t) => t.key.equals(key));
    final result = await query.getSingleOrNull();
    if (result != null) {
      return PersistedData(
        result.value,
        destroyKey: result.destroyKey,
        expireAt: result.expireAt?.toUtc(),
      );
    }
    return null;
  }

  @override
  FutureOr<void> write(String key, String value, StorageOptions options) async {
    final now = DateTime.now().toUtc();
    final expireAt = switch (options.cacheTime.duration) {
      null => null,
      final duration => now.add(duration),
    };

    await db
        .into(db.keyValueStore)
        .insertOnConflictUpdate(
          KeyValueStoreCompanion(
            key: Value(key),
            value: Value(value),
            destroyKey: Value(options.destroyKey),
            expireAt: Value(expireAt),
          ),
        );
  }

  @override
  FutureOr<void> delete(String key) async {
    await (db.delete(db.keyValueStore)..where((t) => t.key.equals(key))).go();
  }

  @override
  void deleteOutOfDate() {
    unawaited(_deleteOutOfDateInternal());
  }

  Future<void> _deleteOutOfDateInternal() async {
    final now = DateTime.now().toUtc();
    await (db.delete(
      db.keyValueStore,
    )..where((t) => t.expireAt.isNotNull() & t.expireAt.isSmallerOrEqualValue(now))).go();
  }
}

@riverpod
DriftRiverpodStorage driftRiverpodStorage(Ref ref) {
  return DriftRiverpodStorage(ref.read(appDatabaseProvider));
}
