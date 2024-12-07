// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ultimatix_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $UltimatixDbBuilderContract {
  /// Adds migrations to the builder.
  $UltimatixDbBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $UltimatixDbBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<UltimatixDb> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorUltimatixDb {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $UltimatixDbBuilderContract databaseBuilder(String name) =>
      _$UltimatixDbBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $UltimatixDbBuilderContract inMemoryDatabaseBuilder() =>
      _$UltimatixDbBuilder(null);
}

class _$UltimatixDbBuilder implements $UltimatixDbBuilderContract {
  _$UltimatixDbBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $UltimatixDbBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $UltimatixDbBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<UltimatixDb> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$UltimatixDb();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$UltimatixDb extends UltimatixDb {
  _$UltimatixDb([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UltimatixDao? _localDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `ClockInOutEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `userId` TEXT, `workMode` TEXT, `latitude` REAL, `longitude` REAL, `imgPath` TEXT, `checkInStatus` INTEGER, `checkInTime` TEXT, `checkOutTime` TEXT, `workHours` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `LocationEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `latitude` REAL NOT NULL, `longitude` REAL NOT NULL, `dateTime` TEXT, `gpsOff` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UltimatixDao get localDao {
    return _localDaoInstance ??= _$UltimatixDao(database, changeListener);
  }
}

class _$UltimatixDao extends UltimatixDao {
  _$UltimatixDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _clockInOutEntityInsertionAdapter = InsertionAdapter(
            database,
            'ClockInOutEntity',
            (ClockInOutEntity item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'workMode': item.workMode,
                  'latitude': item.latitude,
                  'longitude': item.longitude,
                  'imgPath': item.imgPath,
                  'checkInStatus': item.checkInStatus == null
                      ? null
                      : (item.checkInStatus! ? 1 : 0),
                  'checkInTime': item.checkInTime,
                  'checkOutTime': item.checkOutTime,
                  'workHours': item.workHours
                }),
        _locationEntityInsertionAdapter = InsertionAdapter(
            database,
            'LocationEntity',
            (LocationEntity item) => <String, Object?>{
                  'id': item.id,
                  'latitude': item.latitude,
                  'longitude': item.longitude,
                  'dateTime': item.dateTime,
                  'gpsOff': item.gpsOff == null ? null : (item.gpsOff! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ClockInOutEntity> _clockInOutEntityInsertionAdapter;

  final InsertionAdapter<LocationEntity> _locationEntityInsertionAdapter;

  @override
  Future<void> updateClockInOutDetails(
    String checkOutTime,
    String workHours,
    String userId,
    bool checkInStatus,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE ClockInOutEntity SET checkOutTime = ?1, checkInStatus = ?4,workHours = ?2 WHERE userId = ?3',
        arguments: [checkOutTime, workHours, userId, checkInStatus ? 1 : 0]);
  }

  @override
  Future<ClockInOutEntity?> getClockInOutRecord(String userId) async {
    return _queryAdapter.query(
        'SELECT * FROM ClockInOutEntity WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => ClockInOutEntity(
            id: row['id'] as int?,
            userId: row['userId'] as String?,
            workMode: row['workMode'] as String?,
            latitude: row['latitude'] as double?,
            longitude: row['longitude'] as double?,
            imgPath: row['imgPath'] as String?,
            checkInStatus: row['checkInStatus'] == null
                ? null
                : (row['checkInStatus'] as int) != 0,
            checkInTime: row['checkInTime'] as String?,
            checkOutTime: row['checkOutTime'] as String?,
            workHours: row['workHours'] as String?),
        arguments: [userId]);
  }

  @override
  Future<void> deleteAllRecords() async {
    await _queryAdapter.queryNoReturn('DELETE FROM ClockInOutEntity');
  }

  @override
  Future<void> deleteAllLocations() async {
    await _queryAdapter.queryNoReturn('DELETE FROM LocationEntity');
  }

  @override
  Future<List<LocationEntity>> getAllRecordsFromDb() async {
    return _queryAdapter.queryList(
        'SELECT DISTINCT longitude,latitude FROM LocationEntity',
        mapper: (Map<String, Object?> row) => LocationEntity(
            id: row['id'] as int?,
            latitude: row['latitude'] as double,
            longitude: row['longitude'] as double,
            dateTime: row['dateTime'] as String?,
            gpsOff:
                row['gpsOff'] == null ? null : (row['gpsOff'] as int) != 0));
  }

  @override
  Future<void> insertClockInOutDetails(
      ClockInOutEntity clockInOutEntity) async {
    await _clockInOutEntityInsertionAdapter.insert(
        clockInOutEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertLocations(LocationEntity locationEntity) async {
    await _locationEntityInsertionAdapter.insert(
        locationEntity, OnConflictStrategy.abort);
  }
}
