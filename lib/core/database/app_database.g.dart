// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $KeyValueStoreTable extends KeyValueStore
    with TableInfo<$KeyValueStoreTable, KeyValueStoreData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KeyValueStoreTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _destroyKeyMeta = const VerificationMeta(
    'destroyKey',
  );
  @override
  late final GeneratedColumn<String> destroyKey = GeneratedColumn<String>(
    'destroy_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expireAtMeta = const VerificationMeta(
    'expireAt',
  );
  @override
  late final GeneratedColumn<DateTime> expireAt = GeneratedColumn<DateTime>(
    'expire_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, destroyKey, expireAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'key_value_store';
  @override
  VerificationContext validateIntegrity(
    Insertable<KeyValueStoreData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('destroy_key')) {
      context.handle(
        _destroyKeyMeta,
        destroyKey.isAcceptableOrUnknown(data['destroy_key']!, _destroyKeyMeta),
      );
    }
    if (data.containsKey('expire_at')) {
      context.handle(
        _expireAtMeta,
        expireAt.isAcceptableOrUnknown(data['expire_at']!, _expireAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  KeyValueStoreData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KeyValueStoreData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      destroyKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}destroy_key'],
      ),
      expireAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expire_at'],
      ),
    );
  }

  @override
  $KeyValueStoreTable createAlias(String alias) {
    return $KeyValueStoreTable(attachedDatabase, alias);
  }
}

