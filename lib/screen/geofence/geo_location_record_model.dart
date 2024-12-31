class GeoLocationrecordList {
  bool? status;
  int? code;
  String? message;
  List<Data>? data;

  GeoLocationrecordList({this.status, this.code, this.message, this.data});

  GeoLocationrecordList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Emp_Geo_Location_ID'] = this.empGeoLocationID;
    data['Emp_ID'] = this.empID;
    data['Cmp_ID'] = this.cmpID;
    data['Effective_Date'] = this.effectiveDate;
    data['Geo_Location_ID'] = this.geoLocationID;
    data['Meter'] = this.meter;
    data['Geo_Location'] = this.geoLocation;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    return data;
  }
}