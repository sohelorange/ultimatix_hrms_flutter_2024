class GeoFenceModel {
  bool? status;
  int? code;
  String? message;
  List<Data>? data;

  GeoFenceModel({this.status, this.code, this.message, this.data});

  GeoFenceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? empGeoLocationID;
  int? empID;
  int? cmpID;
  String? effectiveDate;
  int? geoLocationID;
  int? meter;
  String? geoLocation;
  String? latitude;
  String? longitude;

  Data(
      {this.empGeoLocationID,
      this.empID,
      this.cmpID,
      this.effectiveDate,
      this.geoLocationID,
      this.meter,
      this.geoLocation,
      this.latitude,
      this.longitude});

  Data.fromJson(Map<String, dynamic> json) {
    empGeoLocationID = json['Emp_Geo_Location_ID'];
    empID = json['Emp_ID'];
    cmpID = json['Cmp_ID'];
    effectiveDate = json['Effective_Date'];
    geoLocationID = json['Geo_Location_ID'];
    meter = json['Meter'];
    geoLocation = json['Geo_Location'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Emp_Geo_Location_ID'] = empGeoLocationID;
    data['Emp_ID'] = empID;
    data['Cmp_ID'] = cmpID;
    data['Effective_Date'] = effectiveDate;
    data['Geo_Location_ID'] = geoLocationID;
    data['Meter'] = meter;
    data['Geo_Location'] = geoLocation;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    return data;
  }
}