class KeyValueStoreData extends DataClass
    implements Insertable<KeyValueStoreData> {
  final String key;
  final String value;
  final String? destroyKey;
  final DateTime? expireAt;
  const KeyValueStoreData({
    required this.key,
    required this.value,
    this.destroyKey,
    this.expireAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    if (!nullToAbsent || destroyKey != null) {
      map['destroy_key'] = Variable<String>(destroyKey);
    }
    if (!nullToAbsent || expireAt != null) {
      map['expire_at'] = Variable<DateTime>(expireAt);
    }
    return map;
  }

  KeyValueStoreCompanion toCompanion(bool nullToAbsent) {
    return KeyValueStoreCompanion(
      key: Value(key),
      value: Value(value),
      destroyKey: destroyKey == null && nullToAbsent
          ? const Value.absent()
          : Value(destroyKey),
      expireAt: expireAt == null && nullToAbsent
          ? const Value.absent()
          : Value(expireAt),
    );
  }

  factory KeyValueStoreData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KeyValueStoreData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      destroyKey: serializer.fromJson<String?>(json['destroyKey']),
      expireAt: serializer.fromJson<DateTime?>(json['expireAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'destroyKey': serializer.toJson<String?>(destroyKey),
      'expireAt': serializer.toJson<DateTime?>(expireAt),
    };
  }

  KeyValueStoreData copyWith({
    String? key,
    String? value,
    Value<String?> destroyKey = const Value.absent(),
    Value<DateTime?> expireAt = const Value.absent(),
  }) => KeyValueStoreData(
    key: key ?? this.key,
    value: value ?? this.value,
    destroyKey: destroyKey.present ? destroyKey.value : this.destroyKey,
    expireAt: expireAt.present ? expireAt.value : this.expireAt,
  );
  KeyValueStoreData copyWithCompanion(KeyValueStoreCompanion data) {
    return KeyValueStoreData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      destroyKey: data.destroyKey.present
          ? data.destroyKey.value
          : this.destroyKey,
      expireAt: data.expireAt.present ? data.expireAt.value : this.expireAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KeyValueStoreData(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('destroyKey: $destroyKey, ')
          ..write('expireAt: $expireAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, destroyKey, expireAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KeyValueStoreData &&
          other.key == this.key &&
          other.value == this.value &&
          other.destroyKey == this.destroyKey &&
          other.expireAt == this.expireAt);
}

class KeyValueStoreCompanion extends UpdateCompanion<KeyValueStoreData> {
  final Value<String> key;
  final Value<String> value;
  final Value<String?> destroyKey;
  final Value<DateTime?> expireAt;
  final Value<int> rowid;
  const KeyValueStoreCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.destroyKey = const Value.absent(),
    this.expireAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KeyValueStoreCompanion.insert({
    required String key,
    required String value,
    this.destroyKey = const Value.absent(),
    this.expireAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<KeyValueStoreData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<String>? destroyKey,
    Expression<DateTime>? expireAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (destroyKey != null) 'destroy_key': destroyKey,
      if (expireAt != null) 'expire_at': expireAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KeyValueStoreCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<String?>? destroyKey,
    Value<DateTime?>? expireAt,
    Value<int>? rowid,
  }) {
    return KeyValueStoreCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      destroyKey: destroyKey ?? this.destroyKey,
      expireAt: expireAt ?? this.expireAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (destroyKey.present) {
      map['destroy_key'] = Variable<String>(destroyKey.value);
    }
    if (expireAt.present) {
      map['expire_at'] = Variable<DateTime>(expireAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KeyValueStoreCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('destroyKey: $destroyKey, ')
          ..write('expireAt: $expireAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $KeyValueStoreTable keyValueStore = $KeyValueStoreTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [keyValueStore];
}

typedef $$KeyValueStoreTableCreateCompanionBuilder =
    KeyValueStoreCompanion Function({
      required String key,
      required String value,
      Value<String?> destroyKey,
      Value<DateTime?> expireAt,
      Value<int> rowid,
    });
typedef $$KeyValueStoreTableUpdateCompanionBuilder =
    KeyValueStoreCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<String?> destroyKey,
      Value<DateTime?> expireAt,
      Value<int> rowid,
    });

class $$KeyValueStoreTableFilterComposer
    extends Composer<_$AppDatabase, $KeyValueStoreTable> {
  $$KeyValueStoreTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get destroyKey => $composableBuilder(
    column: $table.destroyKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expireAt => $composableBuilder(
    column: $table.expireAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$KeyValueStoreTableOrderingComposer
    extends Composer<_$AppDatabase, $KeyValueStoreTable> {
  $$KeyValueStoreTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get destroyKey => $composableBuilder(
    column: $table.destroyKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expireAt => $composableBuilder(
    column: $table.expireAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$KeyValueStoreTableAnnotationComposer
    extends Composer<_$AppDatabase, $KeyValueStoreTable> {
  $$KeyValueStoreTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get destroyKey => $composableBuilder(
    column: $table.destroyKey,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get expireAt =>
      $composableBuilder(column: $table.expireAt, builder: (column) => column);
}

class $$KeyValueStoreTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KeyValueStoreTable,
          KeyValueStoreData,
          $$KeyValueStoreTableFilterComposer,
          $$KeyValueStoreTableOrderingComposer,
          $$KeyValueStoreTableAnnotationComposer,
          $$KeyValueStoreTableCreateCompanionBuilder,
          $$KeyValueStoreTableUpdateCompanionBuilder,
          (
            KeyValueStoreData,
            BaseReferences<
              _$AppDatabase,
              $KeyValueStoreTable,
              KeyValueStoreData
            >,
          ),
          KeyValueStoreData,
          PrefetchHooks Function()
        > {
  $$KeyValueStoreTableTableManager(_$AppDatabase db, $KeyValueStoreTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KeyValueStoreTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KeyValueStoreTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KeyValueStoreTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<String?> destroyKey = const Value.absent(),
                Value<DateTime?> expireAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KeyValueStoreCompanion(
                key: key,
                value: value,
                destroyKey: destroyKey,
                expireAt: expireAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<String?> destroyKey = const Value.absent(),
                Value<DateTime?> expireAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KeyValueStoreCompanion.insert(
                key: key,
                value: value,
                destroyKey: destroyKey,
                expireAt: expireAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$KeyValueStoreTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KeyValueStoreTable,
      KeyValueStoreData,
      $$KeyValueStoreTableFilterComposer,
      $$KeyValueStoreTableOrderingComposer,
      $$KeyValueStoreTableAnnotationComposer,
      $$KeyValueStoreTableCreateCompanionBuilder,
      $$KeyValueStoreTableUpdateCompanionBuilder,
      (
        KeyValueStoreData,
        BaseReferences<_$AppDatabase, $KeyValueStoreTable, KeyValueStoreData>,
      ),
      KeyValueStoreData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$KeyValueStoreTableTableManager get keyValueStore =>
      $$KeyValueStoreTableTableManager(_db, _db.keyValueStore);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'44154e51c3f3079ee293d8ad0ebd1e17cca871ed';
