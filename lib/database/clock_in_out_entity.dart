import 'package:floor/floor.dart';

@entity
class ClockInOutEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String? userId;
  final String? workMode;
  final double? latitude;
  final double? longitude;
  final String? imgPath;
  final bool? checkInStatus;
  final String? checkInTime;
  final String? checkOutTime;
  final String? workHours;

  ClockInOutEntity(
      {this.id,
      required this.userId,
      required this.workMode,
      required this.latitude,
      required this.longitude,
      required this.imgPath,
      required this.checkInStatus,
      required this.checkInTime,
      required this.checkOutTime,
      required this.workHours});
}
