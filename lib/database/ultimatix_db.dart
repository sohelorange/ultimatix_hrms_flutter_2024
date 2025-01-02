import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:ultimatix_hrms_flutter/database/ultimatix_dao.dart';
import 'clock_in_out_entity.dart';
import 'location_entity.dart';

part 'ultimatix_db.g.dart';

@Database(version: 1, entities: [ClockInOutEntity, LocationEntity])
abstract class UltimatixDb extends FloorDatabase {
  UltimatixDao get localDao;
}
