import 'package:floor/floor.dart';

import 'clock_in_out_entity.dart';
import 'location_entity.dart';

@dao
abstract class UltimatixDao {
  @insert
  Future<void> insertClockInOutDetails(ClockInOutEntity clockInOutEntity);

  @Query(
      "UPDATE ClockInOutEntity SET checkOutTime = :checkOutTime, checkInStatus = :checkInStatus,workHours = :workHours WHERE userId = :userId")
  Future<void> updateClockInOutDetails(
      String checkOutTime, String workHours, String userId, bool checkInStatus);

  @Query("SELECT * FROM ClockInOutEntity WHERE userId = :userId")
  Future<ClockInOutEntity?> getClockInOutRecord(String userId);

  @Query("DELETE FROM ClockInOutEntity")
  Future<void> deleteAllRecords();

  @insert
  Future<void> insertLocations(LocationEntity locationEntity);

  @Query("DELETE FROM LocationEntity")
  Future<void> deleteAllLocations();

  @Query("SELECT DISTINCT longitude,latitude FROM LocationEntity")
  Future<List<LocationEntity>> getAllRecordsFromDb();
}
