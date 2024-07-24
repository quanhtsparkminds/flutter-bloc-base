import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dart:io' as io;

import 'package:myapp/config/env.dart';
import 'package:myapp/domain/localstorage/queires/auth_queries.dart';
import 'package:myapp/domain/model/auth_model/local_auth_model.dart';
import 'package:myapp/shared/utils/my_logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = '${dotenv.env[EnvKeys.databaseName]}';
  static const _databaseVersion = 1;
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? db;

  Future<Database> get database async {
    if (db != null) return db!;
    db = await initSQLLite();
    return db!;
  }

  void setDatabase(Database database) {
    db = database;
  }

  Future<Database> initSQLLite() async {
    // await deleteDatabaseSqflite();
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    var databaseOpen = openDatabase(
      join(documentsDirectory.path, _databaseName),
      version: _databaseVersion,
      onUpgrade: _onUpgradeDB,
      // password: _password,
      onCreate: _onCreateDB,
    );
    return databaseOpen;
  }

  Future<void> deleteTables() async {
    // delete database
    final Database db = await database;
    db.execute('delete from ${LocalAuthByDevicesQueries.table}');
    MyLogger.d('delete success table in app');
  }

  Future<void> deleteDatabaseSqflite() async {
    // delete database
    await deleteDatabase(
      join(await getDatabasesPath(), _databaseName),
    );
    MyLogger.d('delete success database in app');
  }

  Future _onUpgradeDB(Database db, int oldVersion, int newVersion) async {
    await deleteDatabaseSqflite();
    _onCreateDB(db, newVersion);
  }

  Future _onCreateDB(Database db, int version) async {
    /* Create local auth  table */
    await db.execute('''
    CREATE TABLE ${LocalAuthByDevicesQueries.table} (
      ${LocalAuthQuerieseField.id} TEXT PRIMARY KEY,
      ${LocalAuthQuerieseField.pinCode} TEXT,
      ${LocalAuthQuerieseField.deviceId} TEXT,
      ${LocalAuthQuerieseField.userId} TEXT,
      ${LocalAuthQuerieseField.isActiveBiometrics} TEXT
    )
  ''');
    MyLogger.d('create success table ---${LocalAuthByDevicesQueries.table}');
  }

  Future close() async {
    final Database db = await database;
    return db.close();
  }
}
