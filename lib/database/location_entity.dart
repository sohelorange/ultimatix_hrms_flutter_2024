import 'package:floor/floor.dart';

@entity
class LocationEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final double latitude;
  final double longitude;
  final String? dateTime;
  final bool? gpsOff;

  LocationEntity(
      {this.id,
      required this.latitude,
      required this.longitude,
      required this.dateTime,
      required this.gpsOff});
}
