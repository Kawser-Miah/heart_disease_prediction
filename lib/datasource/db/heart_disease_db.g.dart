// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'heart_disease_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $HeartDiseaseDbBuilderContract {
  /// Adds migrations to the builder.
  $HeartDiseaseDbBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $HeartDiseaseDbBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<HeartDiseaseDb> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorHeartDiseaseDb {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $HeartDiseaseDbBuilderContract databaseBuilder(String name) =>
      _$HeartDiseaseDbBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $HeartDiseaseDbBuilderContract inMemoryDatabaseBuilder() =>
      _$HeartDiseaseDbBuilder(null);
}

class _$HeartDiseaseDbBuilder implements $HeartDiseaseDbBuilderContract {
  _$HeartDiseaseDbBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $HeartDiseaseDbBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $HeartDiseaseDbBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<HeartDiseaseDb> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$HeartDiseaseDb();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$HeartDiseaseDb extends HeartDiseaseDb {
  _$HeartDiseaseDb([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  HealthAssessmentDao? _healthAssessmentDaoInstance;

  FactorContributionDao? _factorContributionDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `HealthAssessmentEntity` (`id` TEXT NOT NULL, `date` TEXT NOT NULL, `prediction` INTEGER NOT NULL, `riskLevel` TEXT NOT NULL, `riskPercentage` REAL NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `FactorContribution` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `foreignKey` TEXT, `type` TEXT NOT NULL, `factorName` TEXT NOT NULL, `impact` TEXT NOT NULL, `contribution` REAL NOT NULL, `explanation` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  HealthAssessmentDao get healthAssessmentDao {
    return _healthAssessmentDaoInstance ??=
        _$HealthAssessmentDao(database, changeListener);
  }

  @override
  FactorContributionDao get factorContributionDao {
    return _factorContributionDaoInstance ??=
        _$FactorContributionDao(database, changeListener);
  }
}

class _$HealthAssessmentDao extends HealthAssessmentDao {
  _$HealthAssessmentDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _healthAssessmentEntityInsertionAdapter = InsertionAdapter(
            database,
            'HealthAssessmentEntity',
            (HealthAssessmentEntity item) => <String, Object?>{
                  'id': item.id,
                  'date': item.date,
                  'prediction': item.prediction ? 1 : 0,
                  'riskLevel': item.riskLevel,
                  'riskPercentage': item.riskPercentage
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<HealthAssessmentEntity>
      _healthAssessmentEntityInsertionAdapter;

  @override
  Future<List<HealthAssessmentEntity>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM HealthAssessmentEntity',
        mapper: (Map<String, Object?> row) => HealthAssessmentEntity(
            id: row['id'] as String,
            date: row['date'] as String,
            prediction: (row['prediction'] as int) != 0,
            riskLevel: row['riskLevel'] as String,
            riskPercentage: row['riskPercentage'] as double));
  }

  @override
  Future<void> deleteHealthAssessment(String id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM HealthAssessmentEntity WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertHealthAssessment(HealthAssessmentEntity entity) async {
    await _healthAssessmentEntityInsertionAdapter.insert(
        entity, OnConflictStrategy.abort);
  }
}

class _$FactorContributionDao extends FactorContributionDao {
  _$FactorContributionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _factorContributionInsertionAdapter = InsertionAdapter(
            database,
            'FactorContribution',
            (FactorContribution item) => <String, Object?>{
                  'id': item.id,
                  'foreignKey': item.foreignKey,
                  'type': item.type,
                  'factorName': item.factorName,
                  'impact': item.impact,
                  'contribution': item.contribution,
                  'explanation': item.explanation
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FactorContribution>
      _factorContributionInsertionAdapter;

  @override
  Future<List<FactorContribution>> getAll(String foreignKey) async {
    return _queryAdapter.queryList(
        'SELECT * FROM FactorContribution WHERE foreignKey = ?1',
        mapper: (Map<String, Object?> row) => FactorContribution(
            id: row['id'] as int?,
            foreignKey: row['foreignKey'] as String?,
            type: row['type'] as String,
            factorName: row['factorName'] as String,
            impact: row['impact'] as String,
            contribution: row['contribution'] as double,
            explanation: row['explanation'] as String),
        arguments: [foreignKey]);
  }

  @override
  Future<void> deleteByForeignKey(String foreignKey) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM FactorContribution WHERE foreignKey = ?1',
        arguments: [foreignKey]);
  }

  @override
  Future<void> insertFactorContribution(List<FactorContribution> entity) async {
    await _factorContributionInsertionAdapter.insertList(
        entity, OnConflictStrategy.abort);
  }
}
