import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:ultimatix_hrms_flutter/database/ultimatix_dao.dart';
import 'package:ultimatix_hrms_flutter/database/ultimatix_db.dart';

class DatabaseHelper {
  // Private constructor to prevent instantiation
  DatabaseHelper._();

  // Singleton instance
  // ignore: unused_field
  static final DatabaseHelper _instance = DatabaseHelper._();

  // Database instance
  static UltimatixDb? _database;

  // Getter for the database instance
  static Future<UltimatixDb> get database async {
    if (_database != null) {
      return _database!;
    } else {
      // Initialize the database if it is not already done
      _database = await _initDatabase();
      return _database!;
    }
  }

  // Initialize the database
  static Future<UltimatixDb> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'ultimatix_db.db');
    return await $FloorUltimatixDb.databaseBuilder(path).build();
  }

  // Access DAO here
  static Future<UltimatixDao> get localDao async {
    final db = await database;
    return db.localDao;
  }
}
